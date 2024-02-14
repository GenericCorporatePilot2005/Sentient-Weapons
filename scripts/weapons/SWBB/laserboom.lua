local mod = modApi:getCurrentMod()
--the actual weapon
Nico_laserboom = Nico_laserbot:new{
    Name = "K-b00m Beam Mark I",
	Class = "TechnoVek",
	Icon = "weapons/Nico_laserboom.png",
    Description = "Fire a phasing beam that decreases in damage the further it goes, doesn't damage buildings.",
	Damage = 3,
    SelfDamage = 0,
	PowerCost = 0,
    Phaser=true,
	MinDamage = 1,
	FriendlyDamage = true,
	BuildingDamage = false,
	ZoneTargeting = ZONE_DIR,
	Upgrades = 2,
	UpgradeList = { "+1 Damage Each", "Static Damage, Ally Immune" },
	UpgradeCost = { 1,2 },
	KOSound = "/weapons/arachnoid_ko",
	TipImage = {
		Unit = Point(2,4),
		Enemy = Point(2,3),
		Friendly = Point(2,2),
		Target = Point(2,3),
		Mountain = Point(2,1),
		Building = Point(2,0),
        CustomPawn = "Nico_laserboom_mech",
	}
}

Nico_laserboom_A = Nico_laserboom:new{
    LaserArt = "effects/laser_push",
    UpgradeDescription = "Increases damage by 1 and damages self. On kill, create a Bloom-Laser.",
	Damage = 4,
	SelfDamage=1,
	TipImage = {
		Unit = Point(2,4),
		Enemy1 = Point(2,3),
		Enemy2 = Point(2,2),
		Target = Point(2,3),
		Mountain = Point(2,1),
		Building = Point(2,0),
		CustomEnemy="Scorpion1",
        CustomPawn="Nico_laserboom_mech",
	}
}

function Nico_laserboom:GetTargetArea(point)
	local ret = PointList()
	for dir = DIR_START, DIR_END do
		local curr = point + DIR_VECTORS[dir]
		while Board:IsValid(curr) do
			ret:push_back(curr)
			curr = curr + DIR_VECTORS[dir]
		end
		
		if Board:IsValid(curr) then
			ret:push_back(curr)
		end
	end
	
	return ret
end
function Nico_laserboom:AddLaser(ret,point,direction)
	local queued = queued or false
	local minDamage = self.MinDamage or 1
	local damage = self.Damage
	local start = point - DIR_VECTORS[direction]
	if self.SelfDamage == 1 then ret:AddDamage(SpaceDamage(start, 1)) end
	while Board:IsValid(point) do
	
		local temp_damage = damage
		
		if (not self.FriendlyDamage and Board:IsPawnTeam(point, TEAM_PLAYER)) or (not self.BuildingDamage and Board:IsBuilding(point)) then
			temp_damage = DAMAGE_ZERO
		end
		
		local dam = SpaceDamage(point, temp_damage)
		
		dam.iSmoke = self.Smoke
		dam.iAcid = self.Acid
		dam.iFire = self.Fire
		dam.iFrozen = self.Freeze
		
		-- if it's the end of the line (ha), add the laser art -- not pretty
		if forced_end == point or not Board:IsValid(point + DIR_VECTORS[direction]) then
			if queued then 
				ret:AddQueuedProjectile(dam,self.LaserArt)
			else
				ret:AddProjectile(start,dam,self.LaserArt,FULL_DELAY)
			end
			break
		else
			ret:AddDamage(dam)
		end
		
		damage = damage - 1
		if damage < minDamage then damage = minDamage end
					
		point = point + DIR_VECTORS[direction]	
	end
	if self.SelfDamage==1 then
		for i = 1,ret.effect:size() do
			ret.effect:index(i).bKO_Effect = Board:IsDeadly(ret.effect:index(i),Pawn) and (ret.effect:index(i).loc ~= start or (ret.effect:index(i).loc == start and Board:IsCracked(ret.effect:index(i).loc)))
			if ret.effect:index(i).bKO_Effect and ret.effect:index(i).loc ~= p1 then
				ret:AddSound("/weapons/arachnoid_ko")
				local damage = SpaceDamage(ret.effect:index(i).loc)
				if Board:IsTerrain(ret.effect:index(i).loc,TERRAIN_WATER) or Board:IsTerrain(ret.effect:index(i).loc,TERRAIN_LAVA) or Board:IsTerrain(ret.effect:index(i).loc,TERRAIN_HOLE) or Board:IsCracked(ret.effect:index(i).loc) or (Board:IsTerrain(ret.effect:index(i).loc,TERRAIN_ICE) and Board:IsCracked(ret.effect:index(i).loc)) then
					ret:AddBounce(damage.loc,1)
					damage.sPawn = "Copter_Bloom_Bot"
					damage.bKO_Effect = true
					ret:AddSound(self.KOSound)
					ret:AddArtillery(damage,"effects/shotup_Nico_Copter_Bloom.png", FULL_DELAY)
				else
					ret:AddAnimation(damage.loc,"Nico_Laser_Bloome", ANIM_NO_DELAY)
					ret:AddDelay(1.45)
					ret:AddBounce(damage.loc,1)
					damage.sPawn = "Nico_laserbloom"
					damage.bKO_Effect = true
					ret:AddSound(self.KOSound)
					ret:AddDamage(damage)
				end
				if Board:IsTerrain(ret.effect:index(i).loc,TERRAIN_LAVA) then--this checks that the tile the copter spawns is a lava tile
					local minifire = SpaceDamage(ret.effect:index(i).loc)
					minifire.iFire = 1
					ret:AddDamage(minifire)
				end
				if Board:IsAcid(ret.effect:index(i).loc) and Board:IsTerrain(ret.effect:index(i).loc,TERRAIN_WATER) then --this does the same but for acid water
					local miniacid = SpaceDamage(ret.effect:index(i).loc)
					miniacid.iAcid = 1
					ret:AddDamage(miniacid)
				end
			elseif ret.effect:index(i).bKO_Effect and ret.effect:index(i).loc == p1 then
				ret.effect:index(i).bKO_Effect = false
			end
		end
	end
end
Nico_laserboom_B = Nico_laserboom:new{
    MinDamage = 3,
	FriendlyDamage = false,
    UpgradeDescription = "Damage doesn't decrease and no longer damages friendly units.",
}

Nico_laserboom_AB = Nico_laserboom_A:new{
    Damage = 4,
    MinDamage = 4,
	FriendlyDamage = false,
}

modApi:addWeaponDrop("Nico_laserboom")

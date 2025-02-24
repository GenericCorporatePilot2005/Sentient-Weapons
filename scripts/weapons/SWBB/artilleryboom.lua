local mod = modApi:getCurrentMod()
--the actual weapon
------Artillery Bot------
Nico_artilleryboom = Nico_artillerybot:new{
	Name = "Bang Rockets Mark I",
	Class = "TechnoVek",
	Icon = "weapons/support_missiles.png",
	Description = "Launch Rockets at 3 tiles.",
	BounceAmount = 2,
	Damage = 1,
	SelfDamage = 0,
	PowerCost = 0,
	BuildingDamage = true,
	TwoClick = true,
	Upgrades = 2,
	UpgradeList = { "+1 Damage Each",  "+1 Damage"  },
	UpgradeCost = {1,3},
	LaunchSound = "/enemy/snowart_1/attack",
	ImpactSound = "/impact/generic/explosion",
	KOSound = "/weapons/arachnoid_ko",
	CustomTipImage = "",
	TipImage = {
		Unit = Point(3,3),
		Target = Point(3,2),
		Enemy1 = Point(1,1),
		Enemy2 = Point(3,1),
		Mountain1 = Point(1,0),
		Mountain2 = Point(3,0),
		Second_Click = Point(1,1),
		Second_Origin = Point(3,3),
		Second_Target = Point(3,1),
        CustomPawn="Nico_artilleryboom_mech",
		CustomEnemy="Scorpion1",
	},
	}
function Nico_artilleryboom:GetTargetArea(point)
	local ret = PointList()
	for dir = DIR_START, DIR_END do
		for i = 1, 8 do
			if Board:IsValid(point + DIR_VECTORS[dir]*math.max(2,i)) then
				ret:push_back(point + DIR_VECTORS[dir]*i)
			end
		end
	end
	return ret
end
function Nico_artilleryboom:GetSecondTargetArea(p1,p2)
	local ret = PointList()
	local dir = GetDirection(p2 - p1)
	if p1:Manhattan(p2) == 1 then
		for i = 1, 8 do
			for j = 1, 8 do
				if Board:IsValid(p2 + DIR_VECTORS[dir]*i + DIR_VECTORS[(dir+1)%4]*j) then ret:push_back(p2 + DIR_VECTORS[dir]*i + DIR_VECTORS[(dir+1)%4]*j) end
				if Board:IsValid(p2 + DIR_VECTORS[dir]*i + DIR_VECTORS[(dir-1)%4]*j) then ret:push_back(p2 + DIR_VECTORS[dir]*i + DIR_VECTORS[(dir-1)%4]*j) end
			end
		end
	else
		for j = 1, 8 do
			if Board:IsValid(p2 + DIR_VECTORS[(dir+1)%4]*j) then ret:push_back(p2 + DIR_VECTORS[(dir+1)%4]*j) end
			if Board:IsValid(p2 + DIR_VECTORS[(dir-1)%4]*j) then ret:push_back(p2 + DIR_VECTORS[(dir-1)%4]*j) end
		end
	end
	return ret
end
function Nico_artilleryboom:GetSkillEffect(p1,p2)
	local ret = SkillEffect()
	local direction = GetDirection(p1-p2)
	ret:AddDamage(SpaceDamage(p1,self.SelfDamage))
	if p1:Manhattan(p2) > 1 then ret:AddArtillery(SpaceDamage(p2,self.Damage,direction), "effects/shotup_missileswarm.png", NO_DELAY) end
	return ret
end
function Nico_artilleryboom:GetFinalEffect(p1,p2,p3)
	local ret = SkillEffect()
	local direction = GetDirection(p2-p1)
	local distance = p3:Manhattan(p2)
	local projected_distance = (p1.x == p2.x and math.abs(p3.x - p2.x)) or (p1.y == p2.y and math.abs(p3.y - p2.y))
	local projected_dir = GetDirection((p1.x == p2.x and Point(p1.x,p3.y) - p3) or (p1.y == p2.y and Point(p3.x,p1.y) - p3))
	local dir = GetDirection(p2-p3)
	ret:AddDamage(SpaceDamage(p1,self.SelfDamage))
	ret:AddBounce(p1,self.BounceAmount)
	if self.SelfDamage==1 then
		local KillLoc = p1 + DIR_VECTORS[GetDirection(p1 - p2)]
		local damage = SpaceDamage(KillLoc,self.Damage)
		damage.sAnimation = "explopush"..((self.Damage < 2 and 1) or 2).."_"..(direction+2)%4
		if Board:IsPawnSpace(KillLoc) then
			damage.bKO_Effect = Board:IsDeadly(damage, Pawn)
			if damage.bKO_Effect then
				damage.bKO_Effect = true
				ret:AddDamage(damage)
				ret:AddSound(self.KOSound)
				local damage = SpaceDamage(damage.loc,0)
				if Board:IsTerrain(damage.loc,TERRAIN_WATER) or Board:IsTerrain(damage.loc,TERRAIN_LAVA) or Board:IsTerrain(damage.loc,TERRAIN_HOLE) or Board:IsCracked(damage.loc) or (Board:IsTerrain(damage.loc,TERRAIN_ICE) and Board:IsCracked(damage.loc)) then
					ret:AddBounce(damage.loc,1)
					damage.sPawn = "Copter_Bloom_Bot"
					ret:AddArtillery(damage,"effects/shotup_Nico_Copter_Bloom.png", FULL_DELAY)
				else
					ret:AddAnimation(damage.loc,"Nico_Artillery_Bloome", ANIM_DELAY)
					damage.sPawn = "Nico_artillerybloom"
					ret:AddDamage(damage)
				end
				if Board:IsTerrain(damage.loc,TERRAIN_LAVA) then--this checks that the tile the copter spawns is a lava tile
					local minifire = SpaceDamage(damage.loc)
					minifire.iFire = 1
					ret:AddDamage(minifire)
				end
				if Board:IsAcid(damage.loc) and Board:IsTerrain(damage.loc,TERRAIN_WATER) then --this does the same but for acid water
					local miniacid = SpaceDamage(damage.loc)
					miniacid.iAcid = 1
					ret:AddDamage(miniacid)
				end
			else
				ret:AddDamage(damage)
			end
		else
			ret:AddDamage(damage)
		end
	end
	if p1:Manhattan(p2) == 1 then
		local dam = SpaceDamage(p3,self.Damage,direction)
		dam.sAnimation = "explopush"..((self.Damage < 2 and 1) or 2).."_"..direction
		ret:AddArtillery(dam, "effects/shotup_missileswarm.png", NO_DELAY)
		dam.loc = p3+DIR_VECTORS[projected_dir]*projected_distance
		ret:AddArtillery(dam, "effects/shotup_missileswarm.png", NO_DELAY)
		dam.loc = p3+DIR_VECTORS[projected_dir]*projected_distance*2
		ret:AddArtillery(dam, "effects/shotup_missileswarm.png", NO_DELAY)
		ret:AddDelay(0.8)
		ret:AddBounce(p3, self.BounceAmount)
		ret:AddBounce(p3+DIR_VECTORS[projected_dir]*projected_distance, self.BounceAmount)
		ret:AddBounce(p3+DIR_VECTORS[projected_dir]*projected_distance*2, self.BounceAmount)
	else
		local dam = SpaceDamage(p2,self.Damage,(direction+2)%4)
		dam.sAnimation = "explopush"..((self.Damage < 2 and 1) or 2).."_"..(direction+2)%4
		ret:AddArtillery(dam, "effects/shotup_missileswarm.png")
		ret:AddBounce(p2,self.BounceAmount)
		dam = SpaceDamage(p3,self.Damage,GetDirection(p3 - p2))
		dam.sAnimation = "explopush"..((self.Damage < 2 and 1) or 2).."_"..GetDirection(p3 - p2)
		ret:AddArtillery(p2, dam, "effects/shotup_missileswarm.png", NO_DELAY)
		dam = SpaceDamage(p3+DIR_VECTORS[dir]*distance*2,self.Damage,dir)
		dam.sAnimation = "explopush"..((self.Damage < 2 and 1) or 2).."_"..dir
		ret:AddArtillery(p2, dam, "effects/shotup_missileswarm.png", NO_DELAY)
		ret:AddDelay(0.8)
		ret:AddBounce(p3, self.BounceAmount)
		ret:AddBounce(p3+DIR_VECTORS[dir]*distance*2, self.BounceAmount)
	end
	return ret
end
	Nico_artilleryboom_A=Nico_artilleryboom:new{
		BounceAmount = 3,
		Damage = 2,
		SelfDamage = 1,
		UpgradeDescription = "Deals 1 additional damage to all targets and damages self.\nAttacks the tile behind, if it has a unit, and the attack kills, create a Bloom-Artillery.",
		CustomTipImage = "",
		TipImage = {
			Unit = Point(3,3),
			Target = Point(3,2),
			Enemy1 = Point(1,1),
			Enemy2 = Point(3,1),
			Enemy3 = Point(3,4),
			Mountain1 = Point(1,0),
			Mountain2 = Point(3,0),
			Second_Click = Point(1,1),
			Second_Origin = Point(3,3),
			Second_Target = Point(3,1),
			CustomPawn = "Nico_artilleryboom_mech",
			CustomEnemy = "Mosquito1",
		},
	}
	Nico_artilleryboom_B=Nico_artilleryboom:new{
		BounceAmount = 3,
		Damage = 2,
		UpgradeDescription = "Deals 1 additional damage to all targets.",
		CustomTipImage = "",
	}
	Nico_artilleryboom_AB=Nico_artilleryboom_A:new{
		BounceAmount = 3,
		Damage = 3,
		SelfDamage = 1,
		CustomTipImage = "",
	}

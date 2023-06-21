Nico_laserboom=Nico_laserbot:new{
    Name="K-b00m Beam Mark I",
	Class="TechnoVek",
	Icon = "weapons/Nico_laserboom.png",
    Description="Fire a piercing beam that decreases in damage the further it goes, doesn't damage allies.",
	Explosion = "",
	Sound = "",
	Damage = 3,
    SelfDamage=1,
	PowerCost = 0,
    Piercer=false,
	MinDamage = 1,
	FriendlyDamage = false,
	ZoneTargeting = ZONE_DIR,
	Upgrades = 2,
	UpgradeList = { "Piercer", "+1 Damage" },
	UpgradeCost = { 2,3 },
	TipImage = {
		Unit = Point(2,4),
		Enemy = Point(2,2),
		Friendly = Point(2,1),
		Target = Point(2,2),
		Mountain = Point(2,0),
        CustomPawn="Nico_laserboom_mech",
	}
}

local path = mod_loader.mods[modApi.currentMod].resourcePath
modApi:appendAsset("img/weapons/Nico_laserboom.png", path .."img/weapons/Nico_laserboom.png")

Nico_laserboom_A = Nico_laserboom:new{
    LaserArt = "effects/laser_push",
    UpgradeDescription = "The laser can pierce through mountains AND BUILDINGS.",
    Piercer=true,
    TipImage = {
        Unit = Point(2,4),
        Friendly = Point(2,3),
        Mountain = Point(2,2),
        Target = Point(2,0),
        Enemy1 = Point(2,0),
        CustomEnemy = "Digger1",
        CustomPawn="Nico_laserboom_mech",
    },
}

function Nico_laserboom_A:GetTargetArea(point)
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
function Nico_laserboom_A:AddLaser(ret,point,direction)
	local queued = queued or false
	local minDamage = self.MinDamage or 1
	local damage = self.Damage
	local start = point - DIR_VECTORS[direction]
	--if forced_end ~= nil then
	--	LOG("Forced end = "..forced_end:GetString())
	--else
	--	LOG("No forced end!")
	--end
	while Board:IsValid(point) do
	
		local temp_damage = damage  --This is so that if damage is set to 0 because of an ally, it doesn't affect the damage calculation of the laser.
		
		if not self.FriendlyDamage and Board:IsPawnTeam(point, TEAM_PLAYER) or (self.Damage==4 and Board:IsBuilding(point)) then
			temp_damage = DAMAGE_ZERO
		end
		
		local dam = SpaceDamage(point, temp_damage)
		
		dam.iSmoke = self.Smoke
		dam.iAcid = self.Acid
		dam.iFire = self.Fire
		dam.iFrozen = self.Freeze
		
		ret:AddProjectile(start,dam,self.LaserArt,FULL_DELAY)
		
		damage = damage - 1
		if damage < minDamage then damage = minDamage end
					
		point = point + DIR_VECTORS[direction]	
	end
end
Nico_laserboom_B = Nico_laserboom:new{
    Damage = 4,
    MinDamage=4,
    UpgradeDescription = "Damage doesn't decrease.\nWhen 'Piercer' is powered on, won't deal damage to buildings",
}

Nico_laserboom_AB = Nico_laserboom_A:new{
    Damage = 4,
}

modApi:addWeaponDrop("Nico_laserboom")
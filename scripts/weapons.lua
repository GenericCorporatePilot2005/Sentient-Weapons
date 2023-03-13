Nico_laserbot = LaserDefault:new{
    Name="BKR Beam Mark II",
	Class="TechnoVek",
	Icon = "weapons/prime_laser.png",
    Description="Fire a piercing beam that decreases in damage the further it goes, doesn't damage allies.",
	Rarity = 3,
	Explosion = "",
	Sound = "",
	Damage = 2,
	PowerCost = 0, --AE Change
	MinDamage = 1,
	FriendlyDamage = false,
	ZoneTargeting = ZONE_DIR,
	Upgrades = 2,
	UpgradeList = { "Freeze", "+2 Damage" },
	UpgradeCost = { 2,3 },
	TipImage = {
		Unit = Point(2,4),
		Enemy = Point(2,2),
		Friendly = Point(2,1),
		Target = Point(2,2),
		Mountain = Point(2,0),
        CustomPawn="Nico_laserbot_mech",
	}
}
Nico_laserbot_A = Nico_laserbot:new{
    Freeze=1,
    FriendlyDamage = false,
    LaserArt = "effects/laser_freeze",
    UpgradeDescription = "damages and freezes targets",
	TipImage = {
		Unit = Point(2,4),
		Enemy = Point(2,2),
		Friendly = Point(2,1),
		Target = Point(2,2),
		Mountain = Point(2,0),
        CustomPawn="Nico_laserbot_mech",
	},
}
Nico_laserbot_B = Nico_laserbot:new{
	Damage = 4,
    FriendlyDamage = false,
    UpgradeDescription = "+2 more damage",
	TipImage = {
		Unit = Point(2,4),
		Enemy = Point(2,2),
		Friendly = Point(2,1),
		Target = Point(2,2),
		Mountain = Point(2,0),
        CustomPawn="Nico_laserbot_mech",
	},
}
Nico_laserbot_AB = Nico_laserbot:new{
	Damage = 4,
    LaserArt = "effects/laser_freeze",
    Freeze = 1,
    UpgradeDescription = "damages and freezes targets",
	TipImage = {
		Unit = Point(2,4),
		Enemy = Point(2,2),
		Friendly = Point(2,1),
		Target = Point(2,2),
		Mountain = Point(2,0),
        CustomPawn="Nico_laserbot_mech",
	},
}

Nico_cannonbot=Brute_Tankmech:new{
	Name="Cannon 8R Mark II",
	Class="TechnoVek",
	Description="Fire a damaging projectile that applies fire and pushes.",
	Icon = "weapons/brute_tank.png",
	Damage=1,
    Fire = 1,
    Push=1,
	PowerCost=0,
	Upgrades=2,
	UpgradeCost={2,3},
	UpgradeList = { "+1 damage", "+1 damage"},
	Explosion = "ExploAir2",
	Projectile = "effects/shot_mechtank",
	TipImage = {
		Unit = Point(2,3),
		Enemy = Point(2,1),
		Target = Point(2,2),
		CustomPawn = "Nico_cannonbot_mech",
	},
}

Nico_cannonbot_A=Nico_cannonbot:new{
    Damage=2,
    UpgradeDescription = "+1 damage",
	TipImage = {
		Unit = Point(2,3),
		Enemy = Point(2,1),
		Target = Point(2,2),
		CustomPawn = "Nico_cannonbot_mech",
	},
}

Nico_cannonbot_B=Nico_cannonbot:new{
    Damage=2,
    UpgradeDescription = "+1 damage",
    TipImage = {
		Unit = Point(2,3),
		Enemy = Point(2,1),
		Target = Point(2,2),
		CustomPawn = "Nico_cannonbot_mech",
	},
}

Nico_cannonbot_AB=Nico_cannonbot:new{
    Damage=3,
    TipImage = {
		Unit = Point(2,3),
		Enemy = Point(2,1),
		Target = Point(2,2),
		CustomPawn = "Nico_cannonbot_mech",
	},
}

--
Nico_artillerybot=ArtilleryDefault:new{
    Name="Vk8 Rockets Mark II",
    Class = "TechnoVek",
	Icon = "advanced/weapons/Ranged_Crack.png",
    Description="Launch Rockets at 3 tiles.",
	Explosion = "",
	Damage = 1,
	PowerCost = 0,
	BuildingDamage = true,
	Upgrades = 2,
    UpgradeList = { "Building immune",  "+1 Damage"  },
	UpgradeCost = {1,3},
	LaunchSound = "/weapons/ranged_crack",
	ImpactSound = "",
	TipImage = {
		Unit = Point(2,3),
		Target = Point(2,1),
		Enemy = Point(2,1),
		Enemy2 = Point(3,1),
		Enemy3 = Point(1,1),
        CustomPawn="Nico_artillerybot_mech",
	},
}
function Nico_artillerybot:GetSkillEffect(p1,p2)
	local ret = SkillEffect()
	
    local dir = GetDirection(p2 - p1)
	local damage = SpaceDamage(p2 + DIR_VECTORS[(dir+1)%4], self.Damage, dir)
	damage.sAnimation = "explopush1_"..dir
	if not self.BuildingDamage and Board:IsBuilding(p2 + DIR_VECTORS[(dir+1)%4]) then	damage.iDamage = DAMAGE_ZERO 	end 
	damage.bHidePath = true
	damage.sSound = "impact/generic/explosion_multiple"
	ret:AddArtillery(damage,"effects/shotup_guided_missile.png", NO_DELAY)
	ret:AddDelay(0.15)
	
	damage = SpaceDamage(p2, self.Damage, dir)
	damage.sAnimation = "explopush1_"..dir
	if not self.BuildingDamage and Board:IsBuilding(p2) then	damage.iDamage = DAMAGE_ZERO 	end 
	damage.bHidePath = false
	ret:AddArtillery(damage,"effects/shotup_guided_missile.png", NO_DELAY)
	ret:AddDelay(0.15)
	
	damage = SpaceDamage(p2 + DIR_VECTORS[(dir-1)%4], self.Damage, dir)
	damage.sAnimation = "explopush1_"..dir
	if not self.BuildingDamage and Board:IsBuilding(p2 + DIR_VECTORS[(dir-1)%4]) then	damage.iDamage = DAMAGE_ZERO 	end 
	damage.bHidePath = true
	ret:AddArtillery(damage,"effects/shotup_guided_missile.png", NO_DELAY)
	ret:AddDelay(0.5)
	ret:AddBounce(p2+DIR_VECTORS[dir], 2)
	ret:AddBounce(p2, 2)
	ret:AddBounce(p2-DIR_VECTORS[dir], 2)
	return ret
end

Nico_artillerybot_A=Nico_artillerybot:new{
    BuildingDamage = false,
    UpgradeDescription = "doesn't damage buildings",
    TipImage = {
		Unit = Point(2,3),
		Target = Point(2,1),
		Enemy = Point(2,1),
		Enemy2 = Point(3,1),
		Building = Point(1,1),
        CustomPawn="Nico_artillerybot_mech",
	},
}
Nico_artillerybot_B=Nico_artillerybot:new{
    Damage=2,
    UpgradeDescription = "+1 damage",
    TipImage = {
		Unit = Point(2,3),
		Target = Point(2,1),
		Enemy = Point(2,1),
		Enemy2 = Point(3,1),
		Enemy3 = Point(1,1),
        CustomPawn="Nico_artillerybot_mech",
	},
}
Nico_artillerybot_AB=Nico_artillerybot:new{
    BuildingDamage = false,
    Damage=2,
    TipImage = {
		Unit = Point(2,3),
		Target = Point(2,1),
		Enemy = Point(2,1),
		Enemy2 = Point(3,1),
		Building = Point(1,1),
        CustomPawn="Nico_artillerybot_mech",
	},
}
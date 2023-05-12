------Laser Bot------
Nico_laserbot = LaserDefault:new{
    Name="BKR Beam Mark II",
	Class="TechnoVek",
	Icon = "weapons/prime_laser.png",
    Description="Fire a piercing beam that decreases in damage the further it goes, doesn't damage allies.",
	Explosion = "",
	Sound = "",
	Damage = 3,
	PowerCost = 0,
	MinDamage = 1,
	FriendlyDamage = false,
	ZoneTargeting = ZONE_DIR,
	Upgrades = 2,
	UpgradeList = { "Cryostasis", "+1 Damage" },
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
	    LaserArt = "effects/laser_freeze",
	    UpgradeDescription = "If the target would die, freeze it instead. Freezes Buildings and allies.",
		TipImage = {
			Unit = Point(2,4),
			Friendly = Point(2,3),
			Enemy1 = Point(2,2),
			Target = Point(2,2),
			Building = Point(2,0),
			CustomEnemy = "Digger1",
	        CustomPawn="Nico_laserbot_mech",
		},
	}

	Nico_laserbot_B = Nico_laserbot:new{
		Damage = 4,
	    UpgradeDescription = "Increases the starting damage by 1.",
	}

	Nico_laserbot_AB = Nico_laserbot_A:new{
		Damage = 4,
	}

	modApi:addWeaponDrop("Nico_laserbot")
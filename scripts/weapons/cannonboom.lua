------Boom Cannon------
Nico_cannonboom=Nico_cannonbot:new{
	Name="Cannon Explo Mark I",
	Class="TechnoVek",
	Range = RANGE_PROJECTILE,
	PathSize = INT_MAX,
	Description="Projectile that causes target to burn.",
	Icon = "advanced/weapons/SnowtankAtk1_Player.png",
	Damage=1,
    Fire = 1,
    Push=1,
	PowerCost=0,
	Upgrades=2,
	ProjectileArt = "effects/shot_mechtank",
	Explo = "explopush1_",
	ShieldFriendly = false,
	UpgradeCost={2,2},
	UpgradeList = { "+1 Damage", "Shield Friendly"},
	Projectile = "effects/shot_mechtank",
	UpShot = "effects/shotup_ignite_fireball.png",
	LaunchSound = "",
	ImpactSound = "",
	TipImage = {
		Unit = Point(2,4),
		Enemy1 = Point(2,0),
		Enemy2 = Point(2,2),
		Target = Point(2,2),
		Second_Origin = Point(2,4),
		Second_Target = Point(2,0),
		CustomEnemy = "Digger1",
		CustomPawn = "Nico_cannonboom_mech",
	},
	}

	Nico_cannonboom_A=Nico_cannonboom:new{
		Damage=2,
		Explo = "explopush2_",
		UpShot = "effects/shotup_fireball.png",
		UpgradeDescription = "Increases damage by 1.",
		TipImage = {
			Unit = Point(2,4),
			Enemy1 = Point(2,0),
			Enemy2 = Point(2,2),
			Target = Point(2,2),
			Second_Origin = Point(2,4),
			Second_Target = Point(2,0),
			CustomEnemy = "Firefly1",
			CustomPawn = "Nico_cannonboom_mech",
		},
	}

	Nico_cannonboom_B=Nico_cannonboom:new{
	    Damage=1,
		ShieldFriendly = true,
	    UpgradeDescription = "Shields allied units and buildings adjacent to the target.",
		TipImage = {
			Unit = Point(2,4),
			Enemy1 = Point(2,0),
			Enemy2 = Point(2,2),
			Target = Point(2,2),
			Building1 = Point(2,1),
			Building2 = Point(1,2),
			Friendly = Point(3,0),
			Second_Origin = Point(2,4),
			Second_Target = Point(2,0),
			CustomEnemy = "Firefly1",
			CustomPawn = "Nico_cannonboom_mech",
		},
	}

	Nico_cannonboom_AB=Nico_cannonboom_B:new{
		Damage=2,
		Explo = "explopush2_",
		UpShot = "effects/shotup_fireball.png",
		TipImage = {
			Unit = Point(2,4),
			Enemy1 = Point(2,0),
			Enemy2 = Point(2,2),
			Target = Point(2,2),
			Building1 = Point(2,1),
			Building2 = Point(1,2),
			Friendly = Point(3,0),
			Second_Origin = Point(2,4),
			Second_Target = Point(2,0),
			CustomEnemy = "Scarab2",
			CustomPawn = "Nico_cannonboom_mech",
		},
	}
	modApi:addWeaponDrop("Nico_cannonboom")

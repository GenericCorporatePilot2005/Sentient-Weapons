------Artillery Bot------
Nico_artilleryboom=Nico_artillerybot:new{
	Name="Bang Rockets Mark I",
	Class = "TechnoVek",
	Icon = "weapons/ranged_tribomb.png",
	Description="Launch Rockets at 3 tiles.",
	Damage = 1,
	PowerCost = 0,
	BuildingDamage = true,
	shield=false,
	TwoClick = true,
	Upgrades = 2,
	UpgradeList = { "Shield Buildings",  "+1 Damage"  },
	UpgradeCost = {2,3},
	LaunchSound = "/enemy/snowart_1/attack",
	ImpactSound = "",
	TipImage = {
		Unit = Point(2,3),
		Target = Point(2,1),
		Enemy = Point(2,1),
		Enemy2 = Point(3,1),
		Building = Point(1,1),
		Second_Click = Point(2,2),
        CustomPawn="Nico_artilleryboom_mech",
	},
	}

	Nico_artilleryboom_A=Nico_artilleryboom:new{
		BuildingDamage = false,
		shield=true,
		UpgradeDescription = "This attack will shield Grid Buildings.",
	}
	Nico_artilleryboom_B=Nico_artilleryboom:new{
		Damage=2,
		UpgradeDescription = "Deals 1 additional damage to all targets.",
	}
	Nico_artilleryboom_AB=Nico_artilleryboom:new{
		BuildingDamage = false,
		shield=true,
		Damage=2,
	}
	modApi:addWeaponDrop("Nico_artilleryboom")
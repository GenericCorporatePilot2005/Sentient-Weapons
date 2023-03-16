------Laser Bot------
Nico_laserbot = LaserDefault:new{
    Name="BKR Beam Mark II",
	Class="TechnoVek",
	Icon = "weapons/prime_laser.png",
    Description="Fire a piercing beam that decreases in damage the further it goes, doesn't damage allies.",
	Rarity = 3,
	Explosion = "",
	Sound = "",
	Damage = 2,
	PowerCost = 0,
	MinDamage = 1,
	FriendlyDamage = false,
	ZoneTargeting = ZONE_DIR,
	Upgrades = 2,
	UpgradeList = { "Fatal Frost", "+2 Damage" },
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
    UpgradeDescription = "If the target would die, freeze it instead. Freezes buildings.",
	TipImage = {
		Unit = Point(2,4),
		Enemy1 = Point(2,2),
		Enemy2 = Point(2,1),
		Target = Point(2,2),
		Building = Point(2,0),
		CustomEnemy = "Digger1",
        CustomPawn="Nico_laserbot_mech",
	},
}

Nico_laserbot_B = Nico_laserbot:new{
	Damage = 4,
    UpgradeDescription = "Increases the starting damage by 2.",
}

Nico_laserbot_AB = Nico_laserbot_A:new{
	Damage = 4,
}

------Cannon Bot------
Nico_cannonbot=TankDefault:new{
	Name="Cannon 8R Mark II",
	Class="TechnoVek",
	Description="Fire a damaging projectile that applies fire and pushes.",
	Icon = "weapons/brute_tank.png",
	Damage=1,
    Fire = 1,
    Push=1,
	Flip=0,
	PowerCost=0,
	Upgrades=2,
	UpgradeCost={2,3},
	UpgradeList = { "+1 Damage", "+1 Damage, Flip"},
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
    UpgradeDescription = "Increases damage by 1.",
}

Nico_cannonbot_B=Nico_cannonbot:new{
    Damage=2,
	Flip=1,
    UpgradeDescription = "Increases damage by 1, flips target.",
	TipImage = {
		Unit = Point(1,2),
		Enemy1 = Point(1,1),
		Target = Point(1,1),
		Queued1 = Point(2,1),
		Friendly = Point(3,1),
		CustomEnemy = "Firefly2",
		CustomPawn = "Nico_cannonbot_mech",
		Length = 4,
	},
}

Nico_cannonbot_AB=Nico_cannonbot_B:new{
    Damage=3,
}

------Artillery Bot------
Nico_artillerybot=ArtilleryDefault:new{
    Name="Vk8 Rockets Mark II",
    Class = "TechnoVek",
	Icon = "advanced/weapons/Ranged_Crack.png",
    Description="Launch Rockets at 3 tiles.",
	Explosion = "",
	Damage = 1,
	PowerCost = 0,
	BuildingDamage = true,
	shield=false,
	Upgrades = 2,
    UpgradeList = { "Shield Buildings",  "+1 Damage"  },
	UpgradeCost = {2,3},
	LaunchSound = "/weapons/ranged_crack",
	ImpactSound = "",
	TipImage = {
		Unit = Point(2,3),
		Target = Point(2,1),
		Enemy = Point(2,1),
		Enemy2 = Point(3,1),
		Building = Point(1,1),
        CustomPawn="Nico_artillerybot_mech",
	},
}
function Nico_artillerybot:GetSkillEffect(p1,p2)
	local ret = SkillEffect()
	
    local dir = GetDirection(p2 - p1)
	local damage = SpaceDamage(p2 + DIR_VECTORS[(dir+1)%4], self.Damage, dir)
	damage.sAnimation = "explopush1_"..dir
	if not self.BuildingDamage and self.shield and Board:IsBuilding(p2 + DIR_VECTORS[(dir+1)%4]) then
		damage.iDamage = DAMAGE_ZERO
		damage.iShield=1
	end 
	damage.bHidePath = true
	damage.sSound = "impact/generic/explosion_multiple"
	if self.Damage==2 then
		ret:AddArtillery(damage,"effects/shotup_robot.png", NO_DELAY)
	else
		ret:AddArtillery(damage,"effects/shotup_guided_missile.png", NO_DELAY)
	end
	ret:AddDelay(0.15)
	
	damage = SpaceDamage(p2, self.Damage, dir)
	damage.sAnimation = "explopush1_"..dir
	if not self.BuildingDamage and self.shield and Board:IsBuilding(p2) then
		damage.iDamage = DAMAGE_ZERO 
		damage.iShield=1
	end 
	damage.bHidePath = false
	if self.Damage==2 then
		ret:AddArtillery(damage,"effects/shotup_robot.png", NO_DELAY)
	else
		ret:AddArtillery(damage,"effects/shotup_guided_missile.png", NO_DELAY)
	end
	ret:AddDelay(0.15)
	
	damage = SpaceDamage(p2 + DIR_VECTORS[(dir-1)%4], self.Damage, dir)
	damage.sAnimation = "explopush1_"..dir
	if not self.BuildingDamage and self.shield and Board:IsBuilding(p2 + DIR_VECTORS[(dir-1)%4]) then
		damage.iDamage = DAMAGE_ZERO
		damage.iShield=1
	end 
	damage.bHidePath = true
	if self.Damage==2 then
		ret:AddArtillery(damage,"effects/shotup_robot.png", NO_DELAY)
	else
		ret:AddArtillery(damage,"effects/shotup_guided_missile.png", NO_DELAY)
	end
	ret:AddDelay(0.5)
	ret:AddBounce(p2+DIR_VECTORS[dir], 2)
	ret:AddBounce(p2, 2)
	ret:AddBounce(p2-DIR_VECTORS[dir], 2)
	return ret
end

Nico_artillerybot_A=Nico_artillerybot:new{
    BuildingDamage = false,
	shield=true,
    UpgradeDescription = "This attack will shield Grid Buildings.",
}
Nico_artillerybot_B=Nico_artillerybot:new{
    Damage=2,
    UpgradeDescription = "Deals 1 additional damage to all targets.",
}
Nico_artillerybot_AB=Nico_artillerybot_A:new{
    BuildingDamage = false,
	shield=true,
    Damage=2,
}

local Nico_FatalFreeze = function(mission, pawn, weaponId, p1, p2, skillEffect)
	if (weaponId == "Nico_laserbot_A") or (weaponId == "Nico_laserbot_AB") then	
		for i = 1, skillEffect.effect:size() do
			local spaceDamage = skillEffect.effect:index(i)
			spaceDamage.bKO_Effect = Board:IsDeadly(spaceDamage,Pawn)
			if spaceDamage.bKO_Effect or Board:IsBuilding(spaceDamage.loc) then
				spaceDamage.iDamage = 0
				--invert the KO flag afterwards because it overwrites the spaceDamage image mark for some reason
				spaceDamage.bKO_Effect = false
				spaceDamage.iFrozen = EFFECT_CREATE
			end
		end
	end
end

local function EVENT_onModsLoaded()
	modapiext:addSkillBuildHook(Nico_FatalFreeze)
end

modApi.events.onModsLoaded:subscribe(EVENT_onModsLoaded)

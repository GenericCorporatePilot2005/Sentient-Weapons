local path = mod_loader.mods[modApi.currentMod].resourcePath
------Laser Bot------
Nico_laserbot = LaserDefault:new{
    Name="BKR Beam Mark II",
	Class="TechnoVek",
	Icon = "weapons/prime_laser.png",
    Description="Fire a piercing beam that decreases in damage the further it goes, doesn't damage allies.",
	Rarity = 3,
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
    UpgradeDescription = "If the target would die, freeze it instead. Freezes Buildings and non-Mech allies.",
	TipImage = {
		Unit = Point(2,4),
		Enemy1 = Point(2,1),
		Enemy2 = Point(2,2),
		Enemy3 = Point(2,3),
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

------Cannon Bot------
Nico_cannonbot=TankDefault:new{
	Name="Cannon 8R Mark II",
	Class="TechnoVek",
	Range = RANGE_PROJECTILE,
	PathSize = INT_MAX,
	Description="Fire a damaging projectile that applies fire and pushes.",
	Icon = "advanced/weapons/SnowtankAtk1_Player.png",
	Damage=1,
    Fire = 1,
    Push=1,
	PowerCost=0,
	Upgrades=2,
	ShieldFriendly = false,
	UpgradeCost={2,3},
	UpgradeList = { "+1 Damage", "Shield Friendly"},
	Explosion = "ExploAir2",
	Projectile = "effects/shot_mechtank",
	LaunchSound = "/enemy/snowtank_1/attack",
	TipImage = {
		Unit = Point(2,3),
		Enemy = Point(2,1),
		Target = Point(2,1),
		CustomPawn = "Nico_cannonbot_mech",
	},
}

function Nico_cannonbot:GetSkillEffect(p1,p2)
	local ret = SkillEffect()
	local direction = GetDirection(p2 - p1)
	
	local damage = SpaceDamage(p2, self.Damage)
	damage.iFire = self.Fire
	if self.Push == 1 then
		damage.iPush = direction
	end
	damage.sAnimation = self.Explo..direction
	
	
	ret:AddProjectile(damage, self.ProjectileArt, NO_DELAY)--"effects/shot_mechtank")
	if self.ShieldFriendly then
		ret:AddDelay(0.1*p1:Manhattan(p2))
		for dir = DIR_START, DIR_END do
			local spaceDamage = SpaceDamage(p2 + DIR_VECTORS[dir], 0)
			if Board:IsBuilding(p2 + DIR_VECTORS[dir]) or Board:GetPawnTeam(p2 + DIR_VECTORS[dir]) == TEAM_PLAYER then
				spaceDamage.iShield = 1
				ret:AddDamage(spaceDamage)
			end

		end
	end
	return ret
end


Nico_cannonbot_A=Nico_cannonbot:new{
    Damage=2,
    UpgradeDescription = "Increases damage by 1.",
}

Nico_cannonbot_B=Nico_cannonbot:new{
    Damage=1,
	ShieldFriendly = true,
    UpgradeDescription = "Shields allied units and buildings adjacent to the target.",
	TipImage = {
		Unit = Point(1,3),
		Enemy1 = Point(1,1),
		Target = Point(1,1),
		Building = Point(1,0),
		CustomEnemy = "Firefly1",
		CustomPawn = "Nico_cannonbot_mech",
		Length = 4,
	},
}

Nico_cannonbot_AB=Nico_cannonbot_B:new{
    Damage=2,
}

------Artillery Bot------
Nico_artillerybot=ArtilleryDefault:new{
    Name="Vk8 Rockets Mark II",
    Class = "TechnoVek",
	Icon = "weapons/ranged_tribomb.png",
    Description="Launch Rockets at 3 tiles.",
	Explosion = "",
	Damage = 1,
	PowerCost = 0,
	BuildingDamage = true,
	shield=false,
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
        CustomPawn="Nico_artillerybot_mech",
	},
}
function Nico_artillerybot:GetSkillEffect(p1,p2)
	local ret = SkillEffect()
	local dir = GetDirection(p2 - p1)
	local damage = SpaceDamage(p2, self.Damage, dir)
	local bounce = 2
	if self.Damage == 2 then bounce = 3 end
	
	for i = -1,1 do
		damage = SpaceDamage(p2 + DIR_VECTORS[(dir+1)%4]*i, self.Damage, dir)
		damage.sAnimation = "explopush1_"..dir
		if self.Damage == 2 then damage.sAnimation = "explopush2_"..dir end
		damage.sSound = "/impact/generic/explosion"
		if not self.BuildingDamage and self.shield and Board:IsBuilding(p2 + DIR_VECTORS[(dir+1)%4]*i) then
			damage.iDamage = DAMAGE_ZERO
			damage.iShield=1
			damage.sAnimation = "airpush_"..dir
			ret:AddArtillery(damage,"effects/shotup_missileswarm.png", NO_DELAY)
		elseif self.Damage==2 then
			ret:AddArtillery(damage,"effects/shotup_robot.png", NO_DELAY)--
		else
			ret:AddArtillery(damage,"effects/shotup_guided_missile.png", NO_DELAY)
		end
	end
	ret:AddDelay(0.8)
	for i = -1,1 do
		ret:AddBounce(p2 + DIR_VECTORS[(dir+1)%4]*i, bounce)
	end
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

------Knight Bot------

Nico_knightbot = Punch:new{
	Name = "0th KPR Sword Mark II",
	Description = "Dash two tiles to damage and push the target.",
	Icon = "weapons/prime_sword.png",
	Class = "TechnoVek",
	Damage = 2,
	PathSize = INT_MAX,
	Dash=true,
	Push = true,
	LaunchSound="/weapons/sword",
	TipImage = {
		Unit = Point(2,4),
		Target = Point(2,4),
		Enemy = Point(2,1),
		CustomPawn = "Nico_knightbot_mech",
	}
}

function Nico_knightbot:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local direction = GetDirection(p2 - p1)

	local doDamage = true
	local target = GetProjectileEnd(p1,p2,PATH_PROJECTILE)
	local push_damage = direction
	local damage = SpaceDamage(target, self.Damage, push_damage)
	damage.sAnimation = "explosword_"..direction
	damage.sSound="/weapons/sword"
	
    if self.Dash then
       
        if not Board:IsBlocked(target,PATH_PROJECTILE) then -- dont attack an empty edge square, just run to the edge
	    	doDamage = false
		    target = target + DIR_VECTORS[direction]
    	end
    	
    	ret:AddCharge(Board:GetSimplePath(p1, target - DIR_VECTORS[direction]), FULL_DELAY)
    elseif self.Projectile and target:Manhattan(p1) ~= 1 then
		damage.loc = target
		ret:AddDamage(SpaceDamage(p1,0,(direction+2)%4))
		ret:AddProjectile(damage, "effects/shot_fist")
		doDamage = false--damage covered here
	else
		target = p2
	end

	
	if doDamage then
		damage.loc = target
		ret:AddMelee(p2 - DIR_VECTORS[direction], damage)
	end
	
	if self.PushBack then
		ret:AddDamage(SpaceDamage(p1, 0, GetDirection(p1 - p2)))
	end
	return ret
end

------Shield Bot------
modApi:appendAsset("img/weapons/Nico_shieldbot.png", path .."img/weapons/Nico_shieldbot.png")

local Nico_FatalFreeze = function(mission, pawn, weaponId, p1, p2, skillEffect)
	if (weaponId == "Nico_laserbot_A") or (weaponId == "Nico_laserbot_AB") then	
		for i = 1, skillEffect.effect:size() do
			local spaceDamage = skillEffect.effect:index(i)
			spaceDamage.bKO_Effect = Board:IsDeadly(spaceDamage,Pawn)
			local dpawn = Board:GetPawn(spaceDamage.loc)
			local friendly_non_mech = Board:IsPawnSpace(spaceDamage.loc) and dpawn:GetTeam() == TEAM_PLAYER and not dpawn:IsMech()
			if spaceDamage.bKO_Effect or Board:IsBuilding(spaceDamage.loc) or friendly_non_mech then
				spaceDamage.iDamage = 0
				--invert the KO flag afterwards because it overwrites the spaceDamage image mark for some reason
				spaceDamage.bKO_Effect = false
				spaceDamage.iFrozen = EFFECT_CREATE
			end
		end
	end
end

local Nico_MoveShield = function(mission, pawn, weaponId, p1, p2)
	if _G[pawn:GetType()].NicoIsRobot and weaponId == "Move" then
		Game:TriggerSound("/props/shield_activated")
		pawn:SetShield(true)
	end
end

local function EVENT_onModsLoaded()
	modapiext:addSkillBuildHook(Nico_FatalFreeze)
	modapiext:addSkillStartHook(Nico_MoveShield)
end

modApi.events.onModsLoaded:subscribe(EVENT_onModsLoaded)

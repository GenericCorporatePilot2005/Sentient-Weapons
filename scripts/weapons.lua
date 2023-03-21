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
    UpgradeDescription = "If the target would die, freeze it instead. Freezes Buildings and allies.",
	TipImage = {
		Unit = Point(2,4),
		Friendly = Point(2,1),
		Enemy1 = Point(2,2),
		Enemy2 = Point(2,3),
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
Nico_cannonbot=Skill:new{
	Name="Cannon 8R Mark II",
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
		CustomPawn = "Nico_cannonbot_mech",
	},
}

function Nico_cannonbot:GetTargetArea(point)
	local ret = PointList()
	for i = DIR_START, DIR_END do
		for k = 1, 7 do
			ret:push_back(DIR_VECTORS[i]*k + point)
		end
	end
	return ret
end

function Nico_cannonbot:GetSkillEffect(p1,p2)
	local ret = SkillEffect()
	local direction = GetDirection(p2 - p1)
	local target = GetProjectileEnd(p1,p1+DIR_VECTORS[direction])
	if p1:Manhattan(target) < p1:Manhattan(p2) then
		ret:AddBounce(p1, self.Damage)
		ret:AddSound("/weapons/fireball")
		local damage = SpaceDamage(p2,self.Damage)
		damage.sAnimation = "ExploArt2"
		damage.iFire = 1
		ret:AddArtillery(damage, self.UpShot)
		ret:AddSound("/props/fire_damage")
		if self.ShieldFriendly then
			for dir = DIR_START, DIR_END do
				local spaceDamage = SpaceDamage(p2 + DIR_VECTORS[dir], 0)
				if Board:IsBuilding(p2 + DIR_VECTORS[dir]) or Board:GetPawnTeam(p2 + DIR_VECTORS[dir]) == TEAM_PLAYER then
					spaceDamage.iShield = 1
					ret:AddDamage(spaceDamage)
				end
			end
		end
	else
		ret:AddSound("/enemy/snowtank_1/attack")
	  	local damage = SpaceDamage(target, self.Damage)
		damage.iFire = self.Fire
		if self.Push == 1 then
			damage.iPush = direction
		end
		damage.sAnimation = self.Explo..direction
		
		ret:AddProjectile(damage, self.ProjectileArt, 0.1*p1:Manhattan(target))--"effects/shot_mechtank")
		ret:AddSound("/impact/generic/explosion")
		if self.ShieldFriendly then
			--ret:AddDelay()
			for dir = DIR_START, DIR_END do
				local spaceDamage = SpaceDamage(target + DIR_VECTORS[dir], 0)
				if Board:IsBuilding(target + DIR_VECTORS[dir]) or Board:GetPawnTeam(target + DIR_VECTORS[dir]) == TEAM_PLAYER then
					spaceDamage.iShield = 1
					ret:AddDamage(spaceDamage)
				end

			end
		end
	end

	return ret
end


Nico_cannonbot_A=Nico_cannonbot:new{
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
		CustomPawn = "Nico_cannonbot_mech",
	},
}

Nico_cannonbot_B=Nico_cannonbot:new{
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
		CustomPawn = "Nico_cannonbot_mech",
	},
}

Nico_cannonbot_AB=Nico_cannonbot_B:new{
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
		CustomPawn = "Nico_cannonbot_mech",
	},
}

------Artillery Bot------
Nico_artillerybot=ArtilleryDefault:new{
	Name="Vk8 Rockets Mark II",
	Class = "TechnoVek",
	Icon = "weapons/ranged_tribomb.png",
	Description="Launch Rockets at 3 tiles.",
	Explo = "explopush1_",
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
		Second_Click = Point(3,5),
        CustomPawn="Nico_artillerybot_mech",
	},
}
function Nico_artillerybot:GetSecondTargetArea(p1,p2)
	local ret = PointList()
	local dir = GetDirection(p2 - p1)
	for i = 3,4 do
		if dir%2 == 1 then
			if Point(1,i)~= p2 then ret:push_back(Point(1,i)) end
			if Point(2,i)~= p2 then ret:push_back(Point(2,i)) end
			if Point(5,i)~= p2 then ret:push_back(Point(5,i)) end
			if Point(6,i)~= p2 then ret:push_back(Point(6,i)) end
		else
			if Point(i,1)~= p2 then ret:push_back(Point(i,1)) end
			if Point(i,2)~= p2 then ret:push_back(Point(i,2)) end
			if Point(i,5)~= p2 then ret:push_back(Point(i,5)) end
			if Point(i,6)~= p2 then ret:push_back(Point(i,6)) end
		end
	end
	return ret
end
function Nico_artillerybot:GetSkillEffect(p1,p2)
	local ret = SkillEffect()
	local dir = GetDirection(p2 - p1)
	local damage = SpaceDamage(p2, self.Damage, dir)
	local bounce = 2
	if self.Damage == 2 then bounce = 3 end
	
	for i = -1,1 do
		damage = SpaceDamage(p2 + DIR_VECTORS[(dir+1)%4]*i, self.Damage)
		damage.sAnimation = self.Explo..dir
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
function Nico_artillerybot:GetFinalEffect(p1,p2,p3)
	local ret = SkillEffect()
	local dir = GetDirection(p2 - p1)
	local push_dir = dir
	if p3.x == 1 or p3.x == 2 then
		push_dir = 3
	elseif p3.x == 5 or p3.x == 6 then
		push_dir = 1
	elseif p3.y == 1 or p3.y == 2 then
		push_dir = 0
	elseif p3.y == 5 or p3.y == 6 then
		push_dir = 2
	end
	local damage = SpaceDamage(p2, self.Damage, push_dir)
	local bounce = 2
	if self.Damage == 2 then bounce = 3 end
	
	for i = -1,1 do
		damage = SpaceDamage(p2 + DIR_VECTORS[(dir+1)%4]*i, self.Damage, push_dir)
		damage.sAnimation = self.Explo..push_dir
		damage.sSound = "/impact/generic/explosion"
		if not self.BuildingDamage and self.shield and Board:IsBuilding(p2 + DIR_VECTORS[(dir+1)%4]*i) then
			damage.iDamage = DAMAGE_ZERO
			damage.iShield=1
			damage.sAnimation = "airpush_"..push_dir
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
	Explo="explopush2_",
	UpgradeDescription = "Deals 1 additional damage to all targets.",
}
Nico_artillerybot_AB=Nico_artillerybot_A:new{
	BuildingDamage = false,
	shield=true,
	Damage=2,
	Explo="explopush2_",
}

------Knight Bot------

Nico_knightbot = Punch:new{
	Name = "0th KPR Sword Mark II",
	Description = "Dash two tiles to damage and push the target.",
	Icon = "weapons/prime_sword.png",
	Class = "TechnoVek",
	Damage = 1,
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

    if not Board:IsBlocked(target,PATH_PROJECTILE) then -- dont attack an empty edge square, just run to the edge
	 	doDamage = false
	    target = target + DIR_VECTORS[direction]
	end
    	
	ret:AddCharge(Board:GetSimplePath(p1, target - DIR_VECTORS[direction]), FULL_DELAY)

	
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
Nico_shieldbot = Science_Placer:new{
	Class = "TechnoVek",
	Name="NRG Shield Mark II",
	Description="Shields self, push and damage adjacent tiles away.",
	Icon = "weapons/Nico_shieldbot.png",
	LaunchSound = "/weapons/enhanced_tractor",
	Explosion = "",
	Range = 0,
	PathSize = 1,
	Damage = 0,
	PowerCost = 0,
	Upgrades = 0,
	UpgradeCost = { 1,2 },
	TipImage = {
		Unit = Point(2,1),
		Enemy = Point(1,1),
		Enemy2 = Point(3,1),
		Target = Point(2,1),
		CustomPawn="Nico_shieldbot_mech",
	},
}

function Nico_shieldbot:GetSkillEffect(p1, p2)
	local ret = SkillEffect()

	local dir = GetDirection(p2 - p1)

	
	local damage = SpaceDamage(p2, self.Damage)
	damage.iShield = EFFECT_CREATE
	damage.sAnimation = "ExploRepulse1"
	if p1 == p2 then ret:AddDamage(damage) 
	else 	
		ret:AddArtillery(damage, "effects/shot_pull_U.png", NO_DELAY)
		ret:AddDelay(1)
	end
	
	for i = DIR_START, DIR_END do
		damage = SpaceDamage(p2 + DIR_VECTORS[i], 1, i)
		damage.sAnimation = "airpush_"..i
		ret:AddDamage(damage)
	end
	
	return ret
end	

local Nico_FatalFreeze = function(mission, pawn, weaponId, p1, p2, skillEffect)
	if (weaponId == "Nico_laserbot_A") or (weaponId == "Nico_laserbot_AB") then	
		for i = 1, skillEffect.effect:size() do
			local spaceDamage = skillEffect.effect:index(i)
			spaceDamage.bKO_Effect = Board:IsDeadly(spaceDamage,Pawn)
			local dpawn = Board:GetPawn(spaceDamage.loc)
			local friendly = Board:IsPawnSpace(spaceDamage.loc) and dpawn:GetTeam() == TEAM_PLAYER
			if spaceDamage.bKO_Effect or Board:IsBuilding(spaceDamage.loc) or friendly then
				spaceDamage.iDamage = 0
				--invert the KO flag afterwards because it overwrites the spaceDamage image mark for some reason
				spaceDamage.bKO_Effect = false
				spaceDamage.iFrozen = EFFECT_CREATE
			end
		end
	end
end

local Nico_MoveShield = function(mission, pawn, weaponId, p1, p2)
	i = pawn:GetId()
	local IsRealMission = true and (mission ~= nil) and (mission ~= Mission_Test) and Board	and Board:IsMissionBoard()
	local adjacent_mech = IsRealMission and ((Board:GetPawn((i+1)%3):GetSpace():Manhattan(p2)==1) or (Board:GetPawn((i+2)%3):GetSpace():Manhattan(p2)==1))
	if _G[pawn:GetType()].NicoIsRobot and weaponId == "Move" and adjacent_mech then
		Game:TriggerSound("/props/shield_activated")
		pawn:SetShield(true)
	end
end

local function EVENT_onModsLoaded()
	modapiext:addSkillBuildHook(Nico_FatalFreeze)
	modapiext:addSkillStartHook(Nico_MoveShield)
end

modApi.events.onModsLoaded:subscribe(EVENT_onModsLoaded)

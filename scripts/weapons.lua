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
		damage.sAnimation = (self.Damage == 1 and "ExploArt2") or "explo_fire1"
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
        CustomPawn="Nico_artillerybot_mech",
	},
}
function Nico_artillerybot:GetSecondTargetArea(p1,p2)
	local ret = PointList()
	local dir = GetDirection(p2 - p1)
	ret:push_back(p1)
	ret:push_back(p2+DIR_VECTORS[dir])
	ret:push_back(p2-DIR_VECTORS[dir])
	return ret
end
function Nico_artillerybot:GetSkillEffect(p1,p2)
	local ret = SkillEffect()
	local dir = GetDirection(p2 - p1)
	local damage = SpaceDamage(p2, self.Damage, dir)
	
	for i = -1,1 do
		damage = SpaceDamage(p2 + DIR_VECTORS[(dir+1)%4]*i, self.Damage)
		damage.sAnimation = "explopush"..self.Damage.."_"..dir
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
		ret:AddBounce(p2 + DIR_VECTORS[(dir+1)%4]*i, self.Damage + 1)
	end
	return ret
end
function Nico_artillerybot:GetFinalEffect(p1,p2,p3)
	local ret = SkillEffect()
	local dir = GetDirection(p2 - p1)
	local push_dir = GetDirection(p3 - p2)
	if p1 == p3 then
		push_dir = nil
	end
	local damage = SpaceDamage(p2, self.Damage)
	
	for i = -1,1 do
		if push_dir ~= nil then
			damage = SpaceDamage(p2 + DIR_VECTORS[(dir+1)%4]*i, self.Damage, push_dir)
			damage.sAnimation = "explopush"..self.Damage.."_"..push_dir
		else
			damage = SpaceDamage(p2 + DIR_VECTORS[(dir+1)%4]*i, self.Damage)
			damage.sAnimation = "ExploArt"..self.Damage
		end
		damage.sSound = "/impact/generic/explosion"
		if not self.BuildingDamage and self.shield and Board:IsBuilding(p2 + DIR_VECTORS[(dir+1)%4]*i) then
			damage.iDamage = DAMAGE_ZERO
			damage.iShield=1
			if push_dir ~= nil then
				damage.sAnimation = "airpush_"..push_dir
			else
				damage.sAnimation = "ExploRepulse"..self.Damage
			end
			ret:AddArtillery(damage,"effects/shotup_missileswarm.png", NO_DELAY)
		elseif self.Damage==2 then
			ret:AddArtillery(damage,"effects/shotup_robot.png", NO_DELAY)--
		else
			ret:AddArtillery(damage,"effects/shotup_guided_missile.png", NO_DELAY)
		end
	end
	ret:AddDelay(0.8)
	for i = -1,1 do
		ret:AddBounce(p2 + DIR_VECTORS[(dir+1)%4]*i, self.Damage + 1)
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
	Description = "Dash to damage and push the target. If the target was shielded, attack again.",
	Icon = "weapons/prime_sword.png",
	Class = "TechnoVek",
	Damage = 1,
	PathSize = INT_MAX,
	ZoneTargeting = ZONE_DIR,
	Dash = true,
	Phase = false,
	Upgrades = 2,
	UpgradeList={"Phase & Shield","+2 Damage"},
	UpgradeCost={2,3},
	Push = true,
	LaunchSound="/weapons/charge",
	ImpactSound="",--/weapons/sword",
	TipImage = {
		Unit = Point(4,2),
		Second_Origin=Point(2,2),
		Target = Point(1,2),
		Second_Target=Point(2,0),
		Enemy1 = Point(1,2),
		Enemy2 = Point(2,0),
		CustomPawn = "Nico_knightbot_mech",
	}
}

function Nico_knightbot:GetTargetArea(point)
	local ret = PointList()
	local curr = point
	for i = 0,3 do
		curr = point + DIR_VECTORS[i]
		ret:push_back(curr)
		while not Board:IsBlocked(curr,PATH_PROJECTILE) do
			curr = curr + DIR_VECTORS[i]
			ret:push_back(curr)
		end
		if self.Phase then
			for j = 1,7 do
				if Board:IsPawnSpace(curr) then break end
				if not Board:IsPawnSpace(curr) and Board:IsValid(curr) then
					curr = curr + DIR_VECTORS[i]
					ret:push_back(curr)
				end
			end
		end
	end
	return ret
end

function Nico_knightbot:GetSkillEffect(p1, p2)
	if Board:IsTipImage() then
		Board:AddShield(Point(2,0))
	end
	local ret = SkillEffect()
	local direction = GetDirection(p2 - p1)
	local mech = Board:GetPawn(p1)
	local target = GetProjectileEnd(p1,p1+DIR_VECTORS[direction],PATH_PROJECTILE)
	local damage = SpaceDamage(target, self.Damage, direction)
	damage.sAnimation = "explospear1_"..direction

	if self.Phase then
		local curr = target
		for i = 1,7 do
			if Board:IsPawnSpace(curr) then break end
			if not Board:IsPawnSpace(curr) and Board:IsValid(curr) then
				curr = curr + DIR_VECTORS[direction]
			end
		end
		target = curr
	end

    if not Board:IsBlocked(target,PATH_PROJECTILE) then -- dont attack an empty edge square, just run to the edge
	 	target = target + DIR_VECTORS[direction]
	end

	if self.Phase then
		ret:AddCharge(Board:GetPath(p1, target - DIR_VECTORS[direction], PATH_FLYER), NO_DELAY)
		local temp = p1
		local dam = SpaceDamage(p1,0)
		dam.iShield = 1
		while temp ~= target do
			if Board:IsBuilding(temp) or Board:IsTerrain(temp,TERRAIN_MOUNTAIN) then dam.loc = temp ret:AddDamage(dam) end
			--ret:AddBounce(temp,-3)
			temp = temp + DIR_VECTORS[direction]
			if temp ~= target then
				ret:AddDelay(0.07)
			end
		end
	else
		ret:AddCharge(Board:GetPath(p1, target - DIR_VECTORS[direction], PATH_FLYER), FULL_DELAY)
	end

	if Board:IsBuilding(target) and self.Phase then damage.iDamage = 0 end
	damage.loc = target
	damage.fDelay = -1
	if Board:IsValid(target) then damage.sSound = "/weapons/sword" end
	
	local double_flag = Board:IsPawnSpace(target) and Board:GetPawn(target):IsShield()
	local stable = Board:IsPawnSpace(target) and Board:GetPawn(target):IsGuarding()
	local unstable_pushed = Board:IsPawnSpace(target) and not Board:GetPawn(target):IsGuarding() and not Board:IsBlocked(target + DIR_VECTORS[direction],PATH_PROJECTILE) and Board:IsValid(target + DIR_VECTORS[direction])
	local unstable_blocked = Board:IsPawnSpace(target) and not Board:GetPawn(target):IsGuarding() and (Board:IsBlocked(target + DIR_VECTORS[direction],PATH_PROJECTILE) or not Board:IsValid(target + DIR_VECTORS[direction]))
	ret:AddMelee(target - DIR_VECTORS[direction], damage)
	if double_flag then
		if stable or unstable_blocked then ret:AddMelee(target - DIR_VECTORS[direction], damage) end
		if unstable_pushed then
			damage.loc = target + DIR_VECTORS[direction]
			damage.sAnimation = ""--"explospear2_"..direction
			ret:AddScript("Board:AddAnimation("..target:GetString()..", \"explospear2_"..direction.."\", 0)")
			ret:AddMelee(target - DIR_VECTORS[direction], damage)
		end
	end
	
	if target - DIR_VECTORS[direction] ~= p1 and Board:IsBlocked(target - DIR_VECTORS[direction],PATH_PROJECTILE) then
		local landing = target - DIR_VECTORS[direction]
		while landing ~= p1 and Board:IsBlocked(landing,PATH_PROJECTILE) do
			landing = landing - DIR_VECTORS[direction]
		end
		local damage = SpaceDamage(0)--phantom damage to stall board state
		damage.fDelay = 0.017
		ret:AddDamage(damage)
		local move = PointList()
		move:push_back(target - DIR_VECTORS[direction])
		move:push_back(landing)
		ret:AddBurst(target - DIR_VECTORS[direction],"Emitter_Burst_$tile",DIR_NONE)
		ret:AddSound("/weapons/boosters")
		ret:AddLeap(move, FULL_DELAY)
		ret:AddBurst(landing,"Emitter_Burst_$tile",DIR_NONE)
		ret:AddBounce(landing,3)
		ret:AddSound("/impact/generic/mech")
	end
	if Board:IsTipImage() then
		mech:RemoveWeapon(1)
		mech:AddWeapon(self.__Id)
	end
	return ret
end
Nico_knightbot_A=Nico_knightbot:new{
	Phase = true,
	UpgradeDescription="Phase through and shield Buildings and Mountains. If the destination is blocked, leap backwards to the nearest empty tile.",
	TipImage = {
		Unit = Point(4,2),
		Second_Origin = Point(2,2),
		Target = Point(3,2),
		Second_Target = Point(2,0),
		Enemy1 = Point(1,2),
		Enemy2 = Point(2,0),
		Queued2 = Point(2,1),
		Building = Point(2,1),
		Mountain = Point(3,2),
		CustomPawn = "Nico_knightbot_mech",
	}
}
Nico_knightbot_B=Nico_knightbot:new{
	UpgradeDescription="Increases damage by 2.",
	Damage=3,
}
Nico_knightbot_AB=Nico_knightbot_A:new{
	Damage=3,
}
------Shield Bot------
modApi:appendAsset("img/weapons/Nico_shield_explode_glow.png", path.."img/weapons/Nico_shield_explode_glow.png")
Location["weapons/Nico_shield_explode_glow.png"] = Point(-16,8)
modApi:appendAsset("img/weapons/Nico_shieldbot.png", path .."img/weapons/Nico_shieldbot.png")
modApi:appendAsset("img/effects/shield_bot_pulse.png", path.. "img/effects/shield_bot_pulse.png")
shieldbotpulse = Animation:new{
	Image = "effects/shield_bot_pulse.png",
	NumFrames = 8,
	Time = 0.05,
	
	PosX = -33,
	PosY = -14
}
Nico_shieldbot = Science_Placer:new{
	Class = "TechnoVek",
	Name="NRG Shield Mark II",
	Description="Shields self, push and damage adjacent tiles away.",
	Icon = "weapons/Nico_shieldbot.png",
	LaunchSound = "/weapons/enhanced_tractor",
	Explosion = "",--shieldbotpulse",
	Size = 2,
	PathSize = 1,
	Damage = 0,
	PowerCost = 0,
	Upgrades = 2,
	UpgradeList={"Size & Shield Friendly","Shield Blast"},
	UpgradeCost = { 2,2 },
	TipImage = {
		Unit = Point(2,2),
		Enemy1 = Point(1,2),
		Enemy2 = Point(3,2),
		Friendly = Point(2,1),
		Building = Point(2,3),
		Mountain1 = Point(0,2),
		Mountain2 = Point(4,2),
		Target = Point(2,2),
		Second_Origin = Point(2,2),
		Second_Target = Point(0,2),
		CustomPawn="Nico_shieldbot_mech",
	},
}

function Nico_shieldbot:GetTargetArea(point)
	local ret = PointList()
	local list = extract_table(general_DiamondTarget(point, self.Size))
	for i = 1, #list do
		ret:push_back(list[i])
	end
	return ret
end
function Nico_shieldbot:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local blastFlag = self.Blast and ((Board:IsPawnSpace(p2) and Board:GetPawn(p2):IsShield()) or Board:IsShield(p2))
	local blastDamage = (blastFlag and 1) or 0
	local damage = SpaceDamage(p2, 0)
	damage.iShield = (blastFlag and 0) or 1
	damage.sImageMark = (blastFlag and "weapons/Nico_shield_explode_glow.png") or damage.sImageMark
	
	damage.sAnimation = (blastFlag and ((p1==p2 and "ExploAir2") or (p1~=p2 and "ExploArt2"))) or "shieldbotpulse"
	if p1 == p2 then ret:AddDamage(damage) 
	else 	
		ret:AddArtillery(damage, "effects/shot_pull_U.png", NO_DELAY)
		ret:AddDelay(0.8)
	end
	
	if blastFlag then
		if Board:IsPawnSpace(p2) and Board:GetPawn(p2):IsShield() then
			ret:AddSound("/impact/generic/explosion_large")
			ret:AddScript("Board:GetPawn("..p2:GetString().."):SetShield(false,false)")
			
		end
		if Board:IsShield(p2) then
			ret:AddSound("/impact/generic/explosion_large")
			ret:AddScript("Board:SetShield("..p2:GetString()..",false,false)")
			
		end
	else
		ret:AddSound("/impact/generic/explosion")
	end
	
	for i = DIR_START, DIR_END do
		damage = SpaceDamage(p2 + DIR_VECTORS[i], self.Damage + blastDamage, i)
		damage.sAnimation = "explopush"..(self.Damage + blastDamage).."_"..i
		if (Board:IsBuilding(p2 + DIR_VECTORS[i]) or (Board:IsPawnSpace(p2 + DIR_VECTORS[i]) and Board:GetPawn(p2 + DIR_VECTORS[i]):GetTeam() == TEAM_PLAYER)) and self.ShieldFriendly then
			damage.iDamage = 0
			damage.iShield = 1
			damage.sAnimation = "airpush_"..i
		end
		ret:AddDamage(damage)
	end
	
	return ret
end
Nico_shieldbot_A=Nico_shieldbot:new{
	Size = 3,
	ShieldFriendly = true,
	UpgradeDescription="Increase the size of the target area by 1, and shield allied units and buildings.",
	TipImage = {
		Unit = Point(2,2),
		Enemy1 = Point(1,2),
		Enemy2 = Point(3,2),
		Friendly1 = Point(0,1),
		Friendly2 = Point(2,1),
		Building = Point(2,3),
		Mountain = Point(4,2),
		Target = Point(2,2),
		Second_Origin = Point(2,2),
		Second_Target = Point(0,1),
		CustomPawn="Nico_shieldbot_mech",
	},
}
Nico_shieldbot_B=Nico_shieldbot:new{
	UpgradeDescription="If the target is already shielded, explode the shield to increase damage by 1.",
	Blast = true,
	TipImage = {
		Unit = Point(2,2),
		Enemy1 = Point(1,2),
		Enemy2 = Point(3,2),
		Mountain1 = Point(0,2),
		Mountain2 = Point(4,2),
		Target = Point(2,2),
		Second_Origin = Point(2,2),
		Second_Target = Point(2,2),
		CustomPawn="Nico_shieldbot_mech",
	},
}
Nico_shieldbot_AB=Nico_shieldbot_B:new{
	Size = 3,
	ShieldFriendly = true,
	TipImage = {
		Unit = Point(2,2),
		Enemy1 = Point(1,2),
		Enemy2 = Point(3,2),
		Enemy3 = Point(3,0),
		Friendly1 = Point(1,0),
		Friendly2 = Point(2,1),
		Building = Point(2,3),
		Mountain1 = Point(0,2),
		Mountain2 = Point(4,2),
		Target = Point(2,2),
		Second_Origin = Point(2,2),
		Second_Target = Point(2,0),
		CustomPawn="Nico_shieldbot_mech",
	},
}
--Fatal Freeze and Zenith's Guard--
local function Nico_FatalFreeze(mission, pawn, weaponId, p1, p2, skillEffect)
	if (weaponId == "Nico_laserbot_A") or (weaponId == "Nico_laserbot_AB") then	
		if Board:IsTipImage() then Board:AddPawn("BombRock",Point(2,1)) end
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

local function Nico_MoveShield(mission, pawn, weaponId, p1, p2)
	i = pawn:GetId()
	local IsRealMission = true and (mission ~= nil) and (mission ~= Mission_Test) and Board	and Board:IsMissionBoard()
	local adjacent_mech = IsRealMission and ((Board:GetPawn((i+1)%3):GetSpace():Manhattan(p2)==1) or (Board:GetPawn((i+2)%3):GetSpace():Manhattan(p2)==1))
	if _G[pawn:GetType()].NicoIsRobot and weaponId == "Move" and adjacent_mech then
		Game:TriggerSound("/props/shield_activated")
		pawn:SetShield(true)
	end
end

local function Nico_TeamRepair(mission, pawn, weaponId, p1, targetArea)
	if _G[pawn:GetType()].NicoIsRobot and weaponId == "Skill_Repair" then
		for dir = DIR_START, DIR_END do
			local curr = p1 + DIR_VECTORS[dir]
			if Board:IsPawnSpace(curr) and _G[Board:GetPawn(curr):GetType()].NicoIsRobot then
				targetArea:push_back(curr)
			end
		end
	end
end

local function EVENT_onModsLoaded()
	modapiext:addTargetAreaBuildHook(Nico_TeamRepair)
	modapiext:addSkillBuildHook(Nico_FatalFreeze)
	modapiext:addSkillStartHook(Nico_MoveShield)
end

modApi.events.onModsLoaded:subscribe(EVENT_onModsLoaded)

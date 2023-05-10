local path = mod_loader.mods[modApi.currentMod].resourcePath
local BoardEvents = require(modApi:getCurrentMod().scriptPath .."libs/boardEvents")
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
	modApi:addWeaponDrop("Nico_cannonbot")
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
	function Nico_artillerybot:FireFlyBossFlip(point)
		local Mirror = false
	
		if Board:IsPawnSpace(point) and (Board:GetPawn(point):GetType() == "FireflyBoss" or Board:GetPawn(point):GetType() == "DNT_JunebugBoss") and Board:GetPawn(point):IsQueued()then
			Mirror = true
		end
	
		if Mirror then
			local threat = Board:GetPawn(point):GetQueuedTarget()
			local flip = (GetDirection(threat - point)+1)%4
			local newthreat = point + DIR_VECTORS[flip]
			if not Board:IsValid(newthreat) then
				newthreat = point - DIR_VECTORS[flip]
			end
			return "Board:GetPawn("..point:GetString().."):SetQueuedTarget("..newthreat:GetString()..")"
		else
			return ""
		end
	end
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
			if self.Damage == 2 then damage.sSound = "/impact/generic/explosion_large" end
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
			push_dir = DIR_FLIP
		end
		local damage = SpaceDamage(p2, self.Damage)
	
		for i = -1,1 do
			damage = SpaceDamage(p2 + DIR_VECTORS[(dir+1)%4]*i, self.Damage, push_dir)
			if p1 == p3 then
				damage.sAnimation = "ExploArt"..self.Damage
			else
				damage.sAnimation = "explopush"..self.Damage.."_"..push_dir
			end
			damage.sSound = "/impact/generic/explosion"
			if self.Damage == 2 then damage.sSound = "/impact/generic/explosion_large" end
			if not self.BuildingDamage and self.shield and Board:IsBuilding(p2 + DIR_VECTORS[(dir+1)%4]*i) then
				damage.iDamage = DAMAGE_ZERO
				damage.iShield=1
				if p1 == p3 then
					damage.sAnimation = "ExploRepulse"..self.Damage
				else
					damage.sAnimation = "airpush_"..push_dir
				end
				ret:AddArtillery(damage,"effects/shotup_missileswarm.png", NO_DELAY)
			elseif self.Damage==2 then
				ret:AddArtillery(damage,"effects/shotup_robot.png", NO_DELAY)--
			else
				ret:AddArtillery(damage,"effects/shotup_tribomb_missile.png", NO_DELAY)
			end
			if p1 == p3 then ret:AddScript(self:FireFlyBossFlip(p2 + DIR_VECTORS[(dir+1)%4]*i)) end
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
	modApi:addWeaponDrop("Nico_artillerybot")
------Knight Bot------
Nico_knightbot = Punch:new{
	Name = "0th KPR Sword Mark II",
	Description = "Dash to damage and push the target. If the target was shielded, attack again. Phase through Buildings and Mountains. If the destination is blocked, leap backwards to the nearest empty tile.",
	Icon = "weapons/Nico_knightbot.png",
	Class = "TechnoVek",
	Damage = 1,
	PathSize = INT_MAX,
	ZoneTargeting = ZONE_DIR,
	Dash = true,
	Phase = true,
	Shield = false,
	Upgrades = 2,
	UpgradeList={"Shield","+2 Damage"},
	UpgradeCost={2,3},
	Push = true,
	LaunchSound="/weapons/charge",
	ImpactSound="",--/weapons/sword",
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
	modApi:appendAsset("img/weapons/Nico_knightbot.png", path .."img/weapons/Nico_knightbot.png")
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

		if self.Shield then
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
		Shield = true,
		UpgradeDescription="Shield Buildings and Mountains.",
	}
	Nico_knightbot_B=Nico_knightbot:new{
		UpgradeDescription="Increases damage by 2.",
		Damage=3,
	}
	Nico_knightbot_AB=Nico_knightbot_A:new{
		Damage=3,
	}
	modApi:addWeaponDrop("Nico_knightbot")
------Shield Bot------
Nico_shieldbot = Science_Placer:new{
	Class = "TechnoVek",
	Name="NRG Shield Mark II",
	Description="Shield self or nearby tile, and push adjacent tiles away. If the target is already shielded, explode the shield to damage adjacent enemies.",
	Icon = "weapons/Nico_shieldbot.png",
	LaunchSound = "/weapons/enhanced_tractor",
	Explosion = "",--shieldbotpulse",
	Size = 2,
	PathSize = 1,
	Damage = 1,
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
		Second_Target = Point(2,2),
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
		local blastFlag = (Board:IsPawnSpace(p2) and Board:GetPawn(p2):IsShield()) or Board:IsShield(p2)
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
			if self.Damage == 2 then
				ret:AddSound("/impact/generic/explosion_large")
			else
				ret:AddSound("/impact/generic/explosion")
			end
			if Board:IsPawnSpace(p2) and Board:GetPawn(p2):IsShield() then
				ret:AddScript("Board:GetPawn("..p2:GetString().."):SetShield(false,false)")
			end
			if Board:IsShield(p2) then
				ret:AddScript("Board:SetShield("..p2:GetString()..",false,false)")
			end
		else
			ret:AddSound("/weapons/science_repulse")
		end
	
		for i = DIR_START, DIR_END do
			damage = SpaceDamage(p2 + DIR_VECTORS[i], 0, i)
			damage.sAnimation = "airpush_"..i
			if blastFlag then damage.sAnimation = "explopush"..self.Damage.."_"..i damage.iDamage = self.Damage end
			if Board:IsBuilding(p2 + DIR_VECTORS[i]) or (Board:IsPawnSpace(p2 + DIR_VECTORS[i]) and Board:GetPawn(p2 + DIR_VECTORS[i]):GetTeam() == TEAM_PLAYER) then
				damage.iDamage = 0
				damage.sAnimation = "airpush_"..i
				if self.ShieldFriendly then damage.iShield = 1 end
			end
			ret:AddDamage(damage)
		end
	
		return ret
	end
	Nico_shieldbot_A=Nico_shieldbot:new{
		Size = 3,
		ShieldFriendly = true,
		UpgradeDescription="Increase the size of the target area by 1, and shield adjacent allied units and buildings.",
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
		Damage = 2,
		UpgradeDescription="Increase explosion damage by 1.",
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
	modApi:appendAsset("img/weapons/Nico_shield_explode_glow.png", path.."img/weapons/Nico_shield_explode_glow.png")
	Location["weapons/Nico_shield_explode_glow.png"] = Point(-16,8)
	modApi:appendAsset("img/weapons/Nico_shieldbot.png", path .."img/weapons/Nico_shieldbot.png")
	modApi:appendAsset("img/effects/shield_bot_pulse.png", path.. "img/effects/shield_bot_pulse.png")
	ANIMS.shieldbotpulse = Animation:new{
		Image = "effects/shield_bot_pulse.png",
		NumFrames = 8,
		Time = 0.05,
	
		PosX = -33,
		PosY = -14,
	}
	modApi:addWeaponDrop("Nico_shieldbot")
------Miner Bot------
	--The deployable's palettes
	modApi:addPalette{
		ID = "Nico_mine_iceflower",
		Name = "Mine-Bot Mark I",
		image="units/player/Nico_minerbot_mech_ns.png",
		PlateHighlight = {233,161,172},--lights
		PlateLight     = {189,220,255},--main highlight
		PlateMid       = {146,182,207},--main light
		PlateDark      = {91,107,158},--main mid
		PlateOutline   = {32,54,55},--main dark
		PlateShadow    = {60,91,117},--metal dark
		BodyColor      = {104,116,193},--metal mid
		BodyHighlight  = {219,255,242},--metal light
	}
	modApi:addPalette{
		ID = "Nico_mine_winter",
		Name = "Mine-Bot Mark III",
		image="units/player/Nico_minerbot_mech_ns.png",
		PlateHighlight = {255,245,101},--lights
		PlateLight     = {217,216,221},--main highlight
		PlateMid       = {123,122,128},--main light
		PlateDark      = {71,72,77},--main mid
		PlateOutline   = {46,45,51},--main dark
		PlateShadow    = {71,163,157},--metal dark
		BodyColor      = {144,215,219},--metal mid
		BodyHighlight  = {246,255,255},--metal light
	}
--The deployable units
	Nico_Snowmine = Pawn:new{
		Name = "Mine-Bot Mark I",
		Health = 1,
		Class = "TechnoVek",
		ImageOffset = modApi:getPaletteImageOffset("Nico_mine_iceflower"),
		DefaultTeam = TEAM_PLAYER,
		MoveSpeed = 0,
		MoveAtk = 3,
		IgnoreSmoke = true,
		Image = "Nico_minerbot_mech",
		SkillList = { "Nico_minibot" },
		SoundLocation = "/enemy/snowmine_1/",
		DefaultTeam = TEAM_PLAYER,
		ImpactMaterial = IMPACT_METAL,
		Corpse = false,
	}
	Nico_SnowmineA = Nico_Snowmine:new{
		Name = "Mine-Bot Mark II",
		MoveAtk = 4,
	}
	modApi:appendAsset("img/weapons/Nico_minerbot.png", path .."img/weapons/Nico_minerbot.png")
	Nico_minibot = Skill:new{
		Name = "Minelayer",
		Class="TechnoVek",
		Icon="weapons/Nico_minerbot.png",
		Description="Deploy a single Freeze mine.",
		TipImage = {
			Unit = Point(2,3),
			Target = Point(2,1),
			CustomPawn = "Nico_Snowmine",
		}
	}
	function Nico_minibot:GetTargetArea(point)
		return Board:GetReachable(point, _G[Pawn:GetType()].MoveAtk, Pawn:GetPathProf())
	end
	function Nico_minibot:GetSkillEffect(p1,p2)
	    local ret = SkillEffect()
	
		if p1 ~= p2 then
			local damage = SpaceDamage(p1)
			damage.sItem = "Freeze_Mine"
			ret:AddDamage(damage)
			ret:AddMove(Board:GetPath(p1, p2, Pawn:GetPathProf()), FULL_DELAY)
		end
	
		return ret
	end
	Nico_Snowmine2 = Pawn:new{
		Name = "Mine-Bot Mark III",
		Health = 1,
		Class = "TechnoVek",
		DefaultTeam = TEAM_PLAYER,
		MoveSpeed = 0,
		MoveAtk = 3,
		IgnoreSmoke = true,
		Image = "Nico_minerbot_mech",
		ImageOffset = modApi:getPaletteImageOffset("Nico_mine_winter"),
		SkillList = { "Nico_minibot2" },
		SoundLocation = "/enemy/snowmine_1/",
		DefaultTeam = TEAM_PLAYER,
		ImpactMaterial = IMPACT_METAL,
		Corpse = false,
	}
	Nico_Snowmine2A = Nico_Snowmine2:new{
		Name = "Mine-Bot Mark IV",
		MoveAtk = 4,
	}
	Nico_minibot2 = Skill:new{
		Name = "Double Minelayer",
		Class="TechnoVek",
		Icon="weapons/Nico_minerbot.png",
		Description="Deploy two Freeze mines.",
		TwoClick = true,
		TipImage = {
			Unit = Point(2,3),
			Target = Point(2,1),
			Second_Click = Point(2,3),
			CustomPawn = "Nico_Snowmine2",
		}
	}
	function Nico_minibot2:GetTargetArea(point)
		return Board:GetReachable(point, _G[Pawn:GetType()].MoveAtk, Pawn:GetPathProf())
	end
	function Nico_minibot2:GetSecondTargetArea(p1,p2)
		local ret = Board:GetReachable(p2, _G[Pawn:GetType()].MoveAtk, Pawn:GetPathProf())
		ret:push_back(p1)
		return ret
	end
	function Nico_minibot2:IsTwoClickException(p1,p2)
		return ((not Pawn:IsShield()) and (Board:GetItem(p2) == "Freeze_Mine" or Board:GetItem(p2) == "Nico_Freeze_Mine" or Board:GetItem(p2) == "lmn_Minelayer_Item_Mine")) or Board:GetItem(p2) == "Item_Mine"
	end
	function Nico_minibot2:GetSkillEffect(p1,p2)
	    local ret = SkillEffect()
	
		if p1 ~= p2 then
			local damage = SpaceDamage(p1)
			damage.sItem = "Freeze_Mine"
			ret:AddDamage(damage)
			ret:AddMove(Board:GetPath(p1, p2, Pawn:GetPathProf()), FULL_DELAY)
		end
	
		return ret
	end
	function Nico_minibot2:GetFinalEffect(p1,p2,p3)
		local ret = self:GetSkillEffect(p1,p2)
		ret:AddDelay(0.2)--so it can pick up time pods
		if p2 ~= p3 then
			local damage = SpaceDamage(p2)
			damage.sItem = "Freeze_Mine"
			ret:AddDamage(damage)
			ret:AddMove(Board:GetPath(p2, p3, Pawn:GetPathProf()), FULL_DELAY)
		end
	
		return ret
	end
--The mech's weapon
Nico_minerbot=ArtilleryDefault:new{
	Icon = "weapons/ranged_defensestrike.png",
	Name="Mine-Bot Deployer",
	Description="Launch a Mine-Bot at a tile, pushing tiles to the left and right, creating an improved Mine-Bot on kill.",
	Class="TechnoVek",
	ArtilleryStart = 2,
	ArtillerySize = 8,
	SpawnBot = "Nico_Snowmine",
	SpawnBot2 = "Nico_Snowmine2",
	LaunchSound = "/weapons/artillery_volley",
	ImpactSound = "/impact/generic/mech",
	Damage = 1,
	Upgrades = 2,
	UpgradeList={"+1 Move","+2 Damage"},
	UpgradeCost = { 1,3 },
	TipImage = {
		Unit = Point(2,4),
		Second_Origin=Point(2,4),
		Enemy = Point(2,1),
		Enemy2 = Point(3,1),
		Target = Point(2,1),
		Second_Target=Point(2,2),
		CustomEnemy = "Leaper1",
		CustomPawn = "Nico_minerbot_mech",
	}
	}
		function Nico_minerbot:GetSkillEffect(p1,p2)
			local ret = SkillEffect()
			local dir = GetDirection(p2 - p1)
			local damage = SpaceDamage(p2, self.Damage)
	
			if Board:IsValid(p2) and not Board:IsBlocked(p2,PATH_PROJECTILE) then
				damage.sPawn = self.SpawnBot
				damage.sAnimation = ""
				damage.iDamage = 0
			else
				damage.sAnimation = "ExploArt0"
				damage.bKO_Effect = Board:IsDeadly(damage,Pawn)
				if damage.bKO_Effect then damage.sPawn = self.SpawnBot2 end
			end
	
			ret:AddBounce(p1, 1)
			ret:AddArtillery(damage,"effects/shotup_robot.png")
			--[[if damage.bKO_Effect then
				ret:AddAnimation(damage.loc,"Nico_minerbot_meche", ANIM_NO_DELAY)
			end]]
			ret:AddBounce(p2, self.BounceAmount)
			ret:AddBoardShake(0.15)
			--if damage.bKO_Effect then ret:AddSound("/enemy/snowmine_1/death") end
	
			local damagepush = SpaceDamage(p2 + DIR_VECTORS[(dir+1)%4], 0, (dir+1)%4)
			damagepush.sAnimation = "airpush_"..((dir+1)%4)
			ret:AddDamage(damagepush) 
			damagepush = SpaceDamage(p2 + DIR_VECTORS[(dir-1)%4], 0, (dir-1)%4)
			damagepush.sAnimation = "airpush_"..((dir-1)%4)
			ret:AddDamage(damagepush)
			return ret
		end
		Nico_minerbot_A=Nico_minerbot:new{
			SpawnBot = "Nico_SnowmineA",
			SpawnBot2 = "Nico_Snowmine2A",
			UpgradeDescription = "Increases the Mine-Bot's move distance to 4.",
		}
	Nico_minerbot_B=Nico_minerbot:new{
		Damage = 3,
		UpgradeDescription = "Increases the artillery attack damage by 2.",
		TipImage = {
			Unit = Point(2,4),
			Second_Origin=Point(2,4),
			Enemy = Point(2,1),
			Enemy2 = Point(3,1),
			Target = Point(2,1),
			Second_Target=Point(2,2),
			CustomEnemy = "Firefly1",
			CustomPawn = "Nico_minerbot_mech",
		}
	}
	Nico_minerbot_AB=Nico_minerbot_B:new{
		SpawnBot = "Nico_SnowmineA",
		SpawnBot2 = "Nico_Snowmine2A",
	}
	modApi:addWeaponDrop("Nico_minerbot")
------Juggernaut Bot------
Nico_juggernaut = Skill:new{  
	Name = "Juggernaut Engines",
	Description = "Charge through units, destroying them.",
	Class="TechnoVek",
	Icon = "weapons/brute_beetle.png",
	LaunchSound = "/weapons/charge",
	Damage = DAMAGE_DEATH,
	Upgrades=2,
	UpgradeCost={1,2},
	UpgradeList={"Terraforming","Drift"},
	Phasing = 0,
	Range = 7,
	TipImage = {
		Unit = Point(1,2),
		Enemy = Point(2,2),
		Enemy2 = Point(3,2),
		Target = Point(4,2),
		CustomEnemy = "Snowtank2",
		CustomPawn = "Nico_juggernautbot_mech",
	}
	}
	function Nico_juggernaut:GetTargetArea(p1)
		local ret = PointList()
		for dir = DIR_START, DIR_END do
			local stillgood = true
			local max_i = 0
			for i = 1,self.Range do
				local point = p1 + DIR_VECTORS[dir]*i
				if stillgood and not Board:IsBlocked(point, PATH_PROJECTILE) then
					max_i = i
				end
				if self.Phasing ~= 1 and (Board:IsBuilding(point) or Board:IsTerrain(point,TERRAIN_MOUNTAIN)) then
					stillgood = false --needed?
					break
				end
			end
			if max_i > 0 then
				for i = 1,max_i do
					point = p1 + DIR_VECTORS[dir]*i
					ret:push_back(point)
				end
			end
		end
		return ret
	end

	function Nico_juggernaut:GetSkillEffect(p1,p2)
		local ret = SkillEffect()
		local endcharge = p2
		local direction = GetDirection(p2 - p1)
		local crushing = false

		-- air graphics to emphasize speed.
		local damage0 = SpaceDamage(p1, 0)
		damage0.sAnimation = "airpush_".. ((direction+2)%4)
		damage0.sSound = self.LaunchSound
		ret:AddDamage(damage0)
		ret:AddDelay(0.5)
	
		-- Jump target to next open tile
		if Board:IsBlocked(p2, Pawn:GetPathProf()) then
			for i = 1,6 do
				local point2 = p2 + DIR_VECTORS[direction]*i
				if not Board:IsBlocked(point2, Pawn:GetPathProf()) then
					endcharge = point2
					break
				end
			end
		end
	    local distance = p1:Manhattan(endcharge)
		
		ret:AddCharge(Board:GetPath(p1, endcharge, PATH_FLYER), NO_DELAY)
	
		for i = 1,distance-1 do	
			ret:AddDelay(0.1)
			local midpoint = p1 + DIR_VECTORS[direction]*i
		
			local dodamage = true		
			if Board:IsBuilding(midpoint) then
				dodamage = false
			end
		
			if dodamage == true then
				local damage = SpaceDamage(midpoint,self.Damage)
				ret:AddDamage(damage)
			end
		end
		return ret
	end
	Nico_juggernaut_A=Nico_juggernaut:new{
		Phasing=1,
		UpgradeDescription="Can charge through buildings and mountains, won't destroy buildings.",
		TipImage = {
			Unit = Point(0,2),
			Enemy = Point(1,2),
			Building = Point(2,2),
			Mountain = Point(3,2),
			Target = Point(4,2),
			CustomEnemy = "Snowtank2",
			CustomPawn = "Nico_juggernautbot_mech",
		}
	}
	Nico_juggernaut_B=Nico_juggernaut:new{
		TwoClick=true,
		UpgradeDescription="Can drift, cracking a tile and then charging through a second line of tiles.",
		TipImage = {
			Unit = Point(0,2),
			Enemy = Point(2,1),
			Enemy2 = Point(1,2),
			Target = Point(2,2),
			Second_Click=Point(2,0),
			CustomEnemy = "Snowtank2",
			CustomPawn = "Nico_juggernautbot_mech",
			Length = 5,
		}
	}
	function Nico_juggernaut_B:GetSecondTargetArea(p1,p2,p3)
		local ret = self:GetTargetArea(p2)
		self:RemoveBackwards(ret,p1,p2)
		self:RemoveForwards(ret,p1,p2) -- also remove forwards
		return ret
	end
	function Nico_juggernaut_B:IsTwoClickException(p1,p2,p3)
		return Board:IsBuilding(p2) or Board:IsTerrain(p2,TERRAIN_MOUNTAIN) or Board:IsTerrain(p2,TERRAIN_WATER) or Board:IsTerrain(p2,TERRAIN_LAVA) or Board:IsBlocked(p2, Pawn:GetPathProf()) or ((not Pawn:IsShield()) and (Board:GetItem(p2) == "Freeze_Mine" or Board:GetItem(p2) == "Nico_Freeze_Mine" or Board:GetItem(p2) == "lmn_Minelayer_Item_Mine")) or Board:GetItem(p2) == "Item_Mine"
	end
    function Nico_juggernaut_B:GetFinalEffect(p1,p2,p3)
        local ret = self:GetSkillEffect(p1,p2)
        if p1 == p3 then return ret end    
		local endcharge = p3
		local direction = GetDirection(p3 - p2)
		local crushing = false

		-- air graphics to emphasize speed.
		local damage0 = SpaceDamage(p2, 0)
		damage0.sSound = self.LaunchSound
		damage0.sAnimation = "airpush_".. ((direction+2)%4)
		ret:AddDamage(damage0)
		ret:AddDelay(0.5)
		local crack = SpaceDamage(p2, 0)
		crack.iCrack = EFFECT_CREATE
		AddDamage(crack)
	
		-- Jump target to next open tile
		if Board:IsBlocked(p3, Pawn:GetPathProf()) then
			for i = 1,6 do
				local point2 = p3 + DIR_VECTORS[direction]*i
				if not Board:IsBlocked(point2, Pawn:GetPathProf()) then
					endcharge = point2
					break
				end
			end
		end
	    local distance = p2:Manhattan(endcharge)
		
		ret:AddCharge(Board:GetPath(p2, endcharge, PATH_FLYER), NO_DELAY)
	
		for i = 1,distance-1 do	
			ret:AddDelay(0.1)
			local midpoint = p2 + DIR_VECTORS[direction]*i
		
			local dodamage = true		
			if Board:IsBuilding(midpoint) then
				dodamage = false
			end
		
			if dodamage == true then
				local damage = SpaceDamage(midpoint,self.Damage)
				ret:AddDamage(damage)
			end
		end

		return ret
	end
	Nico_juggernaut_AB=Nico_juggernaut_B:new{
		Phasing=1,
		TipImage = {
			Unit = Point(0,2),
			Enemy = Point(2,1),
			Mountain = Point(1,2),
			Target = Point(2,2),
			Second_Click=Point(2,0),
			CustomEnemy = "Snowtank2",
			CustomPawn = "Nico_juggernautbot_mech",
			Length = 5,
		}
	}
	modApi:addWeaponDrop("Nico_juggernaut")
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

Nico_Freeze_Mine = { Image = "combat/freeze_mine.png", Damage = SpaceDamage(0), Tooltip = "freeze_mine", Icon = "combat/icons/icon_frozenmine_glow.png", UsedImage = ""}--needs to be global not local

local function Nico_MoveShield(mission, pawn, weaponId, p1, p2)
	i = pawn:GetId()
	local IsRealMission = true and (mission ~= nil) and (mission ~= Mission_Test) and Board	and Board:IsMissionBoard()
	local adjacent_mech = IsRealMission and ((Board:GetPawn((i+1)%3):GetSpace():Manhattan(p2)==1) or (Board:GetPawn((i+2)%3):GetSpace():Manhattan(p2)==1))
	if pawn and _G[pawn:GetType()].NicoIsRobot and weaponId == "Move" and adjacent_mech then
		Game:TriggerSound("/props/shield_activated")
		pawn:SetShield(true)
	end
	if pawn and pawn:GetType() == "Nico_minerbot_mech" and weaponId == "Move" then
		mission.Nico_FireSpace = {p1,Board:IsFire(p1)}
		if Board:IsFire(p1) then Board:SetItem(p1,"Freeze_Mine") else Board:SetItem(p1,"Nico_Freeze_Mine") end
	end
end

local function Nico_MoveShieldWeapon(mission, pawn, weaponId, p1, p2, p3, skillEffect)
	for i = 1, skillEffect.effect:size() do
		local spaceDamage = skillEffect.effect:index(i)
		if spaceDamage:IsMovement() and spaceDamage:GetMoveType() == 0 then
			local movePawn = Board:GetPawn(spaceDamage:MoveStart())
			local i = movePawn:GetId()
			local IsRealMission = true and (mission ~= nil) and (mission ~= Mission_Test) and Board	and Board:IsMissionBoard()
			local endpoint = spaceDamage:MoveEnd()--spaceDamage:MoveStart()
			local adjacent_mech = IsRealMission and ((Board:GetPawn((i+1)%3):GetSpace():Manhattan(endpoint)==1) or (Board:GetPawn((i+2)%3):GetSpace():Manhattan(endpoint)==1))
			if movePawn and _G[movePawn:GetType()].NicoIsRobot and adjacent_mech then
				local dam = SpaceDamage(spaceDamage:MoveStart(),0)
				dam.iShield = 1
				skillEffect:AddDamage(dam)
				skillEffect:AddScript("Game:TriggerSound(\"/props/shield_activated\")")
				skillEffect:AddScript("Board:GetPawn("..i.."):SetShield(true)")
			end
		end
	end
end

local function Nico_TeamRepair(mission, pawn, weaponId, p1, targetArea)
	if pawn and _G[pawn:GetType()].NicoIsRobot and weaponId == "Skill_Repair" then
		for dir = DIR_START, DIR_END do
			local curr = p1 + DIR_VECTORS[dir]
			if Board:IsPawnSpace(curr) and _G[Board:GetPawn(curr):GetType()].NicoIsRobot then
				targetArea:push_back(curr)
			end
		end
	end
end

local function Nico_UnMine(mission, pawn, undonePosition)
	if pawn:GetType() == "Nico_minerbot_mech" then
		if mission.Nico_FireSpace[2] then Board:SetFire(mission.Nico_FireSpace[1],true) end
		if Board:IsTerrain(pawn:GetSpace(),TERRAIN_WATER) then Board:RemoveItem(pawn:GetSpace()) end
	end
end

local function EVENT_onModsLoaded()
	modapiext:addTargetAreaBuildHook(Nico_TeamRepair)
	modapiext:addSkillBuildHook(Nico_FatalFreeze)
	modapiext:addSkillStartHook(Nico_MoveShield)
	modapiext:addFinalEffectBuildHook(Nico_MoveShieldWeapon)
	modapiext:addPawnUndoMoveHook(Nico_UnMine)
end

modApi.events.onModsLoaded:subscribe(EVENT_onModsLoaded)

local undoPawnId_thisFrame = nil

modapiext.events.onPawnUndoMove:subscribe(function(mission, pawn)
	undoPawnId_thisFrame = pawn:GetId()
end)

BoardEvents.onItemRemoved:subscribe(function(loc, removed_item)
	if removed_item == "Nico_Freeze_Mine" then
		local pawn = Board:GetPawn(loc)
		if pawn and pawn:GetId() == undoPawnId_thisFrame then
			-- do nothing
		else
			local freeze_damage = SpaceDamage(loc, 0)
			freeze_damage.sSound = "/props/freezing_mine"
			freeze_damage.sAnimation = ""
			freeze_damage.iFrozen = 1
			Board:DamageSpace(freeze_damage)
		end
	end
	if removed_item == "Freeze_Mine" then
		local pawn = Board:GetPawn(loc)
		if pawn and pawn:GetType() == "Train_Armored" then
			pawn:SetFrozen(true)
		end
	end
end)

modApi.events.onModsInitialized:subscribe(function()
	modApi.events.onMissionUpdate:subscribe(function(mission)
		undoPawnId_thisFrame = nil
	end)
end)

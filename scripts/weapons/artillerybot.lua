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
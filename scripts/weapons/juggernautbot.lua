------Juggernaut Bot------
Nico_juggernaut = Skill:new{  
	Name = "Juggernaut Engines V2",
	Description = "Charge through units, destroying them.\nFreezes any water it terminates on.",
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
		Water=Point(4,2),
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
				if stillgood and not Board:IsBlocked(point, Pawn:GetPathProf()) then
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
		ret:AddBounce(p1,1)
		local damage0 = SpaceDamage(p1, 0)
		damage0.sAnimation = "airpush_".. ((direction+2)%4)
		damage0.sSound = self.LaunchSound
		ret:AddDamage(damage0)
		ret:AddBurst(p1,"Emitter_Crack_Start", DIR_NONE)
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
			if Board:IsBuilding(midpoint) or Board:IsPod(midpoint) then
				dodamage = false
			end
		
			if dodamage == true then
				local damage = SpaceDamage(midpoint,self.Damage)
				ret:AddDamage(damage)
				ret:AddBurst(midpoint,"Emitter_Crack_Start", DIR_NONE)
				ret:AddBounce(midpoint,1)
			end
		end
		if Board:IsTerrain(endcharge,TERRAIN_WATER) then
			local ice = SpaceDamage(endcharge,0)
			ice.iTerrain = TERRAIN_ICE
			ice.sImageMark = "effects/Nico_icon_ice_glow.png"
			if Board:IsAcid(endcharge) then
				ice.sAnimation="Splash_acid"
			elseif Board:IsTerrain(endcharge,TERRAIN_LAVA) then
				ice.sAnimation="Splash_lava"
			else
				ice.sAnimation="Splash"
			end
			ret:AddDamage(ice)
			ret:AddSound("/impact/generic/ice")
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
			Water = Point(2,0),
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
		ret:push_back(p1)
		return ret
	end
	function Nico_juggernaut_B:IsTwoClickException(p1,p2)
		return Board:IsBuilding(p2) or Board:IsTerrain(p2,TERRAIN_MOUNTAIN) or Board:IsBlocked(p2, Pawn:GetPathProf()) or ((not Pawn:IsShield()) and (Board:GetItem(p2) == "Freeze_Mine" or Board:GetItem(p2) == "Nico_Freeze_Mine" or Board:GetItem(p2) == "lmn_Minelayer_Item_Mine" or Board:GetItem(p2) == "Djinn_Spike_Mine" or Board:GetItem(p2) == "Djinn_Spike_Mine2" or Board:GetItem(p2) == "Nautilus_Spike_Mine" or Board:GetItem(p2) == "Nautilus_Spike_Mine2")) or Board:GetItem(p2) == "Item_Mine"
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
		ret:AddBounce(p2,3)
		local crack = SpaceDamage(p2, 0)
		crack.iCrack = EFFECT_CREATE
		ret:AddDamage(crack)
		ret:AddBurst(p2,"Emitter_Crack_Start2", DIR_NONE)

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
			if Board:IsBuilding(midpoint) or Board:IsPod(midpoint) then
				dodamage = false
			end
		
			if dodamage == true then
				local damage = SpaceDamage(midpoint,self.Damage)
				ret:AddDamage(damage)
				ret:AddBurst(midpoint,"Emitter_Crack_Start2", DIR_NONE)
				ret:AddBounce(midpoint,1)
			end
		end
		if Board:IsTerrain(endcharge,TERRAIN_WATER) then
			local ice = SpaceDamage(endcharge,0)
			ice.iTerrain = TERRAIN_ICE
			ice.sImageMark = "effects/Nico_icon_ice_glow.png"
			if Board:IsAcid(endcharge) then
				ice.sAnimation="Splash_acid"
			elseif Board:IsTerrain(endcharge,TERRAIN_LAVA) then
				ice.sAnimation="Splash_lava"
			else
				ice.sAnimation="Splash"
			end
			ret:AddDamage(ice)
			ret:AddSound("/impact/generic/ice")
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
			Water = Point(2,2),
			Second_Click=Point(2,0),
			CustomEnemy = "Snowtank2",
			CustomPawn = "Nico_juggernautbot_mech",
			Length = 5,
		}
	}
	modApi:addWeaponDrop("Nico_juggernaut")
	local path = mod_loader.mods[modApi.currentMod].resourcePath
	modApi:appendAsset("img/effects/Nico_icon_ice_glow.png", path.."img/weapons/Nico_icon_ice_glow.png")
	Location["effects/Nico_icon_ice_glow.png"] = Point(-10,8)

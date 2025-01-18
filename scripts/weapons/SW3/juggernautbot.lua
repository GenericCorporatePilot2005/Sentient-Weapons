
------Juggernaut Bot------
Nico_juggernaut = Skill:new{  
	Name = "Juggernaut Engines V2",
	Description = "Charge through units, destroying them.\nFreezes any water it terminates on.",
	Class = "TechnoVek",
	Icon = "weapons/Nico_juggernautbot.png",
	LaunchSound = "/weapons/charge",
	Damage = DAMAGE_DEATH,
	Upgrades = 2,
	UpgradeCost = {1,2},
	UpgradeList = {"Terraforming","Drift"},
	Phasing = 0,
	Range = 7,
	TipImage = {
		Unit = Point(1,2),
		Enemy = Point(2,2),
		Enemy2 = Point(3,2),
		Water = Point(4,2),
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
		if Board:IsTipImage() then
			if tosx_mission_IceHulk then
				Board:RemovePawn(self.TipImage.Enemy)
				Board:AddPawn("tosx_mission_IceHulk", self.TipImage.Enemy)
				if self.TipImage.Enemy2 then
					Board:AddPawn("tosx_mission_IceHulk", self.TipImage.Enemy2)
				end
			end
		end
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
		
			if Board:IsPawnSpace(midpoint) and Board:GetPawn(midpoint):GetType() == "tosx_mission_IceHulk" then
				local chance = math.random()
				if chance > 0.15 then
					ret:AddVoice("Mission_tosx_Juggernaut_Ram",-1)
				end
				
				crushing = true
			end

			local dodamage = true		
			if Board:IsBuilding(midpoint) or Board:IsPod(midpoint) then
				dodamage = false
			end
		
			if dodamage == true then
				local damage = SpaceDamage(midpoint,self.Damage)
				ret:AddDamage(damage)
			end
			ret:AddBurst(midpoint,"Emitter_Crack_Start", DIR_NONE)
			ret:AddBounce(midpoint,1)
		end
		if Board:IsTerrain(endcharge,TERRAIN_WATER) then
			local ice = SpaceDamage(endcharge,0)
			local del = SpaceDamage(0)
			del.fDelay = -1
			if not Board:IsTerrain(ice.loc,TERRAIN_LAVA) then
				ice.iTerrain = TERRAIN_ICE
			elseif Board:IsTerrain(ice.loc,TERRAIN_LAVA) then
				ice.iTerrain = TERRAIN_ROAD
			end
			ice.sImageMark = "combat/icons/Nico_icon_ice_glow.png"
			if Board:IsAcid(endcharge) then
				ice.sAnimation="Splash_acid"
			elseif Board:IsTerrain(endcharge,TERRAIN_LAVA) then
				ice.sAnimation="Splash_lava"
			else
				ice.sAnimation="Splash"
			end
			ret:AddDamage(del)
			ret:AddDamage(ice)
			ret:AddSound("/impact/generic/ice")
		end
		if Board:GetItem(endcharge) == "Poke_Puddle" then ret:AddDamage(SpaceDamage(endcharge,0,direction)) end
		return ret
	end

	Nico_juggernaut_A = Nico_juggernaut:new{
		Phasing = 1,
		UpgradeDescription = "Can charge through buildings and mountains, won't destroy buildings.",
		TipImage = {
			Unit = Point(0,2),
			Enemy = Point(1,2),
			Building = Point(2,2),
			Mountain = Point(3,2),
			Water = Point(4,2),
			Target = Point(4,2),
			CustomEnemy = "Snowtank2",
			CustomPawn = "Nico_juggernautbot_mech",
		}
	}
	Nico_juggernaut_B = Nico_juggernaut:new{
		TwoClick = true,
		UpgradeDescription = "Can drift, cracking a tile and then charging through a second line of tiles.",
		TipImage = {
			Unit = Point(0,2),
			Enemy = Point(2,1),
			Enemy2 = Point(1,2),
			Water = Point(2,2),
			Water2 = Point(2,0),
			Target = Point(2,2),
			Second_Click=Point(2,0),
			CustomEnemy = "Snowtank2",
			CustomPawn = "Nico_juggernautbot_mech",
			Length = 5,
		}
	}
	Nico_juggernaut_AB=Nico_juggernaut_B:new{
		Phasing=1,
		TipImage = {
			Unit = Point(0,2),
			Enemy = Point(2,1),
			Mountain = Point(1,2),
			Water = Point(2,2),
			Water2 = Point(2,0),
			Target = Point(2,2),
			Second_Click=Point(2,0),
			CustomEnemy = "Snowtank2",
			CustomPawn = "Nico_juggernautbot_mech",
			Length = 5,
		}
	}
	local mod = modApi:getCurrentMod()
	local path = mod.scriptPath
	local customAnim = require(path.."libs/customAnim")
	function TCcheck(p2)
		local isNotShielded = not Pawn:IsShield()
		local item = Board:GetItem(p2)
		local hasRainbow1 = ANIMS["rainbow1"] and (customAnim:get(p2, "rainbow1") ~= nil)
		local hasRainbow2 = ANIMS["rainbow2"] and (customAnim:get(p2, "rainbow2") ~= nil)
		local isGumTile = Board:GetCustomTile(p2):find("^tatu_gum") ~= nil
		local isOnRoad = Board:IsTerrain(p2, TERRAIN_ROAD)
		local specialMines = {
			"Freeze_Mine",
			"Nico_Freeze_Mine",
			"lmn_Minelayer_Item_Mine",
			"Djinn_Spike_Mine",
			"Djinn_Spike_Mine2",
			"Nautilus_Spike_Mine",
			"Nautilus_Spike_Mine2",
			"tatu_Cookie_Ice",
			"Poke_StealthRock",
			"Poke_SeedFlareItem",
			"tosx_Trap_Mine0",
			"tosx_Trap_Mine1",
			"Nico_Freeze_Mine"
		}

		local isComplexCondition =
			(isNotShielded and list_contains(specialMines, item))
			or item == "Item_Mine"
			or item == "CyborgWeapons_WebItem"
			or item == "Meta_BlobGunk"
			or item == "Poke_Puddle"
			or hasRainbow1
			or hasRainbow2
			or (isGumTile and isOnRoad)
		return isComplexCondition
	end

	function Nico_juggernaut_B:GetSecondTargetArea(p1,p2)
		if Board:IsBuilding(p2) or Board:IsTerrain(p2,TERRAIN_MOUNTAIN) or Board:IsBlocked(p2, Pawn:GetPathProf()) or TCcheck(p2) then return PointList() end
		local ret = self:GetTargetArea(p2)
		self:RemoveBackwards(ret,p1,p2)
		if not Board:IsPod(p2) then
			self:RemoveForwards(ret,p1,p2) -- also remove forwards
		end
		ret:push_back(p1)
		return ret
	end
	function Nico_juggernaut_B:IsTwoClickException(p1,p2)
		return Board:IsBuilding(p2) or Board:IsTerrain(p2,TERRAIN_MOUNTAIN) or Board:IsBlocked(p2, Pawn:GetPathProf()) or TCcheck(p2)
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
		
			if Board:IsPawnSpace(midpoint) and Board:GetPawn(midpoint):GetType() == "tosx_mission_IceHulk" then
				local chance = math.random()
				if chance > 0.15 then
					ret:AddVoice("Mission_tosx_Juggernaut_Ram",-1)
				end
				
				crushing = true
			end

			local dodamage = true		
			if Board:IsBuilding(midpoint) or Board:IsPod(midpoint) then
				dodamage = false
			end
		
			if dodamage == true then
				local damage = SpaceDamage(midpoint,self.Damage)
				ret:AddDamage(damage)
			end
			ret:AddBurst(midpoint,"Emitter_Crack_Start2", DIR_NONE)
			ret:AddBounce(midpoint,1)
		end
		if Board:IsTerrain(endcharge,TERRAIN_WATER) then
			local ice = SpaceDamage(endcharge,0)
			local del = SpaceDamage(0)
			del.fDelay = -1
			if not Board:IsTerrain(ice.loc,TERRAIN_LAVA) then
				ice.iTerrain = TERRAIN_ICE
			elseif Board:IsTerrain(ice.loc,TERRAIN_LAVA) then
				ice.iTerrain = TERRAIN_ROAD
			end
			ice.sImageMark = "combat/icons/Nico_icon_ice_glow.png"
			if Board:IsAcid(endcharge) then
				ice.sAnimation = "Splash_acid"
			elseif Board:IsTerrain(endcharge,TERRAIN_LAVA) then
				ice.sAnimation = "Splash_lava"
			else
				ice.sAnimation = "Splash"
			end
			ret:AddDamage(del)
			ret:AddDamage(ice)
			ret:AddSound("/impact/generic/ice")
		end
		if Board:GetItem(endcharge) == "Poke_Puddle" then ret:AddDamage(SpaceDamage(endcharge,0,direction)) end
		return ret
	end
	modApi:addWeaponDrop("Nico_juggernaut")


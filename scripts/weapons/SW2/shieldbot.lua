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
local path = mod_loader.mods[modApi.currentMod].resourcePath
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
		damage.sImageMark = (blastFlag and "combat/icons/Nico_shield_explode_glow.png") or damage.sImageMark
	
		damage.sAnimation = (blastFlag and ((p1==p2 and "ExploAir2") or (p1~=p2 and "ExploArt2"))) or "shieldbotpulse"
		if p1 == p2 then ret:AddDamage(damage) 
		else 	
			ret:AddArtillery(damage, "effects/shot_pull_U.png", NO_DELAY)
			ret:AddDelay(0.8)
		end
	
		local multiPawn = -1
	
		if blastFlag then
			if self.Damage == 2 then
				ret:AddSound("/impact/generic/explosion_large")
			else
				ret:AddSound("/impact/generic/explosion")
			end
			if Board:IsPawnSpace(p2) and Board:GetPawn(p2):IsShield() then
				ret:AddScript("Board:GetPawn("..p2:GetString().."):SetShield(false,false)")
				if _G[Board:GetPawn(p2):GetType()].ExtraSpaces[1] == Point(0,1) then--this is a train or train-like pawn
					multiPawn = 0
				elseif _G[Board:GetPawn(p2):GetType()].ExtraSpaces[1] == Point(1,0) then--this is a dam or dam-like pawn
					multiPawn = 1
				end
			end
			if Board:IsShield(p2) then
				ret:AddScript("Board:SetShield("..p2:GetString()..",false,false)")
			end
		else
			ret:AddSound("/weapons/science_repulse")
		end
	
		if multiPawn == -1 or not blastFlag then
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
		else
			local otherPawnSpace = Point(-1,-1)
			for i = DIR_START, DIR_END do
				damage = SpaceDamage(p2 + DIR_VECTORS[i], 0, i)
				damage.sAnimation = "airpush_"..i
				if blastFlag then damage.sAnimation = "explopush"..self.Damage.."_"..i damage.iDamage = self.Damage end
				if Board:IsBuilding(p2 + DIR_VECTORS[i]) or (Board:IsPawnSpace(p2 + DIR_VECTORS[i]) and Board:GetPawn(p2 + DIR_VECTORS[i]):GetTeam() == TEAM_PLAYER) then
					damage.iDamage = 0
					damage.sAnimation = "airpush_"..i
					if self.ShieldFriendly then damage.iShield = 1 end
				end
				if not Board:IsPawnSpace(p2 + DIR_VECTORS[i]) or #_G[Board:GetPawn(p2 + DIR_VECTORS[i]):GetType()].ExtraSpaces<1 then
					ret:AddDamage(damage)
				elseif #_G[Board:GetPawn(p2 + DIR_VECTORS[i]):GetType()].ExtraSpaces>0 then
					damage.iPush = DIR_NONE
					damage.sAnimation = ""
					damage.sImageMark = "combat/icons/Nico_shield_explode_glow.png"
					otherPawnSpace = p2 + DIR_VECTORS[i]
					ret:AddDamage(damage)
				end
			end
			for i = DIR_START, DIR_END do
				damage = SpaceDamage(otherPawnSpace + DIR_VECTORS[i], 0, i)
				damage.sAnimation = "airpush_"..i
				if blastFlag then damage.sAnimation = "explopush"..self.Damage.."_"..i damage.iDamage = self.Damage end
				if Board:IsBuilding(otherPawnSpace + DIR_VECTORS[i]) or (Board:IsPawnSpace(otherPawnSpace + DIR_VECTORS[i]) and Board:GetPawn(otherPawnSpace + DIR_VECTORS[i]):GetTeam() == TEAM_PLAYER) then
					damage.iDamage = 0
					damage.sAnimation = "airpush_"..i
					if self.ShieldFriendly then damage.iShield = 1 end
				end
				if not Board:IsPawnSpace(otherPawnSpace + DIR_VECTORS[i]) or #_G[Board:GetPawn(otherPawnSpace + DIR_VECTORS[i]):GetType()].ExtraSpaces<1 then
					ret:AddDamage(damage)
				end
			end
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

	ANIMS.shieldbotpulse = Animation:new{
		Image = "effects/shield_bot_pulse.png",
		NumFrames = 8,
		Time = 0.05,
	
		PosX = -33,
		PosY = -14,
	}

------Frozen Hulks------

--Lemon's Real Mission Checker
local function isRealMission()
local mission = GetCurrentMission()

return true
	and mission ~= nil
	and mission ~= Mission_Test
	and Board
	and Board:IsMissionBoard()
end
Nico_Hulk_T = {
	id = "Nico_Hulk_T",
	title = "Challenge Completed",
	name = "Frozen Hulk.",
	tooltip = "New Palette Unlocked for Cryo Hulk, this one looks familiar...",
	image = "img/achievements/toasts/Nico_Bot_Hulk.png",
}
Nico_hulkbot=ArtilleryDefault:new{
	Name="Artillery Mark III",
	Class = "TechnoVek",
	Icon = "weapons/Nico_hulkbot.png",
	Description="Launch a Cluster Artillery shot in one direction, and then a Vulcan Artillery shot in a different direction. Freeze Self.",-- Every time this weapon is selected, swap the order of the shots.",
	Damage = 1,
	SelfDamage = 1,
	PowerCost = 0,
	BuildingDamage = false,
	shield=false,
	TwoClick = true,
	Cancel = false,
	Upgrades = 2,
	UpgradeList = { "Cancel",  "+1 Damage"  },
	UpgradeCost = {1,3},
	LaunchSound = "",
	ImpactSound = "",
	TipImage = {
		Unit = Point(1,3),
		Building1 = Point(1,2),
		Building2 = Point(2,3),
		Target = Point(1,1),
		Enemy1 = Point(3,3),
		Enemy2 = Point(2,1),
		Enemy3 = Point(3,2),
		Queued1 = Point(2,3),
		Second_Click = Point(3,3),
        CustomPawn="Nico_hulkbot_mech",
	},
}
	function Nico_hulkbot:GetSecondTargetArea(p1, p2)  --This is a copy of the GetTargetArea for LineArtillery
		local ret = PointList()
		local dir = GetDirection(p2 - p1)
		for j = 1, 3 do
			for i = 2, 8 do
				local curr = Point(p1 + DIR_VECTORS[(dir+j)%4] * i)
				if not Board:IsValid(Point(p1 + DIR_VECTORS[(dir+j)%4] * i)) then  
					break
				end
				ret:push_back(curr)
			end
		end
		return ret
	end
	function Nico_hulkbot:GetSkillEffect(p1,p2)
		local ret = SkillEffect()
		ret:AddDamage(SpaceDamage(p1,1))
		local temp = Ranged_Defensestrike_A:GetSkillEffect(p1,p2)
		if self.Damage == 2 then temp = Ranged_Defensestrike_AB:GetSkillEffect(p1,p2) end
		
		ret:AddSound("/weapons/defense_strike")
		for i = 1, temp.effect:size() do
			ret:AddDamage(temp.effect:index(i))
		end
		ret:AddSound("/impact/generic/explosion")
		
		ret:AddDelay(FULL_DELAY)
		return ret
	end
	function Nico_hulkbot:GetFinalEffect(p1,p2,p3)
		local ret = self:GetSkillEffect(p1,p2)
		local ice = SpaceDamage(p1,0)
		ice.iFrozen = 1
		ret:AddDamage(ice)
		ret:AddSound("/weapons/fireball")
		ret:AddBounce(p1, 1)
		
		local damage = SpaceDamage(p3,0)
		damage.sAnimation = "ExploArt2"
		damage.iFire = 1
		ret:AddArtillery(damage, "effects/shotup_ignite_fireball.png")
		
		for dir = DIR_START, DIR_END do
			damage = SpaceDamage(p3 + DIR_VECTORS[dir], 0)
			damage.iPush = dir
			damage.sAnimation = "airpush_"..dir
			ret:AddDamage(damage)
		end
		ret:AddBounce(p3, self.BounceAmount)
		if self.Cancel then
			local iconfire = SpaceDamage(p3,0)
			if Board:IsPawnSpace(p3) and Board:GetPawn(p3):GetTeam() == TEAM_ENEMY then
				iconfire.sImageMark = "combat/icons/Nico_fire_cancel.png"
				ret:AddScript("Board:GetPawn("..p3:GetString().."):ClearQueued()")
				if Board:GetPawn(p3):IsQueued() and Board:IsPawnTeam(p3, TEAM_ENEMY) then
					ret:AddScript("Board:AddAlert("..p3:GetString()..",\"ATTACK CANCELED\")")
				end
				local web_id = Board:GetPawn(p3):GetId()--Store pawn id
				if Board:GetPawn(p3):GetType() ~= "tosx_IceHornet" then ret:AddScript("Board:GetPawn("..web_id.."):SetSpace(Point(-1,-1))") end--Move the pawn to Point(-1,-1) to delete webbing
				local damage = SpaceDamage(p1,0)
				damage.bHide = true
				damage.fDelay = 0.00017--force a one frame delay on the board
				ret:AddDamage(damage)
				ret:AddScript("Board:GetPawn("..web_id.."):SetSpace("..p3:GetString()..")")--Move the pawn back
			else
				iconfire.sImageMark = "combat/icons/Nico_fire_cancel_off.png"
				damage = SpaceDamage(p3,0)
				damage.bHide=true
				damage.iFire = 1
				ret:AddDamage(damage)
			end
			ret:AddDamage(iconfire)
			if Board:IsTipImage() then
				ret:AddScript("Board:AddAlert("..p3:GetString()..",\"ATTACK CANCELED\")")
				ret:AddScript("Board:GetPawn("..p3:GetString().."):ClearQueued()")
			end
		end
		ret:AddSound("/props/fire_damage")
		if isRealMission() and GAME.additionalSquadData.squad == "Nico_Sent_weap3" and not modApi.achievements:isComplete("Nico_Sent_weap","Nico_Bot_Hulk") then
			if GetCurrentMission().Nico_HulkUses == 3 then
				ret:AddScript("Nico_Sent_weap3squad_Chievo('Nico_Bot_Hulk')")
				ret:AddScript("Nico_Sent_weapToasto(Nico_Hulk_T)")
				ret:AddScript("Nico_AchTrigger3()")
				ret:AddScript("Nico_AchTrigger5()")
			else
				ret:AddScript('GetCurrentMission().Nico_HulkUses = GetCurrentMission().Nico_HulkUses + 1')
			end
		end
		return ret
	end
	Nico_hulkbot_A=Nico_hulkbot:new{
		UpgradeDescription = "The Vulcan Artillery shot cancels the target enemy on impact.",
		Cancel = true,
	}
	Nico_hulkbot_B=Nico_hulkbot:new{
		Damage=2,
		UpgradeDescription = "Increases damage of the Cluster Artillery shot by 1.",
	}
	Nico_hulkbot_AB=Nico_hulkbot_A:new{
		Damage=2,
	}
	
	--local function EVENT_onModsLoaded() --This function will run when the mod is loaded
	--hulkbot_counter = false
	--end

	--modApi.events.onModsLoaded:subscribe(EVENT_onModsLoaded)

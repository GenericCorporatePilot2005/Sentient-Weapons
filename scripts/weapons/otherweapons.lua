local path = mod_loader.mods[modApi.currentMod].resourcePath
local BoardEvents = require(modApi:getCurrentMod().scriptPath .."libs/boardEvents")

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

local function Nico_BotLeaderA(mission, pawn, weaponId, p1, p2, skillEffect)
	if pawn and weaponId ~= "Move" and _G[pawn:GetType()].NicoIsBotLeader and (pawn:IsDamaged() or weaponId == "Skill_Repair") then
		skillEffect.effect = DamageList()
		local damage = SpaceDamage(p1,-10)
		damage.iFire = EFFECT_REMOVE
		damage.iAcid = EFFECT_REMOVE
		skillEffect:AddDamage(damage)
		skillEffect:AddScript("Board:AddShield("..p1:GetString()..")")
	end
end

local function Nico_BotLeaderB(mission, pawn, weaponId, p1, p2, p3, skillEffect)
	if pawn and weaponId ~= "Move" and _G[pawn:GetType()].NicoIsBotLeader and pawn:IsDamaged() then
		skillEffect.effect = DamageList()
		local damage = SpaceDamage(p1,-10)
		damage.iFire = EFFECT_REMOVE
		damage.iAcid = EFFECT_REMOVE
		skillEffect:AddDamage(damage)
		skillEffect:AddScript("Board:AddShield("..p1:GetString()..")")
	end
end

local function EVENT_onModsLoaded()
	modapiext:addTargetAreaBuildHook(Nico_TeamRepair)
	modapiext:addSkillBuildHook(Nico_FatalFreeze)
	modapiext:addSkillStartHook(Nico_MoveShield)
	modapiext:addFinalEffectBuildHook(Nico_MoveShieldWeapon)
	modapiext:addPawnUndoMoveHook(Nico_UnMine)
	modapiext:addSkillBuildHook(Nico_BotLeaderA)
	modapiext:addFinalEffectBuildHook(Nico_BotLeaderB)
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

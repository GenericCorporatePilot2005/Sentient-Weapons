local function Nico_MoveShield(mission, pawn, weaponId, p1, p2)
	i = pawn:GetId()
	local IsRealMission = true and (mission ~= nil) and (mission ~= Mission_Test) and Board	and Board:IsMissionBoard()
	local adjacent_mech = IsRealMission and ((Board:GetPawn((i+1)%3):GetSpace():Manhattan(p2)==1) or (Board:GetPawn((i+2)%3):GetSpace():Manhattan(p2)==1))
	if pawn and _G[pawn:GetType()].NicoIsRobot and weaponId == "Move" and adjacent_mech then
		Game:TriggerSound("/props/shield_activated")
		pawn:SetShield(true)
	end
end

local function Nico_MoveShieldWeapon(mission, pawn, weaponId, p1, p2, p3, skillEffect)
	if weaponId == "Nico_minibot" or weaponId == "Nico_minibot2" then return end
	for i = 1, skillEffect.effect:size() do
		local spaceDamage = skillEffect.effect:index(i)
		if spaceDamage:IsMovement() and spaceDamage:GetMoveType() == 0 then
			local movePawn = Board:GetPawn(spaceDamage:MoveStart())
			local j = movePawn:GetId()
			local IsRealMission = true and (mission ~= nil) and (mission ~= Mission_Test) and Board	and Board:IsMissionBoard()
			local endpoint = spaceDamage:MoveEnd()--spaceDamage:MoveStart()
			local adjacent_mech = IsRealMission and ((Board:GetPawn((j+1)%3):GetSpace():Manhattan(endpoint)==1) or (Board:GetPawn((j+2)%3):GetSpace():Manhattan(endpoint)==1))
			if movePawn and _G[movePawn:GetType()].NicoIsRobot and adjacent_mech then
				local dam = SpaceDamage(spaceDamage:MoveStart(),0)
				dam.iShield = 1
				skillEffect:AddDamage(dam)
				skillEffect:AddScript("Game:TriggerSound(\"/props/shield_activated\")")
				skillEffect:AddScript("Board:GetPawn("..j.."):SetShield(true)")
			end
		end
	end
end

local function Nico_TeamRepair(mission, pawn, weaponId, p1, targetArea)
	if pawn and _G[pawn:GetType()].NicoIsRobot and weaponId == "Skill_Repair" then
		for dir = DIR_START, DIR_END do
			local curr = p1 + DIR_VECTORS[dir]
			if Board:IsPawnSpace(curr) and (_G[Board:GetPawn(curr):GetType()].NicoIsRobot or _G[Board:GetPawn(curr):GetType()].NicoIsBotLeader) then
				targetArea:push_back(curr)
			end
		end
	end
end

local function Nico_BoomTest(mission)
	if mission == Mission_Test then
		local pawnList = extract_table(Board:GetPawns(TEAM_PLAYER))
		for i = 1, #pawnList do
			if _G[Board:GetPawn(pawnList[i]):GetType()].NicoIsBoom and not Board:GetPawn(pawnList[i]):IsShield() then
				Board:GetPawn(pawnList[i]):SetShield(true)
			end
		end
	end
end

local function Nico_BoomRepair(mission, pawn)
	if _G[pawn:GetType()].NicoIsBoom then
		for i = 0,3 do
			local curr = pawn:GetSpace()+DIR_VECTORS[i]
			if Board:IsBuilding(curr) or (Board:IsPawnSpace(curr) and Board:GetPawn(curr):GetTeam() == TEAM_PLAYER) then Board:AddShield(curr) end
		end
		modApi:conditionalHook(
			function()
				return (Board and not Board:IsBusy())
			end,
			function()
				if Board then
					pawn:ModifyHealth(1,true,0)
				end
			end
		)
	end
end

local function EVENT_onModsLoaded()
	modapiext:addSkillStartHook(Nico_MoveShield)
	modapiext:addFinalEffectBuildHook(Nico_MoveShieldWeapon)
	modapiext:addTargetAreaBuildHook(Nico_TeamRepair)
	modApi:addMissionUpdateHook(Nico_BoomTest)
	modapiext:addPawnKilledHook(Nico_BoomRepair)
end

modApi.events.onModsLoaded:subscribe(EVENT_onModsLoaded)

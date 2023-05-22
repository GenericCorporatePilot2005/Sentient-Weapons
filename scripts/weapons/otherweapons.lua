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

local function Nico_BotLeaderA(mission, pawn, weaponId, p1, p2, skillEffect)
	local IsRealMission = true and (mission ~= nil) and (mission ~= Mission_Test) and Board	and Board:IsMissionBoard()
	if pawn and weaponId ~= "Move" and _G[pawn:GetType()].NicoIsBotLeader and (pawn:IsDamaged() or weaponId == "Skill_Repair") then
		skillEffect.effect = DamageList()
		local damage = SpaceDamage(p1,-10)
		damage.iFire = EFFECT_REMOVE
		damage.iAcid = EFFECT_REMOVE
		damage.iShield = 1
		if IsPassiveSkill("Mass_Repair") and IsRealMission then
			for i = 0,2 do
				damage.loc = Board:GetPawn(i):GetSpace()
				skillEffect:AddDamage(damage)
			end
		else
			skillEffect:AddDamage(damage)
		end
		skillEffect:AddScript("Board:AddShield("..p1:GetString()..")")
	end
end

local function Nico_BotLeaderB(mission, pawn, weaponId, p1, p2, p3, skillEffect)
	local IsRealMission = true and (mission ~= nil) and (mission ~= Mission_Test) and Board	and Board:IsMissionBoard()
	if pawn and weaponId ~= "Move" and _G[pawn:GetType()].NicoIsBotLeader and pawn:IsDamaged() then
		skillEffect.effect = DamageList()
		local damage = SpaceDamage(p1,-10)
		damage.iFire = EFFECT_REMOVE
		damage.iAcid = EFFECT_REMOVE
		damage.iShield = 1
		if IsPassiveSkill("Mass_Repair") and IsRealMission then
			for i = 0,2 do
				damage.loc = Board:GetPawn(i):GetSpace()
				skillEffect:AddDamage(damage)
			end
		else
			skillEffect:AddDamage(damage)
		end
		skillEffect:AddScript("Board:AddShield("..p1:GetString()..")")
	end
end

local function EVENT_onModsLoaded()
	modapiext:addSkillStartHook(Nico_MoveShield)
	modapiext:addFinalEffectBuildHook(Nico_MoveShieldWeapon)
	modapiext:addTargetAreaBuildHook(Nico_TeamRepair)
end

modApi.events.onModsLoaded:subscribe(EVENT_onModsLoaded)

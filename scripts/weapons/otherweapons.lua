
local mod = modApi:getCurrentMod()
local path = mod_loader.mods[modApi.currentMod].scriptPath
local customAnim = require(path.."libs/customAnim")
local weaponArmed = require(path.."libs/weaponArmed")

local function animRemove(point)
	if customAnim:get(point, "Nico_ShieldPreview")
	or customAnim:get(point, "Nico_BoostPreview")
	or customAnim:get(point, "Nico_MinePreview") then
		customAnim:rem(point, "Nico_ShieldPreview")
		customAnim:rem(point, "Nico_BoostPreview")
		customAnim:rem(point, "Nico_MinePreview")
	end
end

local function Nico_MoveShield(mission, pawn, weaponId, p1, p2)
	i = pawn:GetId()
	local IsRealMission = true and (mission ~= nil) and (mission ~= Mission_Test) and Board	and Board:IsMissionBoard()
	local adjacent_mech = IsRealMission and ((Board:GetPawn((i+1)%3):GetSpace():Manhattan(p2)==1) or (Board:GetPawn((i+2)%3):GetSpace():Manhattan(p2)==1))
	if pawn and _G[pawn:GetType()].NicoIsRobot and weaponId == "Move" and adjacent_mech then
		Game:TriggerSound("/props/shield_activated")
		if pawn:IsShield() then pawn:SetBoosted(true)
		else pawn:SetShield(true) end
		if customAnim:get(pawn:GetSpace(), "Nico_MinePreview") then
			customAnim:rem(pawn:GetSpace(), "Nico_MinePreview") end
	end
end
ANIMS.Nico_ShieldPreview = Animation:new{
	Image = "combat/icons/icon_shield_glow.png",
	PosX = -13, PosY = 12,
	Time = 0.15,
	Loop = true,
	NumFrames = 1
}
ANIMS.Nico_BoostPreview = Animation:new{
	Image = "combat/icons/icon_boosted_glow.png",
	PosX = -13, PosY = 12,
	Time = 0.15,
	Loop = true,
	NumFrames = 1
}
ANIMS.Nico_MinePreview = Animation:new{
	Image = "combat/icons/icon_frozenmine_glow.png",
	PosX = -13, PosY = 13,
	Time = 0.15,
	Loop = true,
	NumFrames = 1
}
local function Nico_MoveShieldWeap(mission, pawn, weaponId, p1, p2, skillEffect)
	if weaponId == "Nico_minibot" or
	(weaponId == "Nico_minibot2" and
	pawn and not pawn:IsMovementSpent()) then return end
	local libPath = string.format("require(mod_loader.mods[%q].scriptPath .. %q)", mod.id, "libs/customAnim")
	for i = 1, skillEffect.effect:size() do
		local spaceDamage = skillEffect.effect:index(i)
		if spaceDamage:IsMovement() and spaceDamage:GetMoveType() ~= 3 then
			local start = spaceDamage:MoveStart()
			local movePawn = Board:GetPawn(start) or pawn
			local j = movePawn:GetId()
			animRemove(start)
			customAnim:rem(spaceDamage:MoveEnd(), "Nico_MinePreview")
			local IsRealMission = true and (mission ~= nil) and (mission ~= Mission_Test)
			and Board and Board:IsMissionBoard()
			local endpoint = spaceDamage:MoveEnd()
			local adjacent_mech = IsRealMission and 
			((Board:GetPawn((j+1)%3):GetSpace():Manhattan(endpoint)==1)
			or (Board:GetPawn((j+2)%3):GetSpace():Manhattan(endpoint)==1))
			local spot = (not Board:IsBuilding(start) and Board:GetTerrain(start) ~= TERRAIN_MOUNTAIN)
			and start or p1
			if movePawn and _G[movePawn:GetType()].NicoIsRobot and adjacent_mech then
				if not movePawn:IsShield() then
					customAnim:add(spot, "Nico_ShieldPreview")
					skillEffect:AddScript(string.format("%s:rem(%s, %q)",libPath, spot:GetString(), "Nico_ShieldPreview"))
				else
					customAnim:add(spot, "Nico_BoostPreview")
					skillEffect:AddScript(string.format("%s:rem(%s, %q)",libPath, spot:GetString(), "Nico_BoostPreview"))
				end
				if weaponId ~= "Move" then
					skillEffect:AddScript("Game:TriggerSound(\"/props/shield_activated\")")
					skillEffect:AddScript("Board:GetPawn("..j.."):SetShield(true)")
					if movePawn:IsShield() then
						skillEffect:AddScript("Board:GetPawn("..j.."):SetBoosted(true)")
					end
				end
			elseif movePawn and _G[movePawn:GetType()].NicoIsRobot and not adjacent_mech then
				local pType = movePawn:GetType()
				if pType == "Nico_minerbot_mech" or pType == "Nico_minibot2" or pType == "Nico_minibot2A" then
					customAnim:add(start, "Nico_MinePreview")
					skillEffect:AddScript(string.format("%s:rem(%s, %q)", libPath, start:GetString(), "Nico_MinePreview"))
				end
			elseif not adjacent_mech then
				animRemove(spot)
			end
		end
	end
end

local function Nico_MoveShieldWeapon(mission, pawn, weaponId, p1, p2, p3, skillEffect)
	Nico_MoveShieldWeap(mission, pawn, weaponId, p1, p2, skillEffect)
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

local function PawnKilled(mission, pawn)
	if pawn:GetType() == "Nico_Snowmine" or pawn:GetType() == "Nico_Snowmine2"
	or pawn:GetType() == "Nico_SnowmineA" or pawn:GetType() == "Nico_Snowmine2A"
	or pawn:GetType() == "Nico_laserbloom" or pawn:GetType() == "Nico_cannonbloom" or pawn:GetType() == "Nico_artillerybloom"
	or pawn:GetType() == "Nico_cannonbot_deploy" then
		Board:AddAnimation(pawn:GetSpace(),"ExploAir2",ANIM_DELAY)
	end
end
local onTileUnhighlighted = function(mission, point)
	if not (mission and point) then return end
    local pawn = Game:GetPawn(pawnId)
    if pawn then
		local board_size = Board:GetSize()
		for i = 0, board_size.x - 1 do
			for j = 0, board_size.y - 1 do
				local curr = Point(i, j)
			end
		end
    end

end
local function EVENT_onModsLoaded()
	modapiext:addSkillStartHook(Nico_MoveShield)
	modapiext:addSkillBuildHook(Nico_MoveShieldWeap)
	modapiext:addFinalEffectBuildHook(Nico_MoveShieldWeapon)
	modapiext:addTargetAreaBuildHook(Nico_TeamRepair)
	modapiext:addPawnKilledHook(PawnKilled)
    weaponArmed.events.onWeaponUnarmed:subscribe(function(skill, pawnId)
		if not (Board and Game) then return end
        local pawn = Game:GetPawn(pawnId)
        if pawn then
			local board_size = Board:GetSize()
			for i = 0, board_size.x - 1 do
				for j = 0, board_size.y - 1 do
					local curr = Point(i, j)
					animRemove(curr)
				end
			end
        end
    end)
end

modApi.events.onModsLoaded:subscribe(EVENT_onModsLoaded)

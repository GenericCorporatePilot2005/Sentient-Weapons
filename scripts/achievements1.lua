local this={}

local path = mod_loader.mods[modApi.currentMod].resourcePath
local modid = "Nico_Sent_weap" -- also Squad id

function Nico_Techno_Veks2squad_Chievo(id)
    	-- exit if not our squad
	if Board:GetSize() == Point(6,6) then return end -- TipImage
	if GAME.additionalSquadData.squad ~= modid then return end
	if IsTestMechScenario() then return end
	-- exit if current one is unlocked
	modApi.achievements:trigger(modid,id)
end
local imgs = {
	"Laser",
	"Cannon",
	"Arti",
}

local achname = "Nico_Bot_"
for _, img in ipairs(imgs) do
	modApi:appendAsset("img/achievements/".. achname..img ..".png", path .."img/achievements/".. img ..".png")
end

modApi.achievements:add{
	id = "Nico_Bot_Laser",
	name = "Septacular Snowstorm",
	tip = "End a mission with at least 7 enemies frozen.",
	image = "img/achievements/Nico_Bot_Laser.png",
	squad = "Nico_Sent_weap",
	objective=1,
}

modApi.achievements:add{
	id = "Nico_Bot_Cannon",
	name = "One Hit Wonder",
	tip = "Kill an enemy with at least 5 HP using the Cannon 8R Mark II, without inflicting bump damage, and without pushing it.",
	image = "img/achievements/Nico_Bot_Cannon.png",
	squad = "Nico_Sent_weap",
	objective=1,
}

modApi.achievements:add{
	id = "Nico_Bot_Arti",
	name = "Bubble Blaster",
	tip = "End a mission with all Mechs and Buildings Shielded.",
	image = "img/achievements/Nico_Bot_Arti.png",
	squad = "Nico_Sent_weap",
	objective = 1,
}

--[[modApi.achievements:add{
	id = "Nico_Techno_Shield",
	global = "Secret Rewards",
	secret=true,
	name = "The Call of The Psion",
	tip = "New Mech Unlocked on Random and Custom Squads",
	image = "img/achievements/Nico_Techno_Shield.png",
	squad = "Nico_Techno_Veks 2",
}]]

--Lemon's Real Mission Checker
local function isRealMission()
local mission = GetCurrentMission()

return true
	and mission ~= nil
	and mission ~= Mission_Test
	and Board
	and Board:IsMissionBoard()
end

--Laser and Artillery achievement

local function Nico_MissionEnd(mission)
	local pawnList = extract_table(Board:GetPawns(TEAM_ENEMY))
	local count = 0
	for i = 1, #pawnList do
		local currPawn = Board:GetPawn(pawnList[i])
		if currPawn:GetTeam() == TEAM_ENEMY and currPawn:IsFrozen() and not _G[currPawn:GetType()].Minor then
			count = count + 1
		end
	end
	if count > 6 then modApi.achievements:trigger(modid,"Nico_Bot_Laser") end
	local bubble = true
	for j = 0,2 do
		if not Board:GetPawn(j):IsShield() then
			bubble = false
			break
		end
	end
	for k,v in ipairs(Board) do
		if Board:IsBuilding(v) and not Board:IsShield(v) then
			bubble = false
			break
		end
	end
	if bubble then modApi.achievements:trigger(modid,"Nico_Bot_Arti") end
end

--Cannon's Achievement

	--This function has a global variable created in it for detecting the weapon shot
local function preKillCheck(mission, pawn, weaponId, p1, p2)
	if (weaponId == "Nico_cannonbot") or (weaponId == "Nico_cannonbot_A") or (weaponId == "Nico_cannonbot_B") or (weaponId == "Nico_cannonbot_AB") then
		local direction = GetDirection(p2 - p1)
		local target = GetProjectileEnd(p1,p1+DIR_VECTORS[direction])
		if p1:Manhattan(target) < p1:Manhattan(p2) then target = p2 end
		
		if Board:IsPawnSpace(target) then nico_cannon_enemy = Board:GetPawn(target):GetId() end
		
		if Board:IsPawnSpace(target) and Board:GetPawn(target):GetHealth()>4 and Board:IsPawnTeam(target,TEAM_ENEMY) then
			if p1:Manhattan(GetProjectileEnd(p1,p1+DIR_VECTORS[direction])) < p1:Manhattan(p2) then--arti shot doesn't push
				nico_cannon_flag = true
			elseif Board:GetPawn(target):IsGuarding() then--cannon shot must strike stable
				nico_cannon_flag = true
			else
				nico_cannon_flag = false
			end
		else
			nico_cannon_flag = false
		end
	end
	return
end

local function postKillCheck(mission, pawn)
	local ret = SkillEffect()
	if isRealMission() and nico_cannon_flag and pawn:GetId() == nico_cannon_enemy and GAME.additionalSquadData.squad == modid and not modApi.achievements:isComplete(modid,"Nico_Bot_Cannon") then
		modApi.achievements:trigger(modid,"Nico_Bot_Cannon")
	end
end

	local function EVENT_onModsLoaded() --This function will run when the mod is loaded
	--modapiext is requested in the init.lua
	modApi:addMissionEndHook(Nico_MissionEnd)
	--This line tells us that we want to run the above function every time a mission is over
	nico_cannon_flag = false
	nico_cannon_enemy = -1
	modapiext:addSkillStartHook(preKillCheck)
	--This line tells us that we want to run the above function every time a skill has just begun executing (including skill previews)
	modapiext:addPawnKilledHook(postKillCheck)
	--This line tells us that we want to run the above function every time a pawn dies
	--modApi:addSaveGameHook(function(mission) nico_cannon_flag = false end)
	end

	modApi.events.onModsLoaded:subscribe(EVENT_onModsLoaded)

return this

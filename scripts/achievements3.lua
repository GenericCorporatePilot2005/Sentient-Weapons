local this={}

local path = mod_loader.mods[modApi.currentMod].resourcePath
local modid = "Nico_Sent_weap" -- concatenate 3 for Squad id

function Nico_Sent_weap3squad_Chievo(id)
    -- exit if not our squad
	if Board:GetSize() == Point(6,6) then return end -- TipImage
	if GAME.additionalSquadData.squad ~= modid.."3" then return end
	if IsTestMechScenario() then return end
	-- exit if current one is unlocked
	modApi.achievements:trigger(modid,id)
end
local imgs = {
	"Jugger",
	"Leader",
	"Hulk",
}

local achname = "Nico_Bot_"
for _, img in ipairs(imgs) do
	modApi:appendAsset("img/achievements/".. achname..img ..".png", path .."img/achievements/".. img ..".png")
end

modApi.achievements:add{
	id = "Nico_Bot_Jugger",
	name = "Decimation",
	tip = "Kill 10 enemies in one mission on the first Corporate Island.",
	image = "img/achievements/Nico_Bot_Jugger.png",
	squad = "Nico_Sent_weap3",
	objective=10,
}

modApi.achievements:add{
	id = "Nico_Bot_Leader",
	name = "Bulletproof",
	tip = "Finish a Corporate Island without the Bot Leader taking Mech Damage.",
	image = "img/achievements/Nico_Bot_Leader.png",
	squad = "Nico_Sent_weap3",
	objective=1,
}

modApi.achievements:add{
	id = "Nico_Bot_Hulk",
	name = "Hulking Out",
	tip = "Shoot the Artillery Mark III 4 times in a single mission.",
	image = "img/achievements/Nico_Bot_Hulk.png",
	squad = "Nico_Sent_weap3",
	objective = 4,
}

--Lemon's Real Mission Checker
local function isRealMission()
local mission = GetCurrentMission()

return true
	and mission ~= nil
	and mission ~= Mission_Test
	and Board
	and Board:IsMissionBoard()
end

--Hooks

local function Nico_MissionStart(mission)
	mission.Nico_LeaderHurt = false
end

local function Nico_MissionEnd(mission)
	if not modApi.achievements:isComplete(modid, "Nico_Bot_Jugger") then
		modApi.achievements:reset(modid, "Nico_Bot_Jugger")--reset at end of mission if failed
	end
	if not modApi.achievements:isComplete(modid, "Nico_Bot_Leader") and mission.Nico_LeaderHurt then
		modApi.achievements:reset(modid, "Nico_Bot_Leader")--reset and invalidate at end of mission if failed
		modApi.achievements:addProgress(modid,"Nico_Bot_Leader",-1)
	end
	if not modApi.achievements:isComplete(modid, "Nico_Bot_Hulk") then
		modApi.achievements:reset(modid, "Nico_Bot_Hulk")--reset at end of mission if failed
	end
end

local function Nico_PawnDamage(mission, pawn, damageTaken)
	if pawn:GetType() == "Nico_botleader_mech" then
		mission.Nico_LeaderHurt = true--track damage of Bot Leader
	end
end

local function Nico_JuggerKill(mission, pawn)
	if not modApi.achievements:isComplete(modid, "Nico_Bot_Jugger") and modApi.achievements:getProgress(modid,"Nico_Bot_Jugger")>-1 and pawn:GetTeam() == TEAM_ENEMY and not _G[pawn:GetType()].Minor then
		modApi.achievements:addProgress(modid,"Nico_Bot_Jugger",1)--track all kills
	end
end

local function Nico_onIslandLeft(island)
	if not modApi.achievements:isComplete(modid, "Nico_Bot_Jugger") then
		modApi.achievements:reset(modid, "Nico_Bot_Jugger")--reset progress and then
		modApi.achievements:addProgress(modid,"Nico_Bot_Jugger",-1)--decrement to indicate failed
	end
	if not modApi.achievements:isComplete(modid, "Nico_Bot_Leader") then
		if modApi.achievements:getProgress(modid,"Nico_Bot_Leader")>-1 then
			modApi.achievements:trigger(modid,"Nico_Bot_Leader")
		else
			modApi.achievements:reset(modid, "Nico_Bot_Leader")
		end
	end
end

local function Nico_GameStart()
	if not modApi.achievements:isComplete(modid,"Nico_Bot_Jugger") then
		modApi.achievements:reset(modid, "Nico_Bot_Jugger")--manually reset the achievement
		if GAME.additionalSquadData.squad ~= modid then
			modApi.achievements:addProgress(modid,"Nico_Bot_Jugger",-1)--invalidate if not the right squad
		end
	end
end



local function EVENT_onModsLoaded() --This function will run when the mod is loaded
	--modapiext is requested in the init.lua
	modApi:addMissionStartHook(Nico_MissionStart)
	--This line tells us that we want to run the above function every time a mission is entered
	modapiext:addPawnDamagedHook(Nico_PawnDamage)
	--This line tells us that we want to run the above function every time a pawn is damaged
	modApi:addMissionEndHook(Nico_MissionEnd)
	--This line tells us that we want to run the above function every time a mission is over
	modapiext:addPawnKilledHook(Nico_JuggerKill)
	--This line tells us that we want to run the above function every time a pawn is killed
end

modApi.events.onModsLoaded:subscribe(EVENT_onModsLoaded)
modApi.events.onIslandLeft:subscribe(Nico_onIslandLeft)
modApi.events.onPostStartGame:subscribe(Nico_GameStart)

return this
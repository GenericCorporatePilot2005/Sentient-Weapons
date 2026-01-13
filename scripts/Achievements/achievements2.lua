local this={}

local path = mod_loader.mods[modApi.currentMod].resourcePath
local modid = "Nico_Sent_weap" -- concatenate 2 for Squad id

function Nico_Sent_weap2squad_Chievo(id)
    -- exit if not our squad
	if Board:GetSize() == Point(6,6) then return end -- TipImage
	if GAME.additionalSquadData.squad ~= modid.."2" then return end
	if IsTestMechScenario() then return end
	-- exit if current one is unlocked
	modApi.achievements:trigger(modid,id)
end
function Nico_AchTrigger2()
    -- exit if not our squad
	if Board:GetSize() == Point(6,6) then return end -- TipImage
	if GAME.additionalSquadData.squad ~= modid.."2" then return end
	if modApi.achievements:isComplete(modid, "Nico_Bot_Knight") and
	modApi.achievements:isComplete(modid, "Nico_Bot_Shield") and modApi.achievements:isComplete(modid, "Nico_Bot_Mine") then
		modApi.toasts:add({
			id = "SW2_T",
			title = "Challenge Completed",
			name = "Your palettes? No, Mine.",
			tooltip = "New Palette Unlocked for SW2, based on Mine-Bot's deployables.",
			image = "img/achievements/toasts/Nico_Bot_SW2.png",
		})
		return true
	end
end
local imgs = {
	"Knight",
	"Mine",
	"Shield",
}

local achname = "Nico_Bot_"
for _, img in ipairs(imgs) do
	modApi:appendAsset("img/achievements/".. achname..img ..".png", path .."img/achievements/".. img ..".png")
	modApi:appendAsset("img/achievements/toasts/".. achname..img ..".png", path .."img/achievements/toasts/".. img ..".png")
end

modApi.achievements:add{
	id = "Nico_Bot_Knight",
	name = "Mons Quixote",
	tip = "Shield at least 3 Mountains with a single dash of the 0th KPR Sword Mark II",
	image = "img/achievements/Nico_Bot_Knight.png",
	squad = "Nico_Sent_weap2",
	objective=1,
}
modApi.achievements:add{
	id = "Nico_Bot_Mine",
	name = "Me, Myself, And Mine",
	tip = "End a mission with 4 improved Mine-Bots.",
	image = "img/achievements/Nico_Bot_Mine.png",
	squad = "Nico_Sent_weap2",
	objective=1,
}
modApi.achievements:add{
	id = "Nico_Bot_Shield",
	name = "Treading Mine-Shields",
	tip = "End a mission with all Mechs and 4 Mine-Bots Shielded.",
	image = "img/achievements/Nico_Bot_Shield.png",
	squad = "Nico_Sent_weap2",
	objective = 1,
}
--Toasts
local Shield_T = {
	id = "Shield_T",
	title = "Challenge Completed",
	name = "Pinnacle's Contraption",
	tooltip = "New Palette Unlocked for Shield-Bot, this one won't rain missles on your own mechs!",
	image = "img/achievements/toasts/Nico_Bot_Shield.png",
}
local Mine_T = {
	id = "Mine_T",
	title = "Challenge Completed",
	name = "To Freeze Like a Mine...",
	tooltip = "...You Gotta Think like a Mine!\nNew Palette Unlocked for Mine-Bot.",
	image = "img/achievements/toasts/Nico_Bot_Mines.png",
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

--Mine and Shield achievement

local function Nico_MissionEnd(mission)
	local pawnList = extract_table(Board:GetPawns(TEAM_ANY))
	local count = 0
	for i = 1, #pawnList do
		local currPawn = Board:GetPawn(pawnList[i]):GetType()
		if currPawn == "Nico_Snowmine2" or currPawn == "Nico_Snowmine2A" then
			count = count + 1
		end
	end
	if count > 3 and GAME.additionalSquadData.squad == modid.."2" and not modApi.achievements:isComplete(modid,"Nico_Bot_Mine") then
		modApi.achievements:trigger(modid,"Nico_Bot_Mine")
		modApi.toasts:add(Mine_T)
		ret:AddScript("Nico_AchTrigger2()")
		ret:AddScript("Nico_AchTrigger5()")
	end
	local bubble = true
	for j = 0,2 do
		if not Board:GetPawn(j):IsShield() then
			bubble = false
			break
		end
	end
	local mine_shield = 0
	for k = 1, #pawnList do
		local currPawn = Board:GetPawn(pawnList[k])
		local m = nil
		local n = nil
		m, n = string.find(currPawn:GetType(), "Snowmine")
		if m~=nil and currPawn:IsShield() then
			mine_shield = mine_shield +1
		end
	end
	if bubble and mine_shield > 3 and GAME.additionalSquadData.squad == modid.."2" and not modApi.achievements:isComplete(modid,"Nico_Bot_Shield") then
		modApi.achievements:trigger(modid,"Nico_Bot_Shield") end
		modApi.toasts:add(Shield_T)
		ret:AddScript("Nico_AchTrigger2()")
		ret:AddScript("Nico_AchTrigger5()")
end

local function EVENT_onModsLoaded() --This function will run when the mod is loaded
	--modapiext is requested in the init.lua
	modApi:addMissionEndHook(Nico_MissionEnd)
	--This line tells us that we want to run the above function every time a mission is over
end

modApi.events.onModsLoaded:subscribe(EVENT_onModsLoaded)

return this

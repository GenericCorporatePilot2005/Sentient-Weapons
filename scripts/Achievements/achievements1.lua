local this={}
local path = mod_loader.mods[modApi.currentMod].resourcePath
local modid = "Nico_Sent_weap" -- also Squad id
Nico_weap_ach = {"Nico_Bot_Laser","Nico_Bot_Cannon","Nico_Bot_Arti"}

function Nico_Sent_weapsquad_Chievo(id)
    -- exit if not our squad
	if Board:GetSize() == Point(6,6) then return end -- TipImage
	if GAME.additionalSquadData.squad ~= modid then return end
	if IsTestMechScenario() then return end
	-- exit if current one is unlocked
	modApi.achievements:trigger(modid,id)
end
function Nico_AchTrigger1()
    -- exit if not our squad
	if Board:GetSize() == Point(6,6) then return end -- TipImage
	if GAME.additionalSquadData.squad ~= modid then return end
	local check = 0
	for i=1,3 do
		if modApi.achievements:isComplete(modid, Nico_weap_ach[i]) then
			check = check + 1
			if check == 3 then
				modApi.toasts:add({
					id = "SW1_T", title = "Challenge Completed",
					name = "Factory Reset", tooltip = "New Palette for the Sentient Weapons 1, based on the bot factories.",
					image = "img/achievements/toasts/Nico_Bot_SW1.png",})
					return true
			end
		end
	end
end
function Nico_AchTrigger5()
	if modApi.achievements:isComplete(modid, "Nico_Bot_Laser") and modApi.achievements:isComplete(modid, "Nico_Bot_Cannon")
	and modApi.achievements:isComplete(modid, "Nico_Bot_Arti") and modApi.achievements:isComplete(modid, "Nico_Bot_Knight")
	and modApi.achievements:isComplete(modid, "Nico_Bot_Shield") and modApi.achievements:isComplete(modid, "Nico_Bot_Mine")
	and modApi.achievements:isComplete(modid, "Nico_Bot_Jugger") and modApi.achievements:isComplete(modid, "Nico_Bot_Leader")
	and modApi.achievements:isComplete(modid, "Nico_Bot_Hulk") and modApi.achievements:isComplete(modid, "Nico_Bot_Laser_B")
	and modApi.achievements:isComplete(modid, "Nico_Bot_Cannon_B") and modApi.achievements:isComplete(modid, "Nico_Bot_Arti_B")
	then
		modApi.toasts:add({
			id = "SWMod_T", title = "Challenge Completed",
			name = "Pallette Swapped", tooltip = "New Palettes for the Sentient Weapon Squads, With their colors swapped around.\nThank you for playing this mod!",
			image = "img/achievements/toasts/Nico_Bot_SWMod.png",})
	end
end

function Nico_Sent_weapToasto(id)
	modApi.toasts:add(id)
end
local imgs = {
	"Laser",
	"Cannon",
	"Arti",
	"SW2",
	"SW3",
	"SW4",
}

local achname = "Nico_Bot_"
for _, img in ipairs(imgs) do
	modApi:appendAsset("img/achievements/".. achname..img ..".png", path .."img/achievements/".. img ..".png")
	modApi:appendAsset("img/achievements/toasts/".. achname..img ..".png", path .."img/achievements/toasts/".. img ..".png")
end
modApi:appendAsset("img/achievements/toasts/".. achname.."SW1.png", path .."img/achievements/toasts/SW1.png")
modApi:appendAsset("img/achievements/toasts/".. achname.."SWMod.png", path .."img/achievements/toasts/SWMod.png")
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
local function nicoNameChange(id,n,b)
    if modApi.achievements:get(modid,id) ~= nil and (modApi.achievements:isComplete(modid,id) or b) then
		local idSub = id:sub(-1)
		if idSub ~= "4" then
        	name = "The Sentient Weapons "..idSub.."!"
		else
			name = "The Boom Bots!"
		end
        tip = "New squad unlocked on the squad selection screen, NEEDS A RESTART TO APPLY"
	else
		name = "Locked."
        tip = "Try getting the other Achievements to see what this entails!"
    end
    ret = {name,tip}
    return ret[n]
end 
--Squad Achievements
Nico_Bot_SW2 = modApi.achievements:add{
    id = "Nico_Bot_SW2",
    global = "Secret Rewards",
    secret=true,
    name = "Locked.",
    tip = "Try Getting the other Achievements to see what this entails!",
    image = "img/achievements/Nico_Bot_SW2.png",
    squad = "Nico_Sent_weap",
}
Nico_Bot_SW3 = modApi.achievements:add{
	id = "Nico_Bot_SW3",
	global = "Secret Rewards",
	secret=true,
    name = "Locked.",
    tip = "Try Getting the other Achievements to see what this entails!",
	image = "img/achievements/Nico_Bot_SW3.png",
	squad = "Nico_Sent_weap",
}
Nico_Bot_SW4 = modApi.achievements:add{
	id = "Nico_Bot_SW4",
	global = "Secret Rewards",
	secret=true,
    name = "Locked.",
    tip = "Try Getting the other Achievements to see what this entails!",
	image = "img/achievements/Nico_Bot_SW4.png",
	squad = "Nico_Sent_weap",
}
local function nicoNameUpdate(b)
	for k = 2, 4 do
		local varName = "Nico_Bot_SW" .. k
		local achObj = _G[varName] -- This gets the variable Nico_Bot_SW2, etc.
		
		achObj.name = nicoNameChange(achObj.id, 1,b)
		achObj.tooltip = nicoNameChange(achObj.id, 2,b)
	end
end

--Toasts
local Laser_T = {
	id = "Laser_T",	title = "Challenge Completed",
	name = "Chilling Around",	tooltip = "New Palette and Mech Sprites Unlocked for Laser-Bot, for the winter season.",
	image = "img/achievements/toasts/Nico_Bot_Laser.png",}
local Cannon_T = {
	id = "Cannon_T", title = "Challenge Completed",
	name = "H4CK3D",tooltip = "New Palette Unlocked for Cannon-Bot, T0 SH0W WH0'S TH3 R34L H4CK3ERM4N!",
	image = "img/achievements/toasts/Nico_Bot_Cannon.png",}
local Arti_T = {
	id = "Arti_T",title = "Challenge Completed",
	name = "Self Promotion",tooltip = "New Palette and Mech Sprites Unlocked for Artillery-Bot, based on Nicolas 'Generic' from Pilot Potluck.",
	image = "img/achievements/toasts/Nico_Bot_Arti.png",}
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
	if count > 6 and GAME.additionalSquadData.squad == modid and not modApi.achievements:isComplete(modid,"Nico_Bot_Laser") then
		nicoNameUpdate(true)
		modApi.achievements:trigger(modid,"Nico_Bot_Laser") 
		modApi.toasts:add(Laser_T)
		modApi.achievements:trigger(modid,"Nico_Bot_SW2")
		Nico_AchTrigger1()
		Nico_AchTrigger5()
	end
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
	if bubble and GAME.additionalSquadData.squad == modid and not modApi.achievements:isComplete(modid,"Nico_Bot_Arti") then
		nicoNameUpdate(true)
		modApi.achievements:trigger(modid,"Nico_Bot_Arti")
		modApi.toasts:add(Arti_T)
		modApi.achievements:trigger(modid,"Nico_Bot_SW4")
		Nico_AchTrigger1()
		Nico_AchTrigger5()
	end
end

--Cannon's Achievement

--This function has a global variable created in it for detecting the weapon shot
local function preKillCheck(mission, pawn, weaponId, p1, p2)
	if (weaponId == "Nico_cannonbot") or (weaponId == "Nico_cannonbot_A") or (weaponId == "Nico_cannonbot_B") or (weaponId == "Nico_cannonbot_AB") then
		local direction = GetDirection(p2 - p1)
		local target = GetProjectileEnd(p1,p1+DIR_VECTORS[direction])
		if p1:Manhattan(target) < p1:Manhattan(p2) then target = p2 end
		
		if Board:IsPawnSpace(target) then--store the id of the target pawn
			nico_cannon_enemy = Board:GetPawn(target):GetId()
		else
			nico_cannon_enemy = -1
		end
		
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
		nicoNameUpdate(true)
		modApi.achievements:trigger(modid,"Nico_Bot_Cannon")
		modApi.toasts:add(Cannon_T)
		modApi.achievements:trigger(modid,"Nico_Bot_SW3")
		Nico_AchTrigger1()
		Nico_AchTrigger5()
	end
end

local function EVENT_onModsLoaded() --This function will run when the mod is loaded
	nicoNameUpdate(false)
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

local this={}

local path = mod_loader.mods[modApi.currentMod].resourcePath
local modid = "Nico_Sent_weap" -- concatenate 4 for Squad id

function Nico_Sent_weap4squad_Chievo(id)
    -- exit if not our squad
	if Board:GetSize() == Point(6,6) then return end -- TipImage
	if GAME.additionalSquadData.squad ~= modid.."4" then return end
	if IsTestMechScenario() then return end
	-- exit if current one is unlocked
	modApi.achievements:trigger(modid,id)
end
local imgs = {
	"Laser_B",
	"Cannon_B",
	"Arti_B",
}

local achname = "Nico_Bot_"
for _, img in ipairs(imgs) do
	modApi:appendAsset("img/achievements/".. achname..img ..".png", path .."img/achievements/".. img ..".png")
end

modApi.achievements:add{
	id = "Nico_Bot_Laser_B",
	name = "Meridia at Home",
	tip = "Have 4 different Bloom Bots in the board at the same time. This includes 1 Laser-Bloom, 1 Cannon-Bloom, 1 Artillery-Bloom, & 1 Bloom-Copter.\nHint: Bloom-Copters are deployed if the tile is not or is going to not be suitable for grounded Bloom-Bots, example: water, or cracked tiles.",
	image = "img/achievements/Nico_Bot_Laser_B.png",
	squad = "Nico_Sent_weap4",
	objective=1,
}

modApi.achievements:add{
	id = "Nico_Bot_Cannon_B",
	name = "Bloom and Doom",
	tip = "Revive a Mech and kill two enemies with a single attack of a grounded Bloom Bot's weapon.",
	image = "img/achievements/Nico_Bot_Cannon_B.png",
	squad = "Nico_Sent_weap4",
	objective=1,
}

modApi.achievements:add{
	id = "Nico_Bot_Arti_B",
	name = "Dancing with Danger",
	tip = "End a mission with all 3 Mechs alive, having 1 max HP, with the first upgrade of their weapons, and no other weapons or passives.",
	image = "img/achievements/Nico_Bot_Arti_B.png",
	squad = "Nico_Sent_weap4",
	objective = 1,
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
local function onPawnTracked(mission, pawn)
  
	local pawnList = extract_table(Board:GetPawns(TEAM_PLAYER))
	local count = 0
	isOk = { 
		{"Nico_laserbloom", false},
		{"Nico_cannonbloom", false},
		{"Nico_artillerybloom", false},
		{"Copter_Bloom_Bot", false}
	}
  
	for _, id in ipairs(extract_table(Board:GetPawns(TEAM_PLAYER))) do       
		local pawn = Board:GetPawn(id) --evaluated pawn       
		--Step 1: check if the evaluated pawn is one of the bloom bots
		for _, data in pairs(isOk) do
			if pawn:GetType() == data[1] then
				data[2] = true
				break --no need to continue
			end --indentation in discord is giving me cancer
		end
	end
  
	--Outside of the big loop!
  
	--Step 2: then, after we checked all the pawns we wanted to check, see if all elements in isOk table are ok (okay) (OKAY) OK.
	local areWeOk = true --yes, here
	for _, data in pairs(isOk) do
		if data[2] == false then
			areWeOk = false
			break --no need to continue, at least one of the bot has not been observed
		end
	end
  
	--Note that this is out of (BIG) the loop!
	if isRealMission() and areWeOk
		and GAME.additionalSquadData.squad == modid.."4"
		and not modApi.achievements:isComplete(modid,"Nico_Bot_Laser_B") then
		modApi.achievements:trigger(modid,"Nico_Bot_Laser_B")
	end
end

local function DancingWithDanger(name)--name is used for both weapon and mech IDs, it concatenates it when needed
	for _, id in ipairs(extract_table(Board:GetPawns(TEAM_PLAYER))) do       
		local pawn = Board:GetPawn(id) --evaluated pawn       
		--Step 1: check if the evaluated pawn is one of the bloom bots
			local weapons = pawn:GetPoweredWeaponTypes()
			local weapon1 = weapons[1]
			local weapon2 = weapons[2]
		if (weapon1:find(name.."_A") ~= nil or weapon1:find(name.."_AB") ~= nil)--checks for first weapon having self damage upgrade
		and weapon2 == nil--makes sure there's no second weapon
		and pawn:GetType() == name.."_mech"--concatenates for example, Nico_laserboom with _mech, with Nico_laserboom_mech being mech id
		and pawn:GetHealth() == 1 and pawn:GetMaxHealth() == 1 then--check max an current hp both being 1
			return true
		end
	end
end
local function Nico_MissionEnd(mission)
		if (DancingWithDanger("Nico_laserboom") and DancingWithDanger("Nico_cannonboom") and DancingWithDanger("Nico_artilleryboom"))
		and GAME.additionalSquadData.squad == modid.."4" and not modApi.achievements:isComplete(modid,"Nico_Bot_Arti_B") then
			modApi.achievements:trigger(modid,"Nico_Bot_Arti_B")
		end
		if not modApi.achievements:isComplete(modid,"Nico_Bot_Laser_B") then--this should reset progress if the mission ends
			modApi.achievements:reset(modid,"Nico_Bot_Laser_B")
		end
end
local function EVENT_onModsLoaded() --This function will run when the mod is loaded
	--modapiext is requested in the init.lua
	modApi:addMissionEndHook(Nico_MissionEnd)
end

modApi.events.onModsLoaded:subscribe(EVENT_onModsLoaded)
modapiext.events.onPawnTracked:subscribe(onPawnTracked)

return this

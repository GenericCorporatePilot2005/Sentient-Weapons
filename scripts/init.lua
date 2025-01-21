
-- init.lua is the entry point of every mod

local mod = {
	id = "Nico_Sent_weap",
	name = "Sentient Weapons",
	version = "3.0: Released",
	requirements = {},
	dependencies = { --This requests modApiExt from the mod loader
		modApiExt = "1.18", --We can get this by using the variable `modapiext`
	},
	modApiVersion = "2.9.1",
	icon = "img/icons/squad1_icon.png",
	description = "The pinnacle in technology is here! show the Vek a taste of their own medicine for trying to hijack Pinnacle's Bots!\nAll Mech weapons in this mod can be unlocked by completing the respective achievements.\n(Additional squads hidden behind achievements)",
}

function mod:init()
	local replaceRepair = require(self.scriptPath.."replaceRepair/replaceRepair")
	require(self.scriptPath .."weapons/weapons")
	--replacement for the skill's name and description
	local oldGetSkillInfo = GetSkillInfo
	function GetSkillInfo(skill)
		if NicoIsRobot then
			NicoIsRobot = nil
			if skill == "Survive_Death" then
				return PilotSkill("Robot", "Normal Pilots cannot be equipped. Loses 25 XP when the unit is disabled.")
			end
		end
		if NicoIsMine then
			NicoIsMine = nil
			if skill == "Survive_Death" then
				return PilotSkill("Mine Layer", "Lays Freeze Mines when moving.\n\nNormal Pilots cannot be equipped. Loses 25 XP when the unit is disabled.")
			end
		end
		return oldGetSkillInfo(skill)
	end
	require(self.scriptPath .."pawns")
	local pilot = require(self.scriptPath .."pilots")
	pilot:init(mod)
	require(self.scriptPath .."assets")
	require(self.scriptPath .."Achievements/achievements1")
	if modApi.achievements:isComplete("Nico_Sent_weap","Nico_Bot_SW2") then
		require(self.scriptPath .."Achievements/achievements2")
	end
	if modApi.achievements:isComplete("Nico_Sent_weap","Nico_Bot_SW3") then
		require(self.scriptPath .."Achievements/achievements3")
	end
	if modApi.achievements:isComplete("Nico_Sent_weap","Nico_Bot_SWBB") then
		require(self.scriptPath .."Achievements/achievements4")
	end
	
	--[[commented out for the moment, just in case we need it
	-- add extra mech to selection screen
	modApi.events.onModsInitialized:subscribe(function()

		local oldGetStartingSquad = getStartingSquad
		function getStartingSquad(choice, ...)
		local result = oldGetStartingSquad(choice, ...)

		if choice == 0 then
			return add_arrays(result, {})
		end
		return result
		end
	end)]]
end

function mod:load( options, version)
	-- after we have added our mechs, we can add a squad using them.
	modApi:addSquad(
		{
			"Sentient Weapons",-- title
			"Nico_cannonbot_mech",-- mech #2
			"Nico_laserbot_mech",-- mech #1
			"Nico_artillerybot_mech",-- mech #3
			id="Nico_Sent_weap"
		},
		"Sentient Weapons",
		"After destroying the Vek Hive, Zenith sent these improved Sentient Weapons across time to fight the Vek and their hijacked brethren.",
		self.resourcePath .."img/icons/squad1_icon.png"
	)
	if modApi.achievements:isComplete("Nico_Sent_weap","Nico_Bot_SW2") then
		modApi:addSquad(
			{
				"Sentient Weapons 2",-- title
				"Nico_minerbot_mech",-- mech #2
				"Nico_knightbot_mech",-- mech #1
				"Nico_shieldbot_mech",-- mech #3
				id="Nico_Sent_weap2"
			},
			"Sentient Weapons 2",
			"After destroying the Vek Hive, Zenith sent these improved Sentient Weapons across time to fight the Vek and their hijacked brethren.",
			self.resourcePath .."img/icons/squad2_icon.png"
		)
	end
	if modApi.achievements:isComplete("Nico_Sent_weap","Nico_Bot_SW3") then
		modApi:addSquad(
			{
				"Sentient Weapons 3",-- title
				"Nico_botleader_mech",-- mech #2
				"Nico_juggernautbot_mech",-- mech #1
				"Nico_hulkbot_mech",-- mech #3
				id="Nico_Sent_weap3"
			},
			"Sentient Weapons 3",
			"After destroying the Vek Hive, Zenith sent these improved Sentient Weapons across time to fight the Vek and their hijacked brethren.",
			self.resourcePath .."img/icons/squad3_icon.png"
		)
	end
	if modApi.achievements:isComplete("Nico_Sent_weap","Nico_Bot_SWBB") then
		modApi:addSquad(
			{
				"Boom Bots",-- title
				"Nico_cannonboom_mech",-- mech #2
				"Nico_laserboom_mech",-- mech #1
				"Nico_artilleryboom_mech",-- mech #3
				id="Nico_Sent_weap4"
			},
			"Boom Bots",
			"After destroying the Vek Hive, Zenith sent these improved Volatile Sentient Weapons across time to fight the Vek and their hijacked brethren.",
			self.resourcePath .."img/icons/squadboom_icon.png"
		)
	end
	modApi:addMissionEndHook(function()
        for id = 0, 2 do
            local pawn = Game:GetPawn(id)
            if pawn then
                LOG("Detected pawn ".. pawn:GetMechName())
                
                if pawn:IsDead() and GetCurrentMission().ID ~= "Mission_Final_Cave" then
                    LOG(pawn:GetMechName() .." is dead")
                    
                    if pawn:IsAbility("Nico_BotRepair") then
						local spot = pawn:GetSpace()
						if Board:IsTerrain(spot,TERRAIN_HOLE) then
							pawn:SetHealth(1) Board:RemovePawn(pawn) Board:SetTerrain(spot,0) Board:AddPawn(pawn,spot) pawn:SetSpace(Point(-1,-1)) Board:SetTerrain(spot,TERRAIN_HOLE)
							LOG("reviving Leader Bot")
						else
							pawn:SetHealth(1)
							LOG("reviving Leader Bot")
						end
                    end
                end
            end
        end
    end)

	if modApi.achievements:isComplete("Nico_Sent_weap","Nico_Bot_SW2") and modApi.achievements:isComplete("Nico_Sent_weap","Nico_Bot_SW3") and modApi.achievements:isComplete("Nico_Sent_weap","Nico_Bot_SWBB") then
		mod.icon = self.resourcePath .."img/icons/mod_icon.png"
	elseif modApi.achievements:isComplete("Nico_Sent_weap","Nico_Bot_SW2") and not modApi.achievements:isComplete("Nico_Sent_weap","Nico_Bot_SW3") and not modApi.achievements:isComplete("Nico_Sent_weap","Nico_Bot_SWBB") then
		mod.icon = self.resourcePath .."img/icons/squad2_icon.png"
	elseif modApi.achievements:isComplete("Nico_Sent_weap","Nico_Bot_SW2") and modApi.achievements:isComplete("Nico_Sent_weap","Nico_Bot_SW3") and not modApi.achievements:isComplete("Nico_Sent_weap","Nico_Bot_SWBB") then
		mod.icon = self.resourcePath .."img/icons/squad2x3_icon.png"
	elseif modApi.achievements:isComplete("Nico_Sent_weap","Nico_Bot_SW2") and not modApi.achievements:isComplete("Nico_Sent_weap","Nico_Bot_SW3") and modApi.achievements:isComplete("Nico_Sent_weap","Nico_Bot_SWBB") then
		mod.icon = self.resourcePath .."img/icons/squad2xboom_icon.png"
	elseif not modApi.achievements:isComplete("Nico_Sent_weap","Nico_Bot_SW2") and modApi.achievements:isComplete("Nico_Sent_weap","Nico_Bot_SW3") and modApi.achievements:isComplete("Nico_Sent_weap","Nico_Bot_SWBB") then
		mod.icon = self.resourcePath .."img/icons/squad3xboom_icon.png"
	elseif not modApi.achievements:isComplete("Nico_Sent_weap","Nico_Bot_SW2") and modApi.achievements:isComplete("Nico_Sent_weap","Nico_Bot_SW3") and not modApi.achievements:isComplete("Nico_Sent_weap","Nico_Bot_SWBB") then
		mod.icon = self.resourcePath .."img/icons/squad3_icon.png"
	elseif not modApi.achievements:isComplete("Nico_Sent_weap","Nico_Bot_SW2") and not modApi.achievements:isComplete("Nico_Sent_weap","Nico_Bot_SW3") and modApi.achievements:isComplete("Nico_Sent_weap","Nico_Bot_SWBB") then
		mod.icon = self.resourcePath .."img/icons/squadboom_icon.png"
	else
		mod.icon = self.resourcePath .."img/icons/squad1_icon.png"
	end
end

return mod

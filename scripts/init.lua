
-- init.lua is the entry point of every mod

local mod = {
	id = "Nico_Sent_weap",
	name = "Sentient Weapons",
	version = "Beta",
	requirements = {},
	dependencies = { --This requests modApiExt from the mod loader
		modApiExt = "1.18", --We can get this by using the variable `modapiext`
	},
	modApiVersion = "2.9.1",
	icon = "img/mod_icon.png"
}

function mod:init()
	-- look in template/mech to see how to code mechs.
	local replaceRepair = require(self.scriptPath.."replaceRepair/replaceRepair")
	require(self.scriptPath .."weapons/weapons")
	require(self.scriptPath .."pawns")
	local pilot = require(self.scriptPath .."pilots")
	pilot:init(mod)
	require(self.scriptPath .."assets")
	
	-- add extra mech to selection screen
	modApi.events.onModsInitialized:subscribe(function()

		local oldGetStartingSquad = getStartingSquad
		function getStartingSquad(choice, ...)
		local result = oldGetStartingSquad(choice, ...)

		if choice == 0 then
			return add_arrays(result, {"Nico_juggernautbot_mech","Nico_botleader_mech","Nico_hulkbot_mech"})
		end
		return result
		end
	end)
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
		self.resourcePath .."img/squad1_icon.png"
	)
	modApi:addSquad(
		{
			"Sentient Weapons 2",-- title
			"Nico_knightbot_mech",-- mech #2
			"Nico_minerbot_mech",-- mech #1
			"Nico_shieldbot_mech",-- mech #3
			id="Nico_Sent_weap2"
		},
		"Sentient Weapons 2",
		"After destroying the Vek Hive, Zenith sent these improved Sentient Weapons across time to fight the Vek and their hijacked brethren.",
		self.resourcePath .."img/squad2_icon.png"
	)
	modApi:addMissionEndHook(function()
        for id = 0, 2 do
            local pawn = Game:GetPawn(id)
            if pawn then
                LOG("Detected pawn ".. pawn:GetMechName())
                
                if pawn:IsDead() then
                    LOG(pawn:GetMechName() .." is dead")
                    
                    if pawn:IsAbility("Nico_BotRepair") then
                        LOG("reviving Leader Bot")
						pawn:SetHealth(1)
                    end
                end
            end
        end
    end)
end

return mod

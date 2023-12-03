
-- init.lua is the entry point of every mod

local mod = {
	id = "Nico_Sent_weap",
	name = "Sentient Weapons",
	version = "0",
	requirements = {},
	dependencies = { --This requests modApiExt from the mod loader
		modApiExt = "1.17", --We can get this by using the variable `modapiext`
	},
	modApiVersion = "2.8.3",
	icon = "img/mod_icon.png"
}

function mod:init()
	-- look in template/mech to see how to code mechs.
	require(self.scriptPath .."weapons")
	require(self.scriptPath .."pawns")
	-- add extra mech to selection screen
	modApi.events.onModsInitialized:subscribe(function()

		local oldGetStartingSquad = getStartingSquad
		function getStartingSquad(choice, ...)
		local result = oldGetStartingSquad(choice, ...)

		if choice == 0 then
			return add_arrays(result, {"Nico_knightbot_mech","Nico_shieldbot_mech"})
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
		self.resourcePath .."img/mod_icon.png"
	)
	modApi:addSquad(
		{
			"Sentient Weapons, 2nd Divission",-- title
			"Nico_knightbot_mech",-- mech #2
			"Nico_laserbot_mech",-- mech #1
			"Nico_shieldbot_mech",-- mech #3
			id="Nico_Sent_weap2"
		},
		"Sentient Weapons, Second Divission",
		"After destroying the Vek Hive, Zenith sent these improved Sentient Weapons across time to fight the Vek and their hijacked brethren.",
		self.resourcePath .."img/mod_icon.png"
	)
end

return mod

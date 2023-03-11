
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
--	require(self.scriptPath .."weapons")
	require(self.scriptPath .."pawns")
    require(self.scriptPath .."palette")
end

function mod:load( options, version)
	-- after we have added our mechs, we can add a squad using them.
	modApi:addSquad(
		{
			"Sentient Weapons",	-- title
			"Nico_artillerybot_mech",    -- mech #1
			"Nico_artillerybot_mech",-- mech #2
			"Nico_artillerybot_mech",	 -- mech #3
			id="Nico_Sent_weap"
		},
		"Sentient Weapons",
		"Since the vek treath was destroyed, Zenith managed to put their weapons on their senses again, now they travel across the multiverse to fight the vek and their corrupted brothers.",
		self.resourcePath .."img/mod_icon.png"
	)
end

return mod
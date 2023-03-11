
local mod = modApi:getCurrentMod()

local palette = {
        image="units/player/Nico_artillerybot_mech_ns.png",
        id = mod.id,
        name = "Sentient Weapon's Light Blue & Silver",
        colorMap = {
			PlateHighlight = {255,  14,  19},
			PlateLight     = {100, 151, 143},
			PlateMid       = { 50,  71,  88},
			PlateDark      = { 31,  34,  46},
			PlateOutline   = { 17,  17,  18},
			PlateShadow    = { 74,  76,  80},
			BodyColor      = {125, 135, 144},
			BodyHighlight  = {208, 213, 217},
		},
}

modApi:addPalette(palette)

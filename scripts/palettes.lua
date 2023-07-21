local mod = modApi:getCurrentMod()
local path = mod.scriptPath
require(path .."achievements1")
--palettes
modApi:addPalette{--base sentient weapons
    id = "nico_snow",
    image="units/player/Nico_artillerybot_mech_ns.png",
    name = "Sentient Weapon's Light Blue & Silver",
    PlateHighlight = {255,  14,  19},
    PlateLight     = {100, 151, 143},
    PlateMid       = { 50,  71,  88},
    PlateDark      = { 31,  34,  46},
    PlateOutline   = { 17,  17,  18},
    PlateShadow    = { 74,  76,  80},
    BodyColor      = {125, 135, 144},
    BodyHighlight  = {208, 213, 217},
}
if modApi.achievements:isComplete("Nico_Sent_weap","Nico_Bot_SW2") then
    modApi:addPalette{--sentient weapons 2
        ID = "nico_alpha_snow",
        image="units/player/Nico_knightbot_mech_ns.png",
        Name = "Sentient Weapon's Pink & Black",
        PlateHighlight = {255,  14,  19},
        PlateLight     = {181, 165, 216},
        PlateMid       = {151,  88, 153},
        PlateDark      = { 74,  58,  66},
        PlateOutline   = { 27,  25,  27},
        PlateShadow    = { 41,  50,  48},
        BodyColor      = { 71,  92,  85},
        BodyHighlight  = {137, 162, 153},
    }
    modApi:addPalette{--deployable unupgraded mine-bot
        ID = "Nico_mine_iceflower",
        Name = "Mine-Bot Mark I/II",
        image="units/player/Nico_minerbot_mech_ns.png",
        PlateHighlight = {233,161,172},--lights
        PlateLight     = {189,220,225},--main highlight
        PlateMid       = {146,182,207},--main light
        PlateDark      = {91,107,158},--main mid
        PlateOutline   = {16,16,16},--main dark
        PlateShadow    = {60,91,117},--metal dark
        BodyColor      = {104,116,193},--metal mid
        BodyHighlight  = {219,255,242},--metal light
    }
    modApi:addPalette{--deployable upgraded mine-bot
        ID = "Nico_mine_winter",
        Name = "Mine-Bot Mark III/IV",
        image="units/player/Nico_minerbot_mech_ns.png",
        PlateHighlight = {255,245,101},--lights
        PlateLight     = {217,216,221},--main highlight
        PlateMid       = {123,122,128},--main light
        PlateDark      = {71,72,77},--main mid
        PlateOutline   = {46,45,51},--main dark
        PlateShadow    = {71,163,157},--metal dark
        BodyColor      = {144,215,219},--metal mid
        BodyHighlight  = {246,255,255},--metal light
    }
end
if modApi.achievements:isComplete("Nico_Sent_weap","Nico_Bot_SW3") then
    modApi:addPalette{--sentient weapons 3
        ID = "nico_boss_snow",
        Image="units/player/Nico_juggernautbot_mech_ns.png",
        Name = "Sentient Weapon's Olive Green & Grey",
        PlateHighlight = {255,  14,  19},
        PlateLight     = {200, 216, 165},
        PlateMid       = { 90, 153,  88},
        PlateDark      = { 58,  74,  66},
        PlateOutline   = { 27,  26,  25},
        PlateShadow    = { 45,  41,  50},
        BodyColor      = { 76,  71,  92},
        BodyHighlight  = {137, 146, 162},
    }
end
if modApi.achievements:isComplete("Nico_Sent_weap","Nico_Bot_SWBB") then
    modApi:addPalette{--Boom Bots
        ID = "Nico_boom_snow",
        Name = "Boom Bots' Orange and Blue Silver",
        image="units/player/Nico_laserboom_mech_ns.png",
        PlateHighlight = {255,233,231},--lights
        PlateLight     = {252,160,81},--main highlight
        PlateMid       = {146,94,53},--main light
        PlateDark      = {86,66,48},--main mid
        PlateOutline   = {27,25,27},--main dark
        PlateShadow    = {42,42,50},--metal dark
        BodyColor      = {72,71,92},--metal mid
        BodyHighlight  = {137,137,162},--metal light
    }
    modApi:addPalette{--Bloom Bot Laser
        ID = "Nico_bloom_1",
        Name = "Bloom Bot Laser",
        image="units/player/Nico_laserbot_mech_ns.png",
        PlateHighlight = {255,0,0},--lights
        PlateLight     = {177,221,108},--main highlight
        PlateMid       = {76,130,79},--main light
        PlateDark      = {49,74,54},--main mid
        PlateOutline   = {27,35,25},--main dark
        BodyHighlight  = {100,151,143},--metal light
        BodyColor      = {50,71,88},--metal mid
        PlateShadow    = {31,34,46},--metal dark
    }
    modApi:addPalette{--Bloom Bot Cannon
        ID = "Nico_bloom_2",
        Name = "Bloom Bot Cannon",
        image="units/player/Nico_cannonbot_mech_ns.png",
        PlateHighlight = {255,0,0},--lights
        PlateLight     = {177,221,108},--main highlight
        PlateMid       = {76,130,79},--main light
        PlateDark      = {49,74,54},--main mid
        PlateOutline   = {27,35,25},--main dark
        BodyHighlight  = {181,165,216},--metal light
        BodyColor      = {151,88,153},--metal mid
        PlateShadow    = {74,58,66},--metal dark
    }
    modApi:addPalette{--Bloom Bot Artillery
        ID = "Nico_bloom_3",
        Name = "Bloom Bot Artillery",
        image="units/player/Nico_artillerybot_mech_ns.png",
        PlateHighlight = {255,0,0},--lights
        PlateLight     = {177,221,108},--main highlight
        PlateMid       = {76,130,79},--main light
        PlateDark      = {49,74,54},--main mid
        PlateOutline   = {27,35,25},--main dark
        BodyHighlight  = {252,160,81},--metal light
        BodyColor      = {146,94,53},--metal mid
        PlateShadow    = {86,66,48},--metal dark
    }
end
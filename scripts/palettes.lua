local mod = modApi:getCurrentMod()
local path = mod.scriptPath
local path2 = mod.resourcePath
local AllAchs = 0
local options = mod_loader.currentModContent[mod.id].options
require(path .."Achievements/achievements1")
--palettes--
modApi:addPalette{--base sentient weapons
    id = "nico_snow",image = "img/units/player/Nico_artillerybot_mech_ns.png",
    name = "Sentient Weapon's Light Blue & Silver",PlateHighlight = {255,  14,  19},
    PlateLight  = {100,151,143},PlateMid  = {50,71,88},
    PlateDark   = {31,34,46},PlateOutline  = {17,17,18},
    PlateShadow = {74,76,80},BodyColor = {125,135,144},
    BodyHighlight  = {208,213,217},}
    if modApi.achievements:isComplete("Nico_Sent_weap", "Nico_Bot_Laser") and options["Nico_snow_Laser"].value and options["Nico_snow_Laser"].value~="" then
        modApi:appendAsset("img/units/player/Nico_laserbot_mech_icon.png",path2 .."img/units/player/SW1/unlocks/Nico_laserbot_mech_ns.png")
        modApi:addPalette{
            id = "nico_ach_laser", image = "units/player/Nico_laserbot_mech_icon.png", name = "Chilling Around",
            PlateHighlight  = {99,214,214}, PlateLight   = {100,151,143}, PlateMid   = {50,71,88},
            PlateDark   = {31,34,46}, PlateOutline  = {17,17,18}, PlateShadow = {74,76,80},
            BodyColor   = {125,135,144}, BodyHighlight = {208,213,217},}
    end
if modApi.achievements:isComplete("Nico_Sent_weap","Nico_Bot_SW2") then
    require(path .."Achievements/achievements2")
    modApi:addPalette{--sentient weapons 2
        ID = "nico_alpha_snow",
        image = "units/player/Nico_knightbot_mech_ns.png",
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
    if modApi.achievements:isComplete("Nico_Sent_weap", "Nico_Bot_Knight") then
        modApi:addPalette{--B Knight
            ID = "nico_ach_knight1",
            image = "units/player/Nico_knightbot_mech_ns.png",
            Name = "Black Knight-Bot",
            PlateHighlight = {255,  14,  19},
            PlateLight     = {85,85,85},
            PlateMid       = {51,51,51},
            PlateDark      = {25,25,25},
            PlateOutline   = {13,13,13},
            PlateShadow    = {71,11,3},
            BodyColor      = {127,20,20},
            BodyHighlight  = {241,102,102},
        }
        modApi:addPalette{--W Knight
            ID = "nico_ach_knight2",
            image = "units/player/Nico_knightbot_mech_ns.png",
            Name = "White Knight-Bot",
            PlateHighlight = {255,  14,  19},
            PlateLight     = {209,209,209},
            PlateMid       = {159,159,159},
            PlateDark      = {114,114,114},
            PlateOutline   = {27,39,74},
            PlateShadow    = {22,50,128},
            BodyColor      = {52,83,167},
            BodyHighlight  = {143,163,217},
        }
    end
    if modApi.achievements:isComplete("Nico_Sent_weap", "Nico_Bot_Shield") then
        modApi:addPalette{--sentient weapons 2
            ID = "nico_ach_shield",
            image = "units/player/Nico_shieldbot_mech_ns.png",
            Name = "Pinnacle's Contraption",
            PlateHighlight = {192,251,255},
            PlateLight     = {246,240,211},
            PlateMid       = {204,186,152},
            PlateDark      = {133,104,84},
            PlateOutline   = {70,46,47},
            PlateShadow    = {34,54,73},
            BodyColor      = {80,96,112},
            BodyHighlight  = {169,170,186},
        }
    end
    if modApi.achievements:isComplete("Nico_Sent_weap", "Nico_Bot_Mine") then
        modApi:addPalette{--sentient weapons 2
            ID = "nico_ach_mine",
            image = "units/player/Nico_minerbot_mech_ns.png",
            Name = "'Freeze Mine'-Bot",
            PlateHighlight = {196,235,235},
            PlateLight     = {164,150,138},
            PlateMid       = {84,78,68},
            PlateDark      = {59,46,41},
            PlateOutline   = {27,25,22},
            PlateShadow    = {59,46,41},
            BodyColor      = {84,78,68},
            BodyHighlight  = {164,150,138},
        }
    end
end
if modApi.achievements:isComplete("Nico_Sent_weap","Nico_Bot_SW3") then
    modApi:addPalette{
        id = "nico_ach_cannon", image = "units/player/Nico_cannonbot_mech_ns.png", name = "H4CK3D",
        PlateHighlight  = {255,246,187}, PlateLight = {99,110,171}, PlateMid    = {68,68,114},
        PlateDark   = {55,43,67}, PlateOutline  = {27,16,36}, PlateShadow = {40,44,40},
        BodyColor   = {82,87,78}, BodyHighlight = {175,181,159},}
    modApi:addPalette{--sentient weapons 3
        ID = "nico_boss_snow",Image = "units/player/Nico_juggernautbot_mech_ns.png",
        Name = "Sentient Weapon's Olive Green & Grey",PlateHighlight = {255,  14,  19},
        PlateLight  = {200, 216, 165},PlateMid    = { 90, 153,  88},
        PlateDark   = { 58,  74,  66},PlateOutline   = { 27,  26,  25},
        PlateShadow = { 45,  41,  50},BodyColor   = { 76,  71,  92},
        BodyHighlight  = {137, 146, 162},}
    if modApi.achievements:isComplete("Nico_Sent_weap", "Nico_Bot_Jugger") then
        modApi:addPalette{--sentient weapons 3
            ID = "nico_ach_jugger1",Image = "units/player/Nico_juggernautbot_mech_ns.png",
            Name = "Jugger-Rig 1",PlateHighlight = {13,255,255},
            PlateLight  = {160,135,112},PlateMid    = {107,82,59},
            PlateDark   = {71,46,23},PlateOutline   = {33,17,1},
            PlateShadow = {25,28,28},BodyColor   = {44,50,49},
            BodyHighlight  = {79,87,81},}
        modApi:addPalette{--sentient weapons 3
            ID = "nico_ach_jugger2",Image = "units/player/Nico_juggernautbot_mech_ns.png",
            Name = "Jugger-Rig 2",PlateHighlight = {13,255,255},
            PlateLight  = {134,142,144},PlateMid    = {80,89,91},
            PlateDark   = {43,54,56},PlateOutline   = {43,54,56},
            PlateShadow = {25,28,28},BodyColor   = {44,50,49},
            BodyHighlight  = {79,87,81},}
    end
    if modApi.achievements:isComplete("Nico_Sent_weap", "Nico_Bot_Leader") then
        modApi:addPalette{--sentient weapons 3
            ID = "nico_ach_leader",
            Image = "units/player/Nico_artillerybot_mech_ns.png",
            Name = "Leader of Leaders",
            PlateHighlight = {255,197,86},
            PlateLight     = {243,94,222},
            PlateMid       = {133,55,152},
            PlateDark      = {56,34,78},
            PlateOutline   = {22,9,10},
            PlateShadow    = {155,63,63},
            BodyColor      = {255,95,75},
            BodyHighlight  = {255,187,131},
        }
    end
    if modApi.achievements:isComplete("Nico_Sent_weap", "Nico_Bot_Hulk") then
        modApi:addPalette{--sentient weapons 3
            ID = "nico_ach_hulk",
            Image = "units/player/Nico_hulkbot_mech_ns.png",
            Name = "Frozen Hulk",
            PlateHighlight = {91,0,0},
            PlateLight     = {84,77,95},
            PlateMid       = {53,46,61},
            PlateDark      = {30,23,36},
            PlateOutline   = {13,13,13},
            PlateShadow    = {22,20,25},
            BodyColor      = {38,35,46},
            BodyHighlight  = {68,73,81},
        }
    end
end
if modApi.achievements:isComplete("Nico_Sent_weap","Nico_Bot_SW4") then
    modApi:addPalette{
        id = "nico_ach_arty", image = "units/player/Nico_artillerybot_mech_ns.png", name = "Self Promotion",
        PlateHighlight  = {136,206,247}, PlateLight = {226,139,94}, PlateMid    = {178,101,46},
        PlateDark   = {106,62,25}, PlateOutline  = {30,22,19}, PlateShadow = {43,44,45},
        BodyColor   = {67,72,68}, BodyHighlight = {134,146,120},}
    require(path .."Achievements/achievements4")
    modApi:addPalette{--Boom Bots
        ID = "Nico_boom_snow",
        Name = "Boom Bots' Orange & Blue Silver",
        image = "units/player/Nico_laserboom_mech_ns.png",
        PlateHighlight = {255,233,231},--lights
        PlateLight     = {252,160,81},--main highlight
        PlateMid       = {146,94,53},--main light
        PlateDark      = {86,66,48},--main mid
        PlateOutline   = {27,25,27},--main dark
        PlateShadow    = {42,42,50},--metal dark
        BodyColor      = {72,71,92},--metal mid
        BodyHighlight  = {137,137,162},--metal light
    }
    if modApi.achievements:isComplete("Nico_Sent_weap", "Nico_Bot_Laser_B") then
        modApi:addPalette{--Bloom Bot Laser
            ID = "Nico_bloom_1",
            Name = "Bloom Bot Laser",
            image = "units/player/Nico_laserboom_mech_ns.png",
            PlateHighlight = {255,0,0},--lights
            PlateLight     = {177,221,108},--main highlight
            PlateMid       = {76,130,79},--main light
            PlateDark      = {49,74,54},--main mid
            PlateOutline   = {27,35,25},--main dark
            BodyHighlight  = {100,151,143},--metal light
            BodyColor      = {50,71,88},--metal mid
            PlateShadow    = {31,34,46},--metal dark
        }
    end
    if modApi.achievements:isComplete("Nico_Sent_weap", "Nico_Bot_Cannon_B") then
        modApi:addPalette{--Bloom Bot Cannon
            ID = "Nico_bloom_2",
            Name = "Bloom Bot Cannon",
            image = "units/player/Nico_cannonboom_mech_ns.png",
            PlateHighlight = {255,0,0},--lights
            PlateLight     = {177,221,108},--main highlight
            PlateMid       = {76,130,79},--main light
            PlateDark      = {49,74,54},--main mid
            PlateOutline   = {27,35,25},--main dark
            BodyHighlight  = {181,165,216},--metal light
            BodyColor      = {151,88,153},--metal mid
            PlateShadow    = {74,58,66},--metal dark
        }
    end
    if modApi.achievements:isComplete("Nico_Sent_weap", "Nico_Bot_Arti_B") then
        modApi:addPalette{--Bloom Bot Artillery
            ID = "Nico_bloom_3",image = "units/player/Nico_artilleryboom_mech_ns.png",Name = "Bloom Bot Artillery",
            image = "units/player/Nico_artilleryboom_mech_ns.png",PlateHighlight = {255,0,0},--lights
            PlateLight  = {177,221,108},PlateMid    = {76,130,79},--main light
            PlateDark   = {49,74,54},PlateOutline   = {27,35,25},--main dark
            BodyHighlight   = {252,160,81},BodyColor = {146,94,53},PlateShadow  = {86,66,48},}
    end
end

if modApi.achievements:isComplete("Nico_Sent_weap", "Nico_Bot_Laser") and
modApi.achievements:isComplete("Nico_Sent_weap", "Nico_Bot_Cannon") and modApi.achievements:isComplete("Nico_Sent_weap", "Nico_Bot_Arti") then
    AllAchs = AllAchs +1
    modApi:addPalette{--base sentient weapons
    id = "nico_ach_SW1",image = "units/player/Nico_artillerybot_mech_ns.png",
    name = "Factory Reset",PlateHighlight = {255,14,19},
    PlateLight  = {254,254,250},PlateMid = {169,170,186},
    PlateDark   = {62,79,100},PlateOutline  = {36,43,51},
    PlateShadow = {10,21,27},BodyColor = {34,54,73},
    BodyHighlight   = {117,131,148},}
end
if Nico_Sent_weap2 ~= nil and modApi.achievements:isComplete("Nico_Sent_weap", "Nico_Bot_Knight") and
    modApi.achievements:isComplete("Nico_Sent_weap", "Nico_Bot_Shield") and modApi.achievements:isComplete("Nico_Sent_weap", "Nico_Bot_Mine") then
        AllAchs = AllAchs +1
    modApi:addPalette{--deployable unupgraded mine-bot
        ID = "Nico_mine_iceflower",
        Name = "Mine-Bot Mark I/II",
        image = "units/player/Nico_minerbot_mech_ns.png",
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
        image = "units/player/Nico_minerbot_mech_ns.png",
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
if Nico_Sent_weap3 ~= nil and modApi.achievements:isComplete("Nico_Sent_weap", "Nico_Bot_Leader") and
modApi.achievements:isComplete("Nico_Sent_weap", "Nico_Bot_Jugger") and modApi.achievements:isComplete("Nico_Sent_weap", "Nico_Bot_Hulk") then
    AllAchs = AllAchs +1
    modApi:addPalette{--sentient weapons 3
        ID = "nico_ach_SW3",
        Image = "units/player/Nico_artillerybot_mech_ns.png",
        Name = "Unstoppable Force",
        PlateHighlight = {255,115,115},
        PlateLight     = {81,87,93},
        PlateMid       = {54,58,63},
        PlateDark      = {30,34,37},
        PlateOutline   = {16,19,21},
        PlateShadow    = {30,20,25},
        BodyColor      = {81,87,93},
        BodyHighlight  = {134,142,152},
    }
end
if Nico_Sent_weap4 ~= nil and modApi.achievements:isComplete("Nico_Sent_weap", "Nico_Bot_Laser_B") and
    modApi.achievements:isComplete("Nico_Sent_weap", "Nico_Bot_Cannon_B") and modApi.achievements:isComplete("Nico_Sent_weap", "Nico_Bot_Arti_B") then
        AllAchs = AllAchs +1
    modApi:addPalette{--Bloom Bot Artillery
        ID = "Nico_bloom_4",image = "units/player/Laser_Bloom_ns.png",
        Name = "Bloom Bot Copter",image = "units/player/Nico_artilleryboom_mech_ns.png",
        PlateHighlight = {255,255,255},PlateLight     = {177,221,108},--main highlight
        PlateMid       = {76,130,79},PlateDark      = {49,74,54},--main mid
        PlateOutline   = {27,35,25},BodyHighlight  = {215,61,70},--metal light
        BodyColor      = {118,52,79},PlateShadow    = {51,14,29},}
end
if AllAchs == 4 then
    modApi:addPalette{--Bloom Bot Laser
        ID = "Nico_ach_SW1",
        Name = "Sentient Weapon's Silver & Light Blue",
        image = "units/player/Nico_cannonbot_mech_ns.png",
        PlateHighlight = {255,  14,  19},
        PlateLight     = {208, 213, 217},
        PlateMid       = {125, 135, 144},
        PlateDark      = { 74,  76,  80},
        PlateOutline   = { 17,  17,  18},
        PlateShadow    = { 31,  34,  46},
        BodyColor      = { 50,  71,  88},
        BodyHighlight  = {100, 151, 143},}
    modApi:addPalette{--Bloom Bot Laser
        ID = "Nico_ach_SW2",
        image = "units/player/Nico_knightbot_mech_ns.png",
        Name = "Sentient Weapon's Black & Pink",
        PlateHighlight = {255,  14,  19},
        PlateLight     = {137, 162, 153},
        PlateMid       = { 41,  50,  48},
        PlateDark      = { 74,  58,  66},
        PlateOutline   = { 27,  25,  27},
        PlateShadow    = { 71,  92,  85},
        BodyColor      = {151,  88, 153},
        BodyHighlight  = {181, 165, 216},
    }
    modApi:addPalette{--Bloom Bot Laser
        ID = "Nico_ach_SW3",Image = "units/player/Nico_artillerybot_mech_ns.png",
        Name = "Sentient Weapon's Grey & Olive Green",
        PlateHighlight = {255,  14,  19},
        PlateLight  = {137,146,162},
        PlateMid    = { 76,  71,  92},
        PlateDark   = { 45,  41,  50},
        PlateOutline   = { 27,  26,  25},
        PlateShadow = { 58,  74,  66},
        BodyColor   = { 90, 153,  88},
        BodyHighlight  = {200, 216, 165},}
    modApi:addPalette{--Bloom Bot Laser
        ID = "Nico_ach_SW4",
        Name = "Boom Bots' Blue Silver & Orange",
        image = "units/player/Nico_laserboom_mech_ns.png",
        PlateHighlight = {255,233,231},--lights
        PlateLight     = {137,137,162},
        PlateMid       = {72,71,92},
        PlateDark      = {42,42,50},
        PlateOutline   = {27,25,27},
        PlateShadow    = {86,66,48},
        BodyColor      = {146,94,53},
        BodyHighlight  = {252,160,81},
    }
end
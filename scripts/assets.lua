local mod = modApi:getCurrentMod()
local path = mod_loader.mods[modApi.currentMod].resourcePath
-- locate our mech assets.
--Artillery-bot
local artmechPath = path .."img/units/player/"
-- make a list of our files.
local files = {
    "Nico_artillerybot_mech.png",
    "Nico_artillerybot_mech_a.png",
    "Nico_artillerybot_mech_w.png",
    "Nico_artillerybot_mech_w_broken.png",
    "Nico_artillerybot_mech_broken.png",
    "Nico_artillerybot_mech_ns.png",
    "Nico_artillerybot_mech_h.png",
}
for _, file in ipairs(files) do
    modApi:appendAsset("img/units/player/".. file, artmechPath .. file)
end
local a=ANIMS
    a.Nico_artillerybot_mech =a.MechUnit:new{Image="units/player/Nico_artillerybot_mech.png", PosX = -18, PosY = -9}
    a.Nico_artillerybot_mecha = a.MechUnit:new{Image="units/player/Nico_artillerybot_mech_a.png",  PosX = -18, PosY = -9, NumFrames = 4 }
    a.Nico_artillerybot_mechw = a.MechUnit:new{Image="units/player/Nico_artillerybot_mech_w.png", PosX = -18, PosY = -2}
    a.Nico_artillerybot_mech_broken = a.MechUnit:new{Image="units/player/Nico_artillerybot_mech_broken.png", PosX = -18, PosY = -9 }
    a.Nico_artillerybot_mechw_broken = a.MechUnit:new{Image="units/player/Nico_artillerybot_mech_w_broken.png", PosX = -18, PosY = -2 }
    a.Nico_artillerybot_mech_ns = a.MechIcon:new{Image="units/player/Nico_artillerybot_mech_ns.png"}

-- locate our mech assets.
--Laser-bot
local lasermechPath = path .."img/units/player/"
-- make a list of our files.
local files = {
    "Nico_laserbot_mech.png",
    "Nico_laserbot_mech_a.png",
    "Nico_laserbot_mech_w.png",
    "Nico_laserbot_mech_w_broken.png",
    "Nico_laserbot_mech_broken.png",
    "Nico_laserbot_mech_ns.png",
    "Nico_laserbot_mech_h.png",
}
for _, file in ipairs(files) do
    modApi:appendAsset("img/units/player/".. file, lasermechPath .. file)
end
local a=ANIMS
    a.Nico_laserbot_mech =a.MechUnit:new{Image="units/player/Nico_laserbot_mech.png", PosX = -15, PosY = -2}
    a.Nico_laserbot_mecha = a.MechUnit:new{Image="units/player/Nico_laserbot_mech_a.png",  PosX = -15, PosY = -2, NumFrames = 4 }
    a.Nico_laserbot_mechw = a.MechUnit:new{Image="units/player/Nico_laserbot_mech_w.png", PosX = -15, PosY = 4}
    a.Nico_laserbot_mech_broken = a.MechUnit:new{Image="units/player/Nico_laserbot_mech_broken.png", PosX = -15, PosY = -2 }
    a.Nico_laserbot_mechw_broken = a.MechUnit:new{Image="units/player/Nico_laserbot_mech_w_broken.png", PosX = -15, PosY = 4 }
    a.Nico_laserbot_mech_ns = a.MechIcon:new{Image="units/player/Nico_laserbot_mech_ns.png"}

-- locate our mech assets.
--Cannon-bot
local cannonmechPath = path .."img/units/player/"
-- make a list of our files.
local files = {
    "Nico_cannonbot_mech.png",
    "Nico_cannonbot_mech_a.png",
    "Nico_cannonbot_mech_w.png",
    "Nico_cannonbot_mech_w_broken.png",
    "Nico_cannonbot_mech_broken.png",
    "Nico_cannonbot_mech_ns.png",
    "Nico_cannonbot_mech_h.png",
}
for _, file in ipairs(files) do
    modApi:appendAsset("img/units/player/".. file, cannonmechPath .. file)
end
local a=ANIMS
    a.Nico_cannonbot_mech =a.MechUnit:new{Image="units/player/Nico_cannonbot_mech.png", PosX = -20, PosY = 4}
    a.Nico_cannonbot_mecha = a.MechUnit:new{Image="units/player/Nico_cannonbot_mech_a.png",  PosX = -20, PosY = -4, NumFrames = 3 }
    a.Nico_cannonbot_mechw = a.MechUnit:new{Image="units/player/Nico_cannonbot_mech_w.png", PosX = -17, PosY = 2}
    a.Nico_cannonbot_mech_broken = a.MechUnit:new{Image="units/player/Nico_cannonbot_mech_broken.png", PosX = -20, PosY = -4 }
    a.Nico_cannonbot_mechw_broken = a.MechUnit:new{Image="units/player/Nico_cannonbot_mech_w_broken.png", PosX = -20, PosY = 2 }
    a.Nico_cannonbot_mech_ns = a.MechIcon:new{Image="units/player/Nico_cannonbot_mech_ns.png"}
--Knight-bot
-- locate our mech assets.
local knightmechPath = path .."img/units/player/"
-- make a list of our files.
local files = {
    "Nico_knightbot_mech.png",
    "Nico_knightbot_mech_a.png",
    "Nico_knightbot_mech_w.png",
    "Nico_knightbot_mech_w_broken.png",
    "Nico_knightbot_mech_broken.png",
    "Nico_knightbot_mech_ns.png",
    "Nico_knightbot_mech_h.png",
}
for _, file in ipairs(files) do
    modApi:appendAsset("img/units/player/".. file, artmechPath .. file)
end
local a=ANIMS
    a.Nico_knightbot_mech =a.MechUnit:new{Image="units/player/Nico_knightbot_mech.png", PosX = -19, PosY = -4}
    a.Nico_knightbot_mecha = a.MechUnit:new{Image="units/player/Nico_knightbot_mech_a.png",  PosX = -19, PosY = -4, NumFrames = 4 }
    a.Nico_knightbot_mechw = a.MechUnit:new{Image="units/player/Nico_knightbot_mech_w.png", PosX = -24, PosY = 0}
    a.Nico_knightbot_mech_broken = a.MechUnit:new{Image="units/player/Nico_knightbot_mech_broken.png", PosX = -15, PosY = -7 }
    a.Nico_knightbot_mechw_broken = a.MechUnit:new{Image="units/player/Nico_knightbot_mech_w_broken.png", PosX = -24, PosY = 0 }
    a.Nico_knightbot_mech_ns = a.MechIcon:new{Image="units/player/Nico_knightbot_mech_ns.png"}
--Shield-bot
-- locate our mech assets.
local shieldmechPath = path .."img/units/player/"
-- make a list of our files.
local files = {
    "Nico_shieldbot_mech.png",
    "Nico_shieldbot_mech_a.png",
    "Nico_shieldbot_mech_w.png",
    "Nico_shieldbot_mech_w_broken.png",
    "Nico_shieldbot_mech_broken.png",
    "Nico_shieldbot_mech_ns.png",
    "Nico_shieldbot_mech_h.png",
}
for _, file in ipairs(files) do
    modApi:appendAsset("img/units/player/".. file, shieldmechPath .. file)
end
local a=ANIMS
    a.Nico_shieldbot_mech =a.MechUnit:new{Image="units/player/Nico_shieldbot_mech.png", PosX = -17, PosY = -4}
    a.Nico_shieldbot_mecha = a.MechUnit:new{Image="units/player/Nico_shieldbot_mech_a.png",  PosX = -17, PosY = -4, NumFrames = 4 }
    a.Nico_shieldbot_mechw = a.MechUnit:new{Image="units/player/Nico_shieldbot_mech_w.png", PosX = -16, PosY = -1}
    a.Nico_shieldbot_mech_broken = a.MechUnit:new{Image="units/player/Nico_shieldbot_mech_broken.png", PosX = -17, PosY = 7 }
    a.Nico_shieldbot_mechw_broken = a.MechUnit:new{Image="units/player/Nico_shieldbot_mech_w_broken.png", PosX = -18, PosY = 10 }
    a.Nico_shieldbot_mech_ns = a.MechIcon:new{Image="units/player/Nico_shieldbot_mech_ns.png"}
--Mine-bot
-- locate our mech assets.
local minermechPath = path .."img/units/player/"
-- make a list of our files.
local files = {
    "Nico_minerbot_mech.png",
    "Nico_minerbot_mech_a.png",
    "Nico_minerbot_mech_w.png",
    "Nico_minerbot_mech_w_broken.png",
    "Nico_minerbot_mech_broken.png",
    "Nico_minerbot_mech_ns.png",
    "Nico_minerbot_mech_h.png",
    "Nico_minerbot_mech_death.png",
}
for _, file in ipairs(files) do
    modApi:appendAsset("img/units/player/".. file, minermechPath .. file)
end
local a=ANIMS
    a.Nico_minerbot_mech =a.MechUnit:new{Image="units/player/Nico_minerbot_mech.png", PosX = -20, PosY = 4}
    a.Nico_minerbot_mecha = a.MechUnit:new{Image="units/player/Nico_minerbot_mech_a.png",  PosX = -20, PosY = 4, NumFrames = 4 }
    a.Nico_minerbot_mechd = a.EnemyUnit:new{Image="units/player/Nico_minerbot_mech_death.png",  PosX = -24, PosY = -3, NumFrames = 11, Time = 0.1, Loop = false  }
    a.Nico_minerbot_mechw = a.MechUnit:new{Image="units/player/Nico_minerbot_mech_w.png", PosX = -20, PosY = 10}
    a.Nico_minerbot_mech_broken = a.MechUnit:new{Image="units/player/Nico_minerbot_mech_broken.png", PosX = -12, PosY = 0 }
    a.Nico_minerbot_meche =		a.BaseEmerge:new{Image = "units/player/Nico_minerbot_mech_emerge.png", PosX = -15, PosY = 0, NumFrames = 3 }
    a.Nico_minerbot_mechw_broken = a.MechUnit:new{Image="units/player/Nico_minerbot_mech_w_broken.png", PosX = -20, PosY = 10}
    a.Nico_minerbot_mech_ns = a.MechIcon:new{Image="units/player/Nico_minerbot_mech_ns.png"}
--Juggernaut-bot
-- locate our mech assets.
local juggermechPath = path .."img/units/player/"
-- make a list of our files.
local files = {
    "Nico_juggernautbot_mech.png",
    "Nico_juggernautbot_mech_a.png",
    "Nico_juggernautbot_mech_w.png",
    "Nico_juggernautbot_mech_w_broken.png",
    "Nico_juggernautbot_mech_broken.png",
    "Nico_juggernautbot_mech_ns.png",
    "Nico_juggernautbot_mech_h.png",
}
for _, file in ipairs(files) do
    modApi:appendAsset("img/units/player/".. file, juggermechPath .. file)
end
local a=ANIMS
    a.Nico_juggernautbot_mech =a.MechUnit:new{Image="units/player/Nico_juggernautbot_mech.png", PosX = -24, PosY = -9}
    a.Nico_juggernautbot_mecha = a.MechUnit:new{Image="units/player/Nico_juggernautbot_mech_a.png",  PosX = -24, PosY = -9, NumFrames = 4 }
    a.Nico_juggernautbot_mechw = a.MechUnit:new{Image="units/player/Nico_juggernautbot_mech_w.png", PosX = -17, PosY = 9}
    a.Nico_juggernautbot_mech_broken = a.MechUnit:new{Image="units/player/Nico_juggernautbot_mech_broken.png", PosX = -23, PosY = -8 }
    a.Nico_juggernautbot_mechw_broken = a.MechUnit:new{Image="units/player/Nico_juggernautbot_mech_w_broken.png", PosX = -17, PosY = 9}
    a.Nico_juggernautbot_mech_ns = a.MechIcon:new{Image="units/player/Nico_juggernautbot_mech_ns.png"}
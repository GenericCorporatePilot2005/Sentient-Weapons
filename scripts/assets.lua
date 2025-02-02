local mod = modApi:getCurrentMod()
local path = mod_loader.mods[modApi.currentMod].resourcePath
local mechPath = path .."img/units/player/"
-- make a list of our files.
--SW1
    local files = {
        "Nico_artillerybot_mech.png",
        "Nico_artillerybot_mech_a.png",
        "Nico_artillerybot_mech_w.png",
        "Nico_artillerybot_mech_w_broken.png",
        "Nico_artillerybot_mech_broken.png",
        "Nico_artillerybot_mech_ns.png",
        "Nico_artillerybot_mech_h.png",
        "Nico_laserbot_mech.png",
        "Nico_laserbot_mech_a.png",
        "Nico_laserbot_mech_w.png",
        "Nico_laserbot_mech_w_broken.png",
        "Nico_laserbot_mech_broken.png",
        "Nico_laserbot_mech_ns.png",
        "Nico_laserbot_mech_h.png",
        "Nico_cannonbot_mech.png",
        "Nico_cannonbot_mech_a.png",
        "Nico_cannonbot_mech_w.png",
        "Nico_cannonbot_mech_w_broken.png",
        "Nico_cannonbot_mech_broken.png",
        "Nico_cannonbot_mech_ns.png",
        "Nico_cannonbot_mech_h.png",
    }
    for _, file in ipairs(files) do
        modApi:appendAsset("img/units/player/".. file, mechPath.. "SW1/" .. file)
    end
--SW2
    local files = {
        "Nico_knightbot_mech.png",
        "Nico_knightbot_mech_a.png",
        "Nico_knightbot_mech_w.png",
        "Nico_knightbot_mech_w_broken.png",
        "Nico_knightbot_mech_broken.png",
        "Nico_knightbot_mech_ns.png",
        "Nico_knightbot_mech_h.png",
        "Nico_shieldbot_mech.png",
        "Nico_shieldbot_mech_a.png",
        "Nico_shieldbot_mech_w_broken.png",
        "Nico_shieldbot_mech_broken.png",
        "Nico_shieldbot_mech_ns.png",
        "Nico_shieldbot_mech_h.png",
        "Nico_minerbot_mech.png",
        "Nico_minerbot_mech_a.png",
        "Nico_minerbot_mech_w.png",
        "Nico_minerbot_mech_w_broken.png",
        "Nico_minerbot_mech_broken.png",
        "Nico_minerbot_mech_ns.png",
        "Nico_minerbot_mech_h.png",
        "Nico_minerbot_mech1.png",
        "Nico_minerbot_mech1_a.png",
        "Nico_minerbot_mech1_ns.png",
        "Nico_minerbot_mech1_e.png",
        "Nico_minerbot_mech2.png",
        "Nico_minerbot_mech2_a.png",
        "Nico_minerbot_mech2_ns.png",
        "Nico_minerbot_mech2_e.png",
    }
    for _, file in ipairs(files) do
        modApi:appendAsset("img/units/player/".. file, mechPath.. "SW2/" .. file)
    end
--SW3
    local files = {
        "Nico_juggernautbot_mech.png",
        "Nico_juggernautbot_mech_a.png",
        "Nico_juggernautbot_mech_w.png",
        "Nico_juggernautbot_mech_w_broken.png",
        "Nico_juggernautbot_mech_broken.png",
        "Nico_juggernautbot_mech_ns.png",
        "Nico_juggernautbot_mech_h.png",
        "Nico_hulkbot_mech.png",
        "Nico_hulkbot_mech_a.png",
        "Nico_hulkbot_mech_w.png",
        "Nico_hulkbot_mech_w_broken.png",
        "Nico_hulkbot_mech_broken.png",
        "Nico_hulkbot_mech_ns.png",
        "Nico_hulkbot_mech_h.png",
        "Nico_cannonbot_deploy.png",
        "Nico_cannonbot_deploy_a.png",
        "Nico_cannonbot_deploy_ns.png",
    }
    for _, file in ipairs(files) do
        modApi:appendAsset("img/units/player/".. file, mechPath.. "SW3/" .. file)
    end
--SWBB
    local files = {
        "Nico_artilleryboom_mech.png",
        "Nico_artilleryboom_mech_a.png",
        "Nico_artilleryboom_mech_w.png",
        "Nico_artilleryboom_mech_w_broken.png",
        "Nico_artilleryboom_mech_broken.png",
        "Nico_artilleryboom_mech_ns.png",
        "Nico_artilleryboom_mech_h.png",
        "Nico_laserboom_mech.png",
        "Nico_laserboom_mech_a.png",
        "Nico_laserboom_mech_w.png",
        "Nico_laserboom_mech_w_broken.png",
        "Nico_laserboom_mech_broken.png",
        "Nico_laserboom_mech_ns.png",
        "Nico_laserboom_mech_h.png",
        "Nico_cannonboom_mech.png",
        "Nico_cannonboom_mech_a.png",
        "Nico_cannonboom_mech_w.png",
        "Nico_cannonboom_mech_w_broken.png",
        "Nico_cannonboom_mech_broken.png",
        "Nico_cannonboom_mech_ns.png",
        "Nico_cannonboom_mech_h.png",
    }
    for _, file in ipairs(files) do
        modApi:appendAsset("img/units/player/".. file, mechPath.. "SWBB/" .. file)
    end
--SWBloom
    local files = {
        "Nico_Laser_Bloom.png",
        "Nico_Laser_Bloom_ns.png",
        "Nico_Laser_Bloom_a.png",
        "Nico_Laser_Bloom_e.png",
        "Nico_Artillery_Bloom.png",
        "Nico_Artillery_Bloom_ns.png",
        "Nico_Artillery_Bloom_a.png",
        "Nico_Artillery_Bloom_e.png",
        "Nico_Cannon_Bloom.png",
        "Nico_Cannon_Bloom_ns.png",
        "Nico_Cannon_Bloom_a.png",
        "Nico_Cannon_Bloom_e.png",
        "Nico_Copter_Bloom.png",
        "Nico_Copter_Bloom_ns.png",
        "Nico_Copter_Bloom_a.png",
        "Nico_Copter_Bloom_d.png",
    }
    for _, file in ipairs(files) do
        modApi:appendAsset("img/units/player/".. file, mechPath.. "SWBloom/" .. file)
    end
local a=ANIMS
    --Sentient Weapons 1
        --Artillery-Bot
            a.Nico_artillerybot_mech =a.MechUnit:new{Image="units/player/Nico_artillerybot_mech.png", PosX = -18, PosY = -9}
            a.Nico_artillerybot_mecha = a.MechUnit:new{Image="units/player/Nico_artillerybot_mech_a.png",  PosX = -18, PosY = -9, NumFrames = 4 }
            a.Nico_artillerybot_mechw = a.MechUnit:new{Image="units/player/Nico_artillerybot_mech_w.png", PosX = -18, PosY = -2}
            a.Nico_artillerybot_mech_broken = a.MechUnit:new{Image="units/player/Nico_artillerybot_mech_broken.png", PosX = -18, PosY = -9 }
            a.Nico_artillerybot_mechw_broken = a.MechUnit:new{Image="units/player/Nico_artillerybot_mech_w_broken.png", PosX = -18, PosY = -2 }
            a.Nico_artillerybot_mech_ns = a.MechIcon:new{Image="units/player/Nico_artillerybot_mech_ns.png"}
        --Laser-Bot
            a.Nico_laserbot_mech =a.MechUnit:new{Image="units/player/Nico_laserbot_mech.png", PosX = -15, PosY = -2}
            a.Nico_laserbot_mecha = a.MechUnit:new{Image="units/player/Nico_laserbot_mech_a.png",  PosX = -15, PosY = -2, NumFrames = 4 }
            a.Nico_laserbot_mechw = a.MechUnit:new{Image="units/player/Nico_laserbot_mech_w.png", PosX = -15, PosY = 4}
            a.Nico_laserbot_mech_broken = a.MechUnit:new{Image="units/player/Nico_laserbot_mech_broken.png", PosX = -15, PosY = -2 }
            a.Nico_laserbot_mechw_broken = a.MechUnit:new{Image="units/player/Nico_laserbot_mech_w_broken.png", PosX = -15, PosY = 4 }
            a.Nico_laserbot_mech_ns = a.MechIcon:new{Image="units/player/Nico_laserbot_mech_ns.png"}
        --Cannon-Bot
            a.Nico_cannonbot_mech =a.MechUnit:new{Image="units/player/Nico_cannonbot_mech.png", PosX = -20, PosY = -4}
            a.Nico_cannonbot_mecha = a.MechUnit:new{Image="units/player/Nico_cannonbot_mech_a.png",  PosX = -20, PosY = -4, NumFrames = 3 }
            a.Nico_cannonbot_mechw = a.MechUnit:new{Image="units/player/Nico_cannonbot_mech_w.png", PosX = -17, PosY = 2}
            a.Nico_cannonbot_mech_broken = a.MechUnit:new{Image="units/player/Nico_cannonbot_mech_broken.png", PosX = -20, PosY = -4 }
            a.Nico_cannonbot_mechw_broken = a.MechUnit:new{Image="units/player/Nico_cannonbot_mech_w_broken.png", PosX = -20, PosY = 2 }
            a.Nico_cannonbot_mech_ns = a.MechIcon:new{Image="units/player/Nico_cannonbot_mech_ns.png"}
    --Sentient Weapons 2
        --Knight-Bot
            a.Nico_knightbot_mech =a.MechUnit:new{Image="units/player/Nico_knightbot_mech.png", PosX = -19, PosY = -4}
            a.Nico_knightbot_mecha = a.MechUnit:new{Image="units/player/Nico_knightbot_mech_a.png",  PosX = -19, PosY = -4, NumFrames = 4 }
            a.Nico_knightbot_mechw = a.MechUnit:new{Image="units/player/Nico_knightbot_mech_w.png", PosX = -24, PosY = 0}
            a.Nico_knightbot_mech_broken = a.MechUnit:new{Image="units/player/Nico_knightbot_mech_broken.png", PosX = -15, PosY = 0 }
            a.Nico_knightbot_mechw_broken = a.MechUnit:new{Image="units/player/Nico_knightbot_mech_w_broken.png", PosX = -24, PosY = 0 }
            a.Nico_knightbot_mech_ns = a.MechIcon:new{Image="units/player/Nico_knightbot_mech_ns.png"}
        --Shield-Bot
            a.Nico_shieldbot_mech =a.MechUnit:new{Image="units/player/Nico_shieldbot_mech.png", PosX = -17, PosY = -4}
            a.Nico_shieldbot_mecha = a.MechUnit:new{Image="units/player/Nico_shieldbot_mech_a.png",  PosX = -17, PosY = -4, NumFrames = 4 }
            a.Nico_shieldbot_mechw = a.MechUnit:new{Image="units/player/Nico_shieldbot_mech_w.png", PosX = -16, PosY = -1}
            a.Nico_shieldbot_mech_broken = a.MechUnit:new{Image="units/player/Nico_shieldbot_mech_broken.png", PosX = -17, PosY = 7 }
            a.Nico_shieldbot_mechw_broken = a.MechUnit:new{Image="units/player/Nico_shieldbot_mech_w_broken.png", PosX = -18, PosY = 10 }
            a.Nico_shieldbot_mech_ns = a.MechIcon:new{Image="units/player/Nico_shieldbot_mech_ns.png"}
        --Mine-Bot
            a.Nico_minerbot_mech =a.MechUnit:new{Image="units/player/Nico_minerbot_mech.png", PosX = -20, PosY = 4}
            a.Nico_minerbot_mecha = a.MechUnit:new{Image="units/player/Nico_minerbot_mech_a.png",  PosX = -20, PosY = 4, NumFrames = 4 }
            a.Nico_minerbot_mechw = a.MechUnit:new{Image="units/player/Nico_minerbot_mech_w.png", PosX = -20, PosY = 10}
            a.Nico_minerbot_mech_broken = a.MechUnit:new{Image="units/player/Nico_minerbot_mech_broken.png", PosX = -12, PosY = 0 }
            a.Nico_minerbot_mechw_broken = a.MechUnit:new{Image="units/player/Nico_minerbot_mech_w_broken.png", PosX = -20, PosY = 10}
            a.Nico_minerbot_mech_ns = a.MechIcon:new{Image="units/player/Nico_minerbot_mech_ns.png"}
        --Mine-Bot-Deploy 1
            a.Nico_minerbot_mech1 =a.MechUnit:new{Image="units/player/Nico_minerbot_mech1.png", PosX = -20, PosY = 4}
            a.Nico_minerbot_mech1a = a.MechUnit:new{Image="units/player/Nico_minerbot_mech1_a.png",  PosX = -20, PosY = 4, NumFrames = 4 }
            a.Nico_minerbot_mech1e = a.Nico_minerbot_mech1a:new{Image="units/player/Nico_minerbot_mech1_e.png", NumFrames = 6, Time = 0.1, Loop = false }
            a.Nico_minerbot_mech1_ns = a.MechIcon:new{Image="units/player/Nico_minerbot_mech1_ns.png"}
        --Mine-Bot-Deploy 2
            a.Nico_minerbot_mech2 =a.MechUnit:new{Image="units/player/Nico_minerbot_mech2.png", PosX = -20, PosY = 4}
            a.Nico_minerbot_mech2a = a.MechUnit:new{Image="units/player/Nico_minerbot_mech2_a.png",  PosX = -20, PosY = 4, NumFrames = 4 }
            a.Nico_minerbot_mech2e = a.Nico_minerbot_mech2a:new{Image="units/player/Nico_minerbot_mech2_e.png", NumFrames = 6, Time = 0.1, Loop = false }
            a.Nico_minerbot_mech2_ns = a.MechIcon:new{Image="units/player/Nico_minerbot_mech2_ns.png"}
    --Sentient Weapons 3
        --Juggernaut-Bot
            a.Nico_juggernautbot_mech =a.MechUnit:new{Image="units/player/Nico_juggernautbot_mech.png", PosX = -24, PosY = -9}
            a.Nico_juggernautbot_mecha = a.MechUnit:new{Image="units/player/Nico_juggernautbot_mech_a.png",  PosX = -24, PosY = -9, NumFrames = 4 }
            a.Nico_juggernautbot_mechw = a.MechUnit:new{Image="units/player/Nico_juggernautbot_mech_w.png", PosX = -17, PosY = 9}
            a.Nico_juggernautbot_mech_broken = a.MechUnit:new{Image="units/player/Nico_juggernautbot_mech_broken.png", PosX = -23, PosY = -8 }
            a.Nico_juggernautbot_mechw_broken = a.MechUnit:new{Image="units/player/Nico_juggernautbot_mech_w_broken.png", PosX = -17, PosY = 9}
            a.Nico_juggernautbot_mech_ns = a.MechIcon:new{Image="units/player/Nico_juggernautbot_mech_ns.png"}
        --Cryo-Hulk
            a.Nico_hulkbot_mech =a.MechUnit:new{Image="units/player/Nico_hulkbot_mech.png", PosX = -20, PosY = -10 }
            a.Nico_hulkbot_mecha = a.MechUnit:new{Image="units/player/Nico_hulkbot_mech_a.png",  PosX = -20, PosY = -10, NumFrames = 4 }
            a.Nico_hulkbot_mechw = a.MechUnit:new{Image="units/player/Nico_hulkbot_mech_w.png", PosX = -20, PosY = 0 }
            a.Nico_hulkbot_mech_broken = a.MechUnit:new{Image="units/player/Nico_hulkbot_mech_broken.png", PosX = -20, PosY = -10 }
            a.Nico_hulkbot_mechw_broken = a.MechUnit:new{Image="units/player/Nico_hulkbot_mech_w_broken.png", PosX = -20, PosY = 0 }
            a.Nico_hulkbot_mech_ns = a.MechIcon:new{Image="units/player/Nico_hulkbot_mech_ns.png"}
        --Cannon-Bot-Deploy
            a.Nico_cannonbot_deploy =a.MechUnit:new{Image="units/player/Nico_cannonbot_deploy.png", PosX = -20, PosY = -4}
            a.Nico_cannonbot_deploya = a.MechUnit:new{Image="units/player/Nico_cannonbot_deploy_a.png",  PosX = -20, PosY = -4, NumFrames = 3 }
            a.Nico_cannonbot_deploy_ns = a.MechIcon:new{Image="units/player/Nico_cannonbot_deploy_ns.png"}
    --Boom Bots
        --Boom-Artillery
            a.Nico_artilleryboom_mech =a.MechUnit:new{Image="units/player/Nico_artilleryboom_mech.png", PosX = -18, PosY = -9}
            a.Nico_artilleryboom_mecha = a.MechUnit:new{Image="units/player/Nico_artilleryboom_mech_a.png",  PosX = -18, PosY = -9, NumFrames = 4 }
            a.Nico_artilleryboom_mechw = a.MechUnit:new{Image="units/player/Nico_artilleryboom_mech_w.png", PosX = -18, PosY = -2}
            a.Nico_artilleryboom_mech_broken = a.MechUnit:new{Image="units/player/Nico_artilleryboom_mech_broken.png", PosX = -18, PosY = -9 }
            a.Nico_artilleryboom_mechw_broken = a.MechUnit:new{Image="units/player/Nico_artilleryboom_mech_w_broken.png", PosX = -18, PosY = -2 }
            a.Nico_artilleryboom_mech_ns = a.MechIcon:new{Image="units/player/Nico_artilleryboom_mech_ns.png"}
        --Boom-Laser
            a.Nico_laserboom_mech =a.MechUnit:new{Image="units/player/Nico_laserboom_mech.png", PosX = -15, PosY = -2}
            a.Nico_laserboom_mecha = a.MechUnit:new{Image="units/player/Nico_laserboom_mech_a.png",  PosX = -15, PosY = -2, NumFrames = 4 }
            a.Nico_laserboom_mechw = a.MechUnit:new{Image="units/player/Nico_laserboom_mech_w.png", PosX = -15, PosY = 4}
            a.Nico_laserboom_mech_broken = a.MechUnit:new{Image="units/player/Nico_laserboom_mech_broken.png", PosX = -15, PosY = -2 }
            a.Nico_laserboom_mechw_broken = a.MechUnit:new{Image="units/player/Nico_laserboom_mech_w_broken.png", PosX = -15, PosY = 4 }
            a.Nico_laserboom_mech_ns = a.MechIcon:new{Image="units/player/Nico_laserboom_mech_ns.png"}
        --Boom-Cannon
            a.Nico_cannonboom_mech =a.MechUnit:new{Image="units/player/Nico_cannonboom_mech.png", PosX = -20, PosY = -4}
            a.Nico_cannonboom_mecha = a.MechUnit:new{Image="units/player/Nico_cannonboom_mech_a.png",  PosX = -20, PosY = -4, NumFrames = 3 }
            a.Nico_cannonboom_mechw = a.MechUnit:new{Image="units/player/Nico_cannonboom_mech_w.png", PosX = -17, PosY = 2}
            a.Nico_cannonboom_mech_broken = a.MechUnit:new{Image="units/player/Nico_cannonboom_mech_broken.png", PosX = -20, PosY = -4 }
            a.Nico_cannonboom_mechw_broken = a.MechUnit:new{Image="units/player/Nico_cannonboom_mech_w_broken.png", PosX = -20, PosY = 2 }
            a.Nico_cannonboom_mech_ns = a.MechIcon:new{Image="units/player/Nico_cannonboom_mech_ns.png"}
    --Bloom Bots
        --Bloom Laser
            a.Nico_Laser_Bloom=a.MechUnit:new{Image="units/player/Nico_Laser_Bloom.png", PosX = -13, PosY = 3}
            a.Nico_Laser_Bloom_ns=a.MechIcon:new{Image="units/player/Nico_Laser_Bloom_ns.png"}
            a.Nico_Laser_Blooma= a.MechUnit:new{Image="units/player/Nico_Laser_Bloom_a.png",  PosX = -13, PosY = 3, NumFrames = 20 }
            a.Nico_Laser_Bloome=a.BaseEmerge:new{Image="units/player/Nico_Laser_Bloom_e.png",  PosX = -13, PosY = 4, NumFrames = 10, Time = .14, Loop = false  }
        --Bloom Cannon
            a.Nico_Cannon_Bloom=a.MechUnit:new{Image="units/player/Nico_Cannon_Bloom.png", PosX = -13, PosY = 3}
            a.Nico_Cannon_Bloom_ns=a.MechIcon:new{Image="units/player/Nico_Cannon_Bloom_ns.png"}
            a.Nico_Cannon_Blooma= a.MechUnit:new{Image="units/player/Nico_Cannon_Bloom_a.png",  PosX = -13, PosY = 3, NumFrames = 4 }
            a.Nico_Cannon_Bloome=a.BaseEmerge:new{Image="units/player/Nico_Cannon_Bloom_e.png",  PosX = -13, PosY = 4, NumFrames = 10, Time = .14, Loop = false  }
        --Bloom Artillery
            a.Nico_Artillery_Bloom=a.MechUnit:new{Image="units/player/Nico_Artillery_Bloom.png", PosX = -13, PosY = 3}
            a.Nico_Artillery_Bloom_ns=a.MechIcon:new{Image="units/player/Nico_Artillery_Bloom_ns.png"}
            a.Nico_Artillery_Blooma= a.MechUnit:new{Image="units/player/Nico_Artillery_Bloom_a.png",  PosX = -13, PosY = 3, NumFrames = 4 }
            a.Nico_Artillery_Bloome=a.BaseEmerge:new{Image="units/player/Nico_Artillery_Bloom_e.png",  PosX = -13, PosY = 4, NumFrames = 10, Time = .14, Loop = false  }
        --Bloom Copter
            a.Nico_Copter_Bloom=a.MechUnit:new{Image="units/player/Nico_Copter_Bloom.png", PosX = -15, PosY = -15}
            a.Nico_Copter_Bloom_ns=a.MechIcon:new{Image="units/player/Nico_Copter_Bloom_ns.png"}
            a.Nico_Copter_Blooma= a.Nico_Copter_Bloom:new{Image="units/player/Nico_Copter_Bloom_a.png", NumFrames = 4 }
            a.Nico_Copter_Bloomd=a.Nico_Copter_Bloom:new{Image="units/player/Nico_Copter_Bloom_d.png",  NumFrames = 10, Time = .14, Loop = false}
--weapon icons

    local files = {
        "Nico_fire_cancel.png",
        "Nico_fire_cancel_off.png",
        "Nico_fire_cancel_off_B.png",
    }
    for _, file in ipairs(files) do
        modApi:appendAsset("img/combat/icons/".. file, path.. "img/combat/icons/" .. file)
        Location["combat/icons/"..file] = Point(-12,8)
    end
    modApi:copyAsset("img/combat/icons/icon_ice_glow.png","img/combat/icons/Nico_icon_ice_glow.png")
	Location["combat/icons/Nico_icon_ice_glow.png"] = Point(-10,8)
    modApi:appendAsset("img/combat/icons/Nico_shield_explode_glow.png", path.."img/combat/icons/Nico_shield_explode_glow.png")
    Location["combat/icons/Nico_shield_explode_glow.png"] = Point(-16,8)
    modApi:appendAsset("img/combat/icons/Nico_icon_shield+1.png", path.."img/combat/icons/Nico_icon_shield+1.png")
    Location["combat/icons/Nico_icon_shield+1.png"] = Point(-18,5)
    modApi:appendAsset("img/combat/icons/Nico_icon_shield+2.png", path.."img/combat/icons/Nico_icon_shield+2.png")
    Location["combat/icons/Nico_icon_shield+2.png"] = Point(-18,5)
    modApi:appendAsset("img/combat/icons/Nico_icon_water_kill.png", path.."img/combat/icons/Nico_icon_water_kill.png")
    Location["combat/icons/Nico_icon_water_kill.png"] = Point(-16,9)
    modApi:appendAsset("img/combat/icons/Nico_icon_acid_kill.png", path.."img/combat/icons/Nico_icon_acid_kill.png")
    Location["combat/icons/Nico_icon_acid_kill.png"] = Point(-16,9)
    modApi:appendAsset("img/combat/icons/Nico_icon_ground.png", path.."img/combat/icons/Nico_icon_ground.png")
    Location["combat/icons/Nico_icon_ground.png"] = Point(-13,8)
--mech weapons
    local files = {
        "Nico_laserbot.png",
        "Nico_knightbot.png",
        "Nico_minerbot.png",
        "Nico_minebot.png",
        "Nico_shieldbot.png",
        "Nico_leaderbot.png",
        "Nico_hulkbot.png",
        "Nico_juggernautbot.png",
        "Nico_cannondeploy.png",
        "Nico_cannonboom.png",
        "Nico_laserboom.png",
        "Nico_bloom_artillery.png",
        "Nico_bloom_laser.png",
        "Nico_bloom_cannon.png",
        "Nico_bloom_copter.png",
    }
    for _, file in ipairs(files) do
        modApi:appendAsset("img/weapons/"..file,path.."img/weapons/"..file)
    end
    
--Bot Leader's skill replacement
    modApi:appendAsset("img/weapons/Nico_Bot_Repair.png", path.."img/weapons/Nico_Bot_Repair.png")
    modApi:appendAsset("img/weapons/Nico_Bot_Repair_frozen.png", path.."img/weapons/Nico_Bot_Repair_frozen.png")

    modApi:appendAsset("img/combat/icons/Nico_icon_shield+10.png", path.."img/combat/icons/Nico_icon_shield+10.png")
    Location["combat/icons/Nico_icon_shield+10.png"] = Point(-16,8)
--Traits
    modApi:appendAsset("img/combat/icons/icon_Nico_zenith_shield.png", path.."img/combat/icons/icon_Nico_zenith_shield.png")--image of the trait
    modApi:appendAsset("img/combat/icons/icon_Nico_zenith_mine.png", path.."img/combat/icons/icon_Nico_zenith_mine.png")--image of the trait
    modApi:copyAsset("img/combat/icons/icon_shield_heal.png","img/combat/icons/icon_Nico_shield_heal.png")--image of the trait
--Effects
    modApi:appendAsset("img/effects/shotup_deploymine.png", path.. "img/effects/shotup_deploymine.png")
    modApi:appendAsset("img/effects/shotup_bloom_artillery.png", path.. "img/effects/shotup_bloom_artillery.png")
    modApi:appendAsset("img/effects/Bloom_Bot's_petal.png", path.. "img/effects/Bloom_Bot's_petal.png")
    modApi:appendAsset("img/effects/Copter_Bloom_Bot's_petal.png", path.. "img/effects/Copter_Bloom_Bot's_petal.png")
    modApi:appendAsset("img/effects/shotup_Nico_Copter_Bloom.png", path.. "img/effects/shotup_Nico_Copter_Bloom.png")
    modApi:appendAsset("img/effects/shield_bot_pulse.png", path.. "img/effects/shield_bot_pulse.png")
--Mines
    modApi:appendAsset("img/combat/Nico_freeze_mine.png", path.."img/combat/Nico_freeze_mine.png")
    Location["combat/Nico_freeze_mine.png"] = Point(-14,2)
--portraits
    local files = {
        "pilots/Pilot_Nico_artillerybot_mech.png",
        "pilots/Pilot_Nico_laserbot_mech.png",
        "pilots/Pilot_Nico_cannonbot_mech.png",
        "pilots/Pilot_Nico_knightbot_mech.png",
        "pilots/Pilot_Nico_shieldbot_mech.png",
        "pilots/Pilot_Nico_minerbot_mech.png",
        "pilots/Pilot_Nico_laserboom_mech.png",
        "pilots/Pilot_Nico_cannonboom_mech.png",
        "pilots/Pilot_Nico_artilleryboom_mech.png",
        "pilots/Pilot_Nico_juggernautbot_mech.png",
        "pilots/Pilot_Nico_hulkbot_mech.png",
        "pilots/Pilot_Nico_botleader_mech.png",
        "npcs/Pilot_Nico_minerbot_mech_MK1.png",
        "npcs/Pilot_Nico_minerbot_mech_MK2.png",
        "npcs/Pilot_Nico_cannondeploy.png",
        "npcs/Pilot_Nico_laserbloom.png",
        "npcs/Pilot_Nico_laserbloom_blink.png",
        "npcs/Pilot_Nico_cannonbloom.png",
        "npcs/Pilot_Nico_artillerybloom.png",
        "npcs/Pilot_Nico_copterbloom.png",
    }
    for _, file in ipairs(files) do
        modApi:appendAsset("img/portraits/".. file, path.."img/portraits/".. file)
    end
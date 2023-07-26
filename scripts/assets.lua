local mod = modApi:getCurrentMod()
local path = mod_loader.mods[modApi.currentMod].resourcePath
modApi:appendAsset("img/units/player/BloomBotPrototype.png",path.."img/units/player/BloomBotPrototype.png")
local mechPath = path .."img/units/player/"
-- make a list of our files.
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
    "Nico_cannonbot_mech_death.png",
    "Nico_knightbot_mech.png",
    "Nico_knightbot_mech_a.png",
    "Nico_knightbot_mech_w.png",
    "Nico_knightbot_mech_w_broken.png",
    "Nico_knightbot_mech_broken.png",
    "Nico_knightbot_mech_ns.png",
    "Nico_knightbot_mech_h.png",
    "Nico_shieldbot_mech.png",
    "Nico_shieldbot_mech_a.png",
    "Nico_shieldbot_mech_w.png",
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
    "Nico_minerbot_mech_death.png",
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
}
for _, file in ipairs(files) do
    modApi:appendAsset("img/units/player/".. file, mechPath .. file)
end
local a=ANIMS
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
        a.Nico_cannonbot_mechd = a.EnemyUnit:new{Image="units/player/Nico_cannonbot_mech_death.png",  PosX = -30, PosY = -4, NumFrames = 10, Time = 0.1, Loop = false  }
        a.Nico_cannonbot_mech_broken = a.MechUnit:new{Image="units/player/Nico_cannonbot_mech_broken.png", PosX = -20, PosY = -4 }
        a.Nico_cannonbot_mechw_broken = a.MechUnit:new{Image="units/player/Nico_cannonbot_mech_w_broken.png", PosX = -20, PosY = 2 }
        a.Nico_cannonbot_mech_ns = a.MechIcon:new{Image="units/player/Nico_cannonbot_mech_ns.png"}
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
        a.Nico_minerbot_mechd = a.EnemyUnit:new{Image="units/player/Nico_minerbot_mech_death.png",  PosX = -24, PosY = -3, NumFrames = 11, Time = 0.1, Loop = false  }
        a.Nico_minerbot_mechw = a.MechUnit:new{Image="units/player/Nico_minerbot_mech_w.png", PosX = -20, PosY = 10}
        a.Nico_minerbot_mech_broken = a.MechUnit:new{Image="units/player/Nico_minerbot_mech_broken.png", PosX = -12, PosY = 0 }
        a.Nico_minerbot_mechw_broken = a.MechUnit:new{Image="units/player/Nico_minerbot_mech_w_broken.png", PosX = -20, PosY = 10}
        a.Nico_minerbot_mech_ns = a.MechIcon:new{Image="units/player/Nico_minerbot_mech_ns.png"}
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
--weapon icons

    local files = {
        "Nico_fire_cancel.png",
        "Nico_fire_cancel_off.png",
    }
    for _, file in ipairs(files) do
        modApi:appendAsset("img/weapons/".. file, path.. "img/weapons/" .. file)
        Location["img/weapons/"..file] = Point(-12,8)
    end
    modApi:appendAsset("img/effects/Nico_icon_ice_glow.png", path.."img/weapons/Nico_icon_ice_glow.png")
	Location["effects/Nico_icon_ice_glow.png"] = Point(-10,8)
    modApi:appendAsset("img/weapons/Nico_shield_explode_glow.png", path.."img/weapons/Nico_shield_explode_glow.png")
    Location["weapons/Nico_shield_explode_glow.png"] = Point(-16,8)
--mech weapons
    modApi:appendAsset("img/weapons/Nico_laserbot.png", path .."img/weapons/Nico_laserbot.png")
    modApi:appendAsset("img/weapons/Nico_knightbot.png", path .."img/weapons/Nico_knightbot.png")
    modApi:appendAsset("img/weapons/Nico_minerbot.png", path .."img/weapons/Nico_minerbot.png")
    modApi:appendAsset("img/weapons/Nico_minebot.png", path .."img/weapons/Nico_minebot.png")
    modApi:appendAsset("img/weapons/Nico_shieldbot.png", path .."img/weapons/Nico_shieldbot.png")
    modApi:appendAsset("img/weapons/Nico_leaderbot.png", path .."img/weapons/Nico_leaderbot.png")
    modApi:appendAsset("img/weapons/Nico_hulkbot.png", path .."img/weapons/Nico_hulkbot.png")
    modApi:appendAsset("img/weapons/Nico_cannondeploy.png", path .."img/weapons/Nico_cannondeploy.png")
    modApi:appendAsset("img/weapons/Nico_cannonboom.png", path .."img/weapons/Nico_cannonboom.png")
    modApi:appendAsset("img/weapons/Nico_laserboom.png", path .."img/weapons/Nico_laserboom.png")
    
--Bot Leader's skill replacement
    modApi:appendAsset("img/weapons/Nico_Bot_Repair.png", path.."img/weapons/Nico_Bot_Repair.png")
    modApi:appendAsset("img/weapons/Nico_Bot_Repair_frozen.png", path.."img/weapons/Nico_Bot_Repair_frozen.png")

    modApi:appendAsset("img/effects/Nico_icon_shield+10.png", path.."img/weapons/Nico_icon_shield+10.png")
    Location["effects/Nico_icon_shield+10.png"] = Point(-16,8)
--Traits
    modApi:appendAsset("img/icon_Nico_zenith_shield.png", path.."img/icon_Nico_zenith_shield.png")--image of the trait
    modApi:appendAsset("img/icon_Nico_shield_heal.png", path.."img/icon_Nico_shield_heal.png")--image of the trait
--Effects
    modApi:appendAsset("img/effects/shotup_deploymine.png", path.. "img/effects/shotup_deploymine.png")
    modApi:appendAsset("img/effects/shield_bot_pulse.png", path.. "img/effects/shield_bot_pulse.png")
--portraits
    modApi:appendAsset("img/portraits/pilots/Pilot_Nico_artillerybot_mech.png", path .."img/portraits/Pilot_Nico_artillerybot_mech.png")
    modApi:appendAsset("img/portraits/pilots/Pilot_Nico_laserbot_mech.png", path .."img/portraits/Pilot_Nico_laserbot_mech.png")
    modApi:appendAsset("img/portraits/pilots/Pilot_Nico_cannonbot_mech.png", path .."img/portraits/Pilot_Nico_cannonbot_mech.png")
    modApi:appendAsset("img/portraits/pilots/Pilot_Nico_knightbot_mech.png", path .."img/portraits/Pilot_Nico_knightbot_mech.png")
    modApi:appendAsset("img/portraits/pilots/Pilot_Nico_shieldbot_mech.png", path .."img/portraits/Pilot_Nico_shieldbot_mech.png")
    modApi:appendAsset("img/portraits/pilots/Pilot_Nico_minerbot_mech.png", path .."img/portraits/Pilot_Nico_minerbot_mech.png")
    modApi:appendAsset("img/portraits/pilots/Pilot_Nico_artilleryboom_mech.png", path .."img/portraits/Pilot_Nico_artilleryboom_mech.png")
    modApi:appendAsset("img/portraits/pilots/Pilot_Nico_laserboom_mech.png", path .."img/portraits/Pilot_Nico_laserboom_mech.png")
    modApi:appendAsset("img/portraits/pilots/Pilot_Nico_cannonboom_mech.png", path .."img/portraits/Pilot_Nico_cannonboom_mech.png")
    modApi:appendAsset("img/portraits/pilots/Pilot_Nico_juggernautbot_mech.png", path .."img/portraits/Pilot_Nico_juggernautbot_mech.png")
    modApi:appendAsset("img/portraits/pilots/Pilot_Nico_botleader_mech.png", path .."img/portraits/Pilot_Nico_botleader_mech.png")
    modApi:appendAsset("img/portraits/pilots/Pilot_Nico_hulkbot_mech.png", path .."img/portraits/Pilot_Nico_hulkbot_mech.png")
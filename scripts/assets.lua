local mod = modApi:getCurrentMod()
local path = mod_loader.mods[modApi.currentMod].resourcePath
local mechPath = "img/units/player/"
-- make a list of our files.
local files1 = {
	"Nico_artillerybot_mech",
	"Nico_laserbot_mech",
	"Nico_cannonbot_mech",
	"Nico_knightbot_mech",
    "Nico_shieldbot_mech",
	"Nico_minerbot_mech",
	"Nico_juggernautbot_mech",
	"Nico_hulkbot_mech",
	"Nico_artilleryboom_mech",
	"Nico_laserboom_mech",
	"Nico_cannonboom_mech",
}
local files2 = {
	".png",
	"_a.png",
	"_w.png",
	"_w_broken.png",
	"_broken.png",
	"_ns.png",
	"_h.png",
}
local squadPath = "SW1/"
for _, file1 in ipairs(files1) do
    if file1 == "Nico_knightbot_mech" then squadPath = "SW2/" end
    if file1 == "Nico_juggernautbot_mech" then squadPath = "SW3/" end
    if file1 == "Nico_artilleryboom_mech" then squadPath = "SWBB/" end
	for _, file2 in ipairs(files2) do
		if not (file1 == "Nico_shieldbot_mech" and file2 == "_w.png") then
			modApi:appendAsset(mechPath.. file1..file2,path .. mechPath..squadPath .. file1..file2)
		end
	end
end
local files1 = {
	"Nico_minerbot_mech1",
	"Nico_minerbot_mech2",
	"Nico_cannonbot_deploy",
	"Nico_Laser_Bloom",
	"Nico_Artillery_Bloom",
	"Nico_Cannon_Bloom",
	"Nico_Copter_Bloom",
}
local files2 = {
	".png",
	"_a.png",
	"_ns.png",
	"_e.png",
}
local squadPath = "SW2/"
for _, file1 in ipairs(files1) do
    if file1 == "Nico_cannonbot_deploy" then squadPath = "SW3/" end
    if file1 == "Nico_Laser_Bloom" then squadPath = "SWBloom/" end
	for _, file2 in ipairs(files2) do
        if not (file1 == "Nico_cannonbot_deploy" and file2 == "_e.png") and not (file1 == "Nico_Copter_Bloom" and file2 == "_e.png") then
			modApi:appendAsset(mechPath.. file1..file2,path .. mechPath..squadPath .. file1..file2)
		end
        if file2 == "Nico_Copter_Bloom" and file2 == "_e.png" then modApi:appendAsset(mechPath.. file1..file2,path .. mechPath..squadPath .. file1.."_d.png") end
	end
end
local a=ANIMS
    --Sentient Weapons 1
        --Artillery-Bot
            a.Nico_artillerybot_mech =a.MechUnit:new{Image="units/player/Nico_artillerybot_mech.png", PosX = -18, PosY = -9}
            a.Nico_artillerybot_mecha = a.Nico_artillerybot_mech:new{Image="units/player/Nico_artillerybot_mech_a.png", NumFrames = 4 }
            a.Nico_artillerybot_mechw = a.MechUnit:new{Image="units/player/Nico_artillerybot_mech_w.png", PosX = -18, PosY = -2}
            a.Nico_artillerybot_mech_broken = a.Nico_artillerybot_mech:new{Image="units/player/Nico_artillerybot_mech_broken.png"}
            a.Nico_artillerybot_mechw_broken = a.Nico_artillerybot_mechw:new{Image="units/player/Nico_artillerybot_mech_w_broken.png"}
            a.Nico_artillerybot_mech_ns = a.MechIcon:new{Image="units/player/Nico_artillerybot_mech_ns.png"}
        --Laser-Bot
            a.Nico_laserbot_mech =a.MechUnit:new{Image="units/player/Nico_laserbot_mech.png", PosX = -15, PosY = -2}
            a.Nico_laserbot_mecha = a.Nico_laserbot_mech:new{Image="units/player/Nico_laserbot_mech_a.png",NumFrames = 4 }
            a.Nico_laserbot_mechw = a.MechUnit:new{Image="units/player/Nico_laserbot_mech_w.png", PosX = -15, PosY = 4}
            a.Nico_laserbot_mech_broken = a.Nico_laserbot_mech:new{Image="units/player/Nico_laserbot_mech_broken.png"}
            a.Nico_laserbot_mechw_broken = a.Nico_laserbot_mechw:new{Image="units/player/Nico_laserbot_mech_w_broken.png"}
            a.Nico_laserbot_mech_ns = a.MechIcon:new{Image="units/player/Nico_laserbot_mech_ns.png"}
        --Cannon-Bot
            a.Nico_cannonbot_mech =a.MechUnit:new{Image="units/player/Nico_cannonbot_mech.png", PosX = -20, PosY = -4}
            a.Nico_cannonbot_mecha = a.Nico_cannonbot_mech:new{Image="units/player/Nico_cannonbot_mech_a.png",NumFrames = 3 }
            a.Nico_cannonbot_mechw = a.MechUnit:new{Image="units/player/Nico_cannonbot_mech_w.png", PosX = -17, PosY = 2}
            a.Nico_cannonbot_mech_broken = a.Nico_cannonbot_mech:new{Image="units/player/Nico_cannonbot_mech_broken.png"}
            a.Nico_cannonbot_mechw_broken = a.MechUnit:new{Image="units/player/Nico_cannonbot_mech_w_broken.png", PosX = -20, PosY = 2 }
            a.Nico_cannonbot_mech_ns = a.MechIcon:new{Image="units/player/Nico_cannonbot_mech_ns.png"}
    --Sentient Weapons 2
        --Knight-Bot
            a.Nico_knightbot_mech =a.MechUnit:new{Image="units/player/Nico_knightbot_mech.png", PosX = -19, PosY = -4}
            a.Nico_knightbot_mecha = a.Nico_knightbot_mech:new{Image="units/player/Nico_knightbot_mech_a.png",NumFrames = 4 }
            a.Nico_knightbot_mechw = a.MechUnit:new{Image="units/player/Nico_knightbot_mech_w.png", PosX = -24, PosY = 0}
            a.Nico_knightbot_mech_broken = a.MechUnit:new{Image="units/player/Nico_knightbot_mech_broken.png", PosX = -15, PosY = 0 }
            a.Nico_knightbot_mechw_broken = a.Nico_knightbot_mechw:new{Image="units/player/Nico_knightbot_mech_w_broken.png"}
            a.Nico_knightbot_mech_ns = a.MechIcon:new{Image="units/player/Nico_knightbot_mech_ns.png"}
        --Shield-Bot
            a.Nico_shieldbot_mech =a.MechUnit:new{Image="units/player/Nico_shieldbot_mech.png", PosX = -17, PosY = -4}
            a.Nico_shieldbot_mecha = a.Nico_shieldbot_mech:new{Image="units/player/Nico_shieldbot_mech_a.png",NumFrames = 4 }
            a.Nico_shieldbot_mechw = a.MechUnit:new{Image="units/player/Nico_shieldbot_mech_w.png", PosX = -16, PosY = -1}
            a.Nico_shieldbot_mech_broken = a.MechUnit:new{Image="units/player/Nico_shieldbot_mech_broken.png", PosX = -17, PosY = 7 }
            a.Nico_shieldbot_mechw_broken = a.MechUnit:new{Image="units/player/Nico_shieldbot_mech_w_broken.png", PosX = -18, PosY = 10 }
            a.Nico_shieldbot_mech_ns = a.MechIcon:new{Image="units/player/Nico_shieldbot_mech_ns.png"}
        --Mine-Bot
            a.Nico_minerbot_mech =a.MechUnit:new{Image="units/player/Nico_minerbot_mech.png", PosX = -20, PosY = 4}
            a.Nico_minerbot_mecha = a.Nico_minerbot_mech:new{Image="units/player/Nico_minerbot_mech_a.png", NumFrames = 4 }
            a.Nico_minerbot_mechw = a.MechUnit:new{Image="units/player/Nico_minerbot_mech_w.png", PosX = -20, PosY = 10}
            a.Nico_minerbot_mech_broken = a.MechUnit:new{Image="units/player/Nico_minerbot_mech_broken.png", PosX = -12, PosY = 0 }
            a.Nico_minerbot_mechw_broken = a.Nico_minerbot_mechw:new{Image="units/player/Nico_minerbot_mech_w_broken.png"}
            a.Nico_minerbot_mech_ns = a.MechIcon:new{Image="units/player/Nico_minerbot_mech_ns.png"}
        --Mine-Bot-Deploy 1 & 2
        for i=1,2 do
            a["Nico_minerbot_mech" .. i] =a.MechUnit:new{Image="units/player/Nico_minerbot_mech"..i..".png", PosX = -20, PosY = 4}
            a["Nico_minerbot_mech" .. i.."a"] = a["Nico_minerbot_mech" .. i]:new{Image="units/player/Nico_minerbot_mech"..i.."_a.png",  PosX = -20, PosY = 4, NumFrames = 4 }
            a["Nico_minerbot_mech" .. i.."e"] = a["Nico_minerbot_mech" .. i.."a"]:new{Image="units/player/Nico_minerbot_mech"..i.."_e.png", NumFrames = 6, Time = 0.1, Loop = false }
            a["Nico_minerbot_mech" .. i.."ns"] = a.MechIcon:new{Image="units/player/Nico_minerbot_mech"..i.."_ns.png"}
        end
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
            a.Nico_hulkbot_mecha = a.Nico_hulkbot_mech:new{Image="units/player/Nico_hulkbot_mech_a.png",NumFrames = 4 }
            a.Nico_hulkbot_mechw = a.MechUnit:new{Image="units/player/Nico_hulkbot_mech_w.png", PosX = -20, PosY = 0 }
            a.Nico_hulkbot_mech_broken = a.Nico_hulkbot_mech:new{Image="units/player/Nico_hulkbot_mech_broken.png"}
            a.Nico_hulkbot_mechw_broken = a.Nico_hulkbot_mechw:new{Image="units/player/Nico_hulkbot_mech_w_broken.png", PosX = -20, PosY = 0 }
            a.Nico_hulkbot_mech_ns = a.MechIcon:new{Image="units/player/Nico_hulkbot_mech_ns.png"}
        --Cannon-Bot-Deploy
            a.Nico_cannonbot_deploy =a.Nico_cannonbot_mech:new{Image="units/player/Nico_cannonbot_deploy.png"}
            a.Nico_cannonbot_deploya = a.Nico_cannonbot_mecha:new{Image="units/player/Nico_cannonbot_deploy_a.png"}
            a.Nico_cannonbot_deploy_ns = a.MechIcon:new{Image="units/player/Nico_cannonbot_deploy_ns.png"}
    --Boom Bots
        --Boom-Artillery
            a.Nico_artilleryboom_mech =a.Nico_artillerybot_mech:new{Image="units/player/Nico_artilleryboom_mech.png"}
            a.Nico_artilleryboom_mecha = a.Nico_artillerybot_mecha:new{Image="units/player/Nico_artilleryboom_mech_a.png"}
            a.Nico_artilleryboom_mechw = a.Nico_artillerybot_mechw:new{Image="units/player/Nico_artilleryboom_mech_w.png"}
            a.Nico_artilleryboom_mech_broken = a.Nico_artillerybot_mech:new{Image="units/player/Nico_artilleryboom_mech_broken.png", PosX = -18, PosY = -9 }
            a.Nico_artilleryboom_mechw_broken = a.Nico_artillerybot_mechw:new{Image="units/player/Nico_artilleryboom_mech_w_broken.png"}
            a.Nico_artilleryboom_mech_ns = a.MechIcon:new{Image="units/player/Nico_artilleryboom_mech_ns.png"}
        --Boom-Laser
            a.Nico_laserboom_mech =a.Nico_laserbot_mech:new{Image="units/player/Nico_laserboom_mech.png"}
            a.Nico_laserboom_mecha = a.Nico_laserbot_mecha:new{Image="units/player/Nico_laserboom_mech_a.png"}
            a.Nico_laserboom_mechw = a.Nico_laserbot_mechw:new{Image="units/player/Nico_laserboom_mech_w.png"}
            a.Nico_laserboom_mech_broken = a.Nico_laserbot_mech_broken:new{Image="units/player/Nico_laserboom_mech_broken.png"}
            a.Nico_laserboom_mechw_broken = a.Nico_laserbot_mechw_broken:new{Image="units/player/Nico_laserboom_mech_w_broken.png"}
            a.Nico_laserboom_mech_ns = a.MechIcon:new{Image="units/player/Nico_laserboom_mech_ns.png"}
        --Boom-Cannon
            a.Nico_cannonboom_mech =a.MechUnit:new{Image="units/player/Nico_cannonboom_mech.png", PosX = -20, PosY = -4}
            a.Nico_cannonboom_mecha = a.MechUnit:new{Image="units/player/Nico_cannonboom_mech_a.png",  PosX = -20, PosY = -4, NumFrames = 3 }
            a.Nico_cannonboom_mechw = a.MechUnit:new{Image="units/player/Nico_cannonboom_mech_w.png", PosX = -17, PosY = 2}
            a.Nico_cannonboom_mech_broken = a.MechUnit:new{Image="units/player/Nico_cannonboom_mech_broken.png", PosX = -20, PosY = -4 }
            a.Nico_cannonboom_mechw_broken = a.MechUnit:new{Image="units/player/Nico_cannonboom_mech_w_broken.png", PosX = -20, PosY = 2 }
            a.Nico_cannonboom_mech_ns = a.MechIcon:new{Image="units/player/Nico_cannonboom_mech_ns.png"}
    --Bloom Bots
        local blooms = {"Laser", "Cannon", "Artillery",}
        local Xframes = 5
        for _, bloom in ipairs(blooms) do
            if bloom ~= "Laser" then Xframes= 1 end
            a["Nico_"..bloom.."_Bloom"]=a.MechUnit:new{Image="units/player/Nico_"..bloom.."_Bloom.png", PosX = -13, PosY = 3}
            a["Nico_"..bloom.."_Bloom_ns"]=a.MechIcon:new{Image="units/player/Nico_"..bloom.."_Bloom_ns.png"}
            a["Nico_"..bloom.."_Blooma"]= a["Nico_"..bloom.."_Bloom"]:new{Image="units/player/Nico_"..bloom.."_Bloom_a.png",  PosX = -13, PosY = 3, NumFrames = 4*Xframes }
            a["Nico_"..bloom.."_Bloome"]=a.BaseEmerge:new{Image="units/player/Nico_"..bloom.."_Bloom_e.png",  PosX = -13, PosY = 4, NumFrames = 10, Time = .14, Loop = false  }
        end
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
        "Nico_icon_ground.png"
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
--mech weapons
    local files = {
        "Nico_laserbot.png","Nico_cannonboom.png",
        "Nico_knightbot.png","Nico_minerbot.png","Nico_minebot.png","Nico_shieldbot.png",
        "Nico_leaderbot.png","Nico_hulkbot.png","Nico_juggernautbot.png","Nico_cannondeploy.png","Nico_Bot_Repair.png","Nico_Bot_Repair_frozen.png",
        "Nico_laserboom.png","Nico_bloom_artillery.png","Nico_bloom_laser.png","Nico_bloom_cannon.png","Nico_bloom_copter.png",
    }
    for _, file in ipairs(files) do
        modApi:appendAsset("img/weapons/"..file,path.."img/weapons/"..file)
    end
    
--Bot Leader's skill replacement
    modApi:appendAsset("img/combat/icons/Nico_icon_shield+10.png", path.."img/combat/icons/Nico_icon_shield+10.png")
    Location["combat/icons/Nico_icon_shield+10.png"] = Point(-16,8)
--Traits
    modApi:appendAsset("img/combat/icons/icon_Nico_zenith_shield.png", path.."img/combat/icons/icon_Nico_zenith_shield.png")--image of the trait
    modApi:appendAsset("img/combat/icons/icon_Nico_zenith_mine.png", path.."img/combat/icons/icon_Nico_zenith_mine.png")--image of the trait
    modApi:copyAsset("img/combat/icons/icon_shield_heal.png","img/combat/icons/icon_Nico_shield_heal.png")--image of the trait
--Effects
    local files = {"shotup_deploymine","shotup_bloom_artillery","Bloom_Bot's_petal","shotup_Nico_Copter_Bloom","shield_bot_pulse"}
    for _, file in ipairs(files) do
        modApi:appendAsset("img/effects/".. file, path.. "img/effects/" .. file..".png")
    end
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
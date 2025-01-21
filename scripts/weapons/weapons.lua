local mod = modApi:getCurrentMod()
local path = mod.scriptPath
local this = {}

require(path .."Achievements/achievements1")
require(path .."weapons/SW1/artillerybot")
require(path .."weapons/SW1/cannonbot")
require(path .."weapons/SW1/laserbot")
if modApi.achievements:isComplete("Nico_Sent_weap","Nico_Bot_SW2") then
    require(path .."Achievements/achievements2")
    require(path .."weapons/SW2/knightbot")
    require(path .."weapons/SW2/minerbot")
    require(path .."weapons/SW2/shieldbot")
end
if modApi.achievements:isComplete("Nico_Sent_weap","Nico_Bot_SW3") then
    require(path .."Achievements/achievements3")
    require(path .."weapons/SW3/juggernautbot")
    require(path .."weapons/SW3/leaderbot")
    require(path .."weapons/SW3/hulkbot")
end
if modApi.achievements:isComplete("Nico_Sent_weap","Nico_Bot_SWBB") then
    require(path .."Achievements/achievements4")
    require(path .."weapons/SWBB/laserboom")
    require(path .."weapons/SWBB/cannonboom")
    require(path .."weapons/SWBB/artilleryboom")
    require(path .."weapons/SWBB/blooms")
	require(path .."weapons/SWBB/deathPetals")
end
require(path .."weapons/otherweapons")

local weapons = {
    "Nico_laserbot","Nico_cannonbot","Nico_artillerybot",
    "Nico_knightbot","Nico_shieldbot","Nico_minerbot_mech",
    "Nico_juggernaut","Nico_hulkbot","Nico_leaderbot",
    "Nico_laserboom","Nico_cannonboom","Nico_artilleryboom"
}
local achievements = {
    "Nico_Bot_Laser","Nico_Bot_Cannon","Nico_Bot_Arti",
    "Nico_Bot_Knight","Nico_Bot_Mine","Nico_Bot_Shield",
    "Nico_Bot_Jugger","Nico_Bot_Leader","Nico_Bot_Hulk",
    "Nico_Bot_Laser_B","Nico_Bot_Cannon_B","Nico_Bot_Arti_B",
}
for i = 1, 12 do 
    if modApi.achievements:get("Nico_Sent_weap",achievements[i]) ~= nil and modApi.achievements:isComplete("Nico_Sent_weap",achievements[i]) then
        modApi:addWeaponDrop(weapons[i])
    end
end
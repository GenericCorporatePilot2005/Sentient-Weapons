local mod = modApi:getCurrentMod()
local path = mod.scriptPath
local this = {}

require(path .."achievements1")
require(path .."weapons/artillerybot")
require(path .."weapons/cannonbot")
require(path .."weapons/laserbot")
if modApi.achievements:isComplete("Nico_Sent_weap","Nico_Bot_SW2") then
    require(path .."weapons/knightbot")
    require(path .."weapons/minerbot")
    require(path .."weapons/shieldbot")
end
if modApi.achievements:isComplete("Nico_Sent_weap","Nico_Bot_SW3") then
    require(path .."weapons/juggernautbot")
    require(path .."weapons/leaderbot")
    require(path .."weapons/hulkbot")
end
if modApi.achievements:isComplete("Nico_Sent_weap","Nico_Bot_SWBB") then
    require(path .."weapons/blooms")
    require(path .."weapons/laserboom")
    require(path .."weapons/cannonboom")
    require(path .."weapons/artilleryboom")
end
require(path .."weapons/otherweapons")
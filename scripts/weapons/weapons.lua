local mod = modApi:getCurrentMod()
local path = mod.scriptPath
local this = {}

require(path .."Achievements/achievements1")
require(path .."weapons/SW1/artillerybot")
require(path .."weapons/SW1/cannonbot")
require(path .."weapons/SW1/laserbot")
if modApi.achievements:isComplete("Nico_Sent_weap","Nico_Bot_SW2") then
    require(path .."weapons/SW2/knightbot")
    require(path .."weapons/SW2/minerbot")
    require(path .."weapons/SW2/shieldbot")
end
if modApi.achievements:isComplete("Nico_Sent_weap","Nico_Bot_SW3") then
    require(path .."weapons/SW3/juggernautbot")
    require(path .."weapons/SW3/leaderbot")
    require(path .."weapons/SW3/hulkbot")
end
if modApi.achievements:isComplete("Nico_Sent_weap","Nico_Bot_SWBB") then
    require(path .."weapons/SWBB/laserboom")
    require(path .."weapons/SWBB/cannonboom")
    require(path .."weapons/SWBB/artilleryboom")
    require(path .."weapons/SWBB/blooms")
	require(path .."weapons/SWBB/deathPetals")
end
require(path .."weapons/otherweapons")
local mod = modApi:getCurrentMod()
local path = mod.scriptPath

require(path .."Achievements/achievements1")
require(path .."weapons/SW1/artillerybot") require(path .."weapons/SW1/cannonbot") require(path .."weapons/SW1/laserbot")
local weapons = {"Nico_laserbot","Nico_cannonbot","Nico_artillerybot"}
local achievements = {"Nico_Bot_Laser","Nico_Bot_Cannon","Nico_Bot_Arti"}
for i = 1, 3 do
    if modApi.achievements:get("Nico_Sent_weap",achievements[i]) ~= nil and modApi.achievements:isComplete("Nico_Sent_weap",achievements[i]) then
        modApi:addWeaponDrop(weapons[i])
    end
end
if modApi.achievements:isComplete("Nico_Sent_weap","Nico_Bot_SW2") then
    require(path .."Achievements/achievements2")
    require(path .."weapons/SW2/knightbot") require(path .."weapons/SW2/minerbot") require(path .."weapons/SW2/shieldbot")
    local weapons = {"Nico_knightbot","Nico_shieldbot","Nico_minerbot"}
    local achievements = {"Nico_Bot_Knight","Nico_Bot_Mine","Nico_Bot_Shield"}
    for i = 1, 3 do
        if modApi.achievements:get("Nico_Sent_weap",achievements[i]) ~= nil and modApi.achievements:isComplete("Nico_Sent_weap",achievements[i]) then
            modApi:addWeaponDrop(weapons[i])
        end
    end
end
if modApi.achievements:isComplete("Nico_Sent_weap","Nico_Bot_SW3") then
    require(path .."Achievements/achievements3")
    require(path .."weapons/SW3/juggernautbot") require(path .."weapons/SW3/leaderbot") require(path .."weapons/SW3/hulkbot")
    local weapons = {"Nico_juggernaut","Nico_leaderbot","Nico_hulkbot"}
    local achievements = {"Nico_Bot_Jugger","Nico_Bot_Leader","Nico_Bot_Hulk"}
    for i = 1, 3 do
        if modApi.achievements:get("Nico_Sent_weap",achievements[i]) ~= nil and modApi.achievements:isComplete("Nico_Sent_weap",achievements[i]) then
            modApi:addWeaponDrop(weapons[i])
        end
    end
end
if modApi.achievements:isComplete("Nico_Sent_weap","Nico_Bot_SW4") then
    require(path .."Achievements/achievements4")
    require(path .."weapons/SWBB/laserboom") require(path .."weapons/SWBB/cannonboom") require(path .."weapons/SWBB/artilleryboom")
    require(path .."weapons/SWBB/blooms")
    local weapons = {"Nico_laserboom","Nico_cannonboom","Nico_artilleryboom"}
    local achievements = {"Nico_Bot_Laser_B","Nico_Bot_Cannon_B","Nico_Bot_Arti_B"}
    for i = 1, 3 do
        if modApi.achievements:get("Nico_Sent_weap",achievements[i]) ~= nil and modApi.achievements:isComplete("Nico_Sent_weap",achievements[i]) then
            modApi:addWeaponDrop(weapons[i])
        end
    end
end
require(path .."weapons/otherweapons")
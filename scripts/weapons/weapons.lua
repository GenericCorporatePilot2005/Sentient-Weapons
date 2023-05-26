local mod = modApi:getCurrentMod()
local path = mod.scriptPath
local this = {}

require(path .."weapons/artillerybot")
require(path .."weapons/cannonbot")
require(path .."weapons/laserbot")
require(path .."weapons/knightbot")
require(path .."weapons/minerbot")
require(path .."weapons/shieldbot")
require(path .."weapons/juggernautbot")
require(path .."weapons/leaderbot")
require(path .."weapons/hulkbot")
require(path .."weapons/otherweapons")
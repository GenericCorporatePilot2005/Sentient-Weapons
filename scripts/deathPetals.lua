
local mod = modApi:getCurrentMod()
local path = mod.scriptPath
local spaceDamageObjects = require(path .."libs/spaceDamageObjects")

local function onModsLoaded()
	modapiext:addPawnKilledHook(function(_, pawn)
		local petals = _G[pawn:GetType()].Nico_onDeath
		if petals then
			local loc = pawn:GetSpace()
			Board:DamageSpace(spaceDamageObjects.Emitter(loc, petals))
		end
	end)
end

modApi.events.onModsLoaded:subscribe(onModsLoaded)

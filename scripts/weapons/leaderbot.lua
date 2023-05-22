------Bot Leader------
Nico_leaderbot=ArtilleryDefault:new{
	Name="Vk8 Rockets Mark V",
	Class = "TechnoVek",
	Icon = "weapons/Nico_leaderbot.png",
	Description="Launch Rockets at up to 3 tiles.",
	Damage = 3,
	PowerCost = 0,
	TwoClick = true,
	Upgrades = 2,
	UpgradeList = { "+1 Damage",  "+1 Damage"  },
	UpgradeCost = {2,3},
	LaunchSound = "/enemy/snowart_1/attack",
	ImpactSound = "/impact/generic/explosion",
	TipImage = {
		Unit = Point(2,3),
		Target = Point(2,1),
		Enemy = Point(2,1),
		Enemy2 = Point(3,1),
		Building = Point(1,1),
		Second_Click=Point(2,2),
        CustomPawn="Nico_botleader_mech",
	},
}
local path = mod_loader.mods[modApi.currentMod].resourcePath
modApi:appendAsset("img/weapons/Nico_leaderbot.png", path .."img/weapons/Nico_leaderbot.png")
function Nico_leaderbot:GetTargetArea(point)
	local ret = PointList()
	for i = 0,3 do
		for j = -1,1 do
			for k = 2,7 do
				ret:push_back(point+DIR_VECTORS[i]*k + DIR_VECTORS[(i+1)%4]*j)
			end
		end
	end
	return ret
end
function Nico_leaderbot:GetSecondTargetArea(p1,p2)
	local ret = PointList()
	local dir = GetDirection(p2 - p1)
	ret:push_back(p1)
	ret:push_back(p1+DIR_VECTORS[dir])
	--get the effective artillery distance, disregarding the sideways offset
	local arti_dist = math.max(math.abs(p2.x - p1.x),math.abs(p2.y - p1.y))
	--get the central point of the shot
	local arti_point = p1+DIR_VECTORS[dir]*arti_dist
	for k = -1,1 do
		if arti_point+DIR_VECTORS[(dir+1)%4]*k ~= p2 then ret:push_back(arti_point+DIR_VECTORS[(dir+1)%4]*k) end
	end
	return ret
end
function Nico_leaderbot:GetSkillEffect(p1,p2)
	local ret = SkillEffect()
	local damage = SpaceDamage(p2, self.Damage)
	ret:AddArtillery(damage,"effects/upshot_KO_combo.png", NO_DELAY)
	return ret
end
function Nico_leaderbot:GetFinalEffect(p1,p2,p3)
	local ret = SkillEffect()
	local dir = GetDirection(p2 - p1)
	local damage = SpaceDamage(p2, self.Damage)
	damage.sAnimation = "ExploArt2"
	damage.sSound = self.ImpactSound..((self.Damage == 5 and "_large") or "")
	--randomised portion of code for tooltip
	if Board:IsTipImage() then
		local dir = 0
		local z = math.random(7)-4 -- z = -3,-2,-1,0,1,2, or 3
		local x = math.abs(z)-2 -- x = -2,-1,0, or 1
		local q = p2+DIR_VECTORS[(dir+1)%4]*x
		if z<0 then
			damage.loc = q
			ret:AddArtillery(damage,"effects/upshot_KO_combo.png", NO_DELAY)
		elseif z>0 then
			for i = -1,1 do
				damage.loc = p2+DIR_VECTORS[(dir+1)%4]*i
				if damage.loc ~= q then ret:AddArtillery(damage,"effects/upshot_KO_combo.png", NO_DELAY) end
			end
		elseif z==0 then
			for i = -1,1 do
				damage.loc = p2+DIR_VECTORS[(dir+1)%4]*i
				ret:AddArtillery(damage,"effects/upshot_KO_combo.png", NO_DELAY)
			end
		end
	--shoot that singular tile
	elseif p1 == p3 then
		ret:AddArtillery(damage,"effects/upshot_KO_combo.png", NO_DELAY)
	--shoot all three tiles
	elseif p1:Manhattan(p3) == 1 then
		--get the effective artillery distance, disregarding the sideways offset
		local arti_dist = math.max(math.abs(p2.x - p1.x),math.abs(p2.y - p1.y))
		--get the central point of the shot
		local arti_point = p1+DIR_VECTORS[dir]*arti_dist
		for i = -1,1 do
			damage.loc = arti_point+DIR_VECTORS[(dir+1)%4]*i
			ret:AddArtillery(damage,"effects/upshot_KO_combo.png", NO_DELAY)
		end
	--shoot those two tiles
	else
		ret:AddArtillery(damage,"effects/upshot_KO_combo.png", NO_DELAY)
		damage.loc = p3
		ret:AddArtillery(damage,"effects/upshot_KO_combo.png", NO_DELAY)
	end
	ret:AddDelay(0.8)
	--instead of manually doing the Bounce at each branch, just run through the existing SkillEffect and pull the points from there
	local n = ret.effect:size()
	for i = 1, n do
		ret:AddBounce(ret.effect:index(i).loc, 3)
	end
	return ret
end
Nico_leaderbot_A=Nico_leaderbot:new{
	Damage=4,
	UpgradeDescription = "Deals 1 additional damage to all targets.",
}
Nico_leaderbot_B=Nico_leaderbot:new{
	Damage=4,
	UpgradeDescription = "Deals 1 additional damage to all targets.",
}
Nico_leaderbot_AB=Nico_leaderbot_A:new{
	Damage=5,
}
modApi:addWeaponDrop("Nico_leaderbot")

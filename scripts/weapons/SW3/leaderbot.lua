--Lemon's Real Mission Checker
local function isRealMission()
local mission = GetCurrentMission()

return true
	and mission ~= nil
	and mission ~= Mission_Test
	and Board
	and Board:IsMissionBoard()
end
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
Nico_leaderbot_B=Nico_leaderbot_A:new{}
Nico_leaderbot_AB=Nico_leaderbot_A:new{
	Damage=5,
}

--this section detects the event that triggers when End Turn is pressed
EXCL = {"GetAmbience", "GetBonusStatus", "BaseUpdate", "UpdateMission", "GetCustomTile", "GetDamage", "GetTurnLimit", "BaseObjectives", "UpdateObjectives",} 

for i,v in pairs(Mission) do 
    if type(v) == 'function' then 
        local oldfn = v 
        Mission[i] = function(...) 
            if not list_contains(_G["EXCL"], i) then 
                if i == "IsEnvironmentEffect" then
			--LOG("The fire has started burning!")
			if Game:GetTurnCount() == 0 then GetCurrentMission().Nico_BotDeployed = false end
		end 
            end 
            return oldfn(...) 
        end 
    end 
end

Nico_cannonbot_deploy = Pawn:new{
	Name = "Cannon-Bot",
	Class = "TechnoVek",
	Health = 1,
	MoveSpeed = 3,
	Corpse = false,
	Image = "Nico_cannonbot_deploy",
	SkillList = {"Nico_cannondeploy"},
	SoundLocation = "/enemy/snowtank_1/",
	DefaultTeam = TEAM_PLAYER,
	ImpactMaterial = IMPACT_METAL,
	Portrait = "npcs/Pilot_Nico_cannondeploy",
}

------Deployable Cannon Bot------

Nico_cannondeploy=Nico_cannonbot:new{
	Name="Cannon 7R Mark I",
	Class="TechnoVek",
	Description="Projectile that causes target to burn.",
	Icon = "weapons/Nico_cannondeploy.png",
	Damage=0,
	Upgrades=0,
	TipImage = {
		Unit = Point(2,4),
		Enemy1 = Point(2,0),
		Enemy2 = Point(2,2),
		Target = Point(2,2),
		Second_Origin = Point(2,4),
		Second_Target = Point(2,0),
		CustomEnemy = "Digger1",
		CustomPawn = "Nico_cannonbot_deploy",
	}
	}

local function Nico_DeployBots(mission)
	if not isRealMission() then return end
	if Game:GetTurnCount() == 1 and Game:GetTeamTurn() == TEAM_PLAYER and not mission.Nico_BotDeployed then
		local pilot0 = GameData.current.pilot0
		local pilot1 = GameData.current.pilot1
		local pilot2 = GameData.current.pilot2
		mission.Nico_BotDeploySpaces = {}
		local ret = SkillEffect()
		local owner = SkillEffect()
		ret:AddSound("/weapons/artillery_volley")
		for k = 0,2 do
			local pawn = Board:GetPawn(k)
			local level1 = (k==0 and pilot0.level > 0) or (k==1 and pilot1.level > 0) or (k==2 and pilot2.level > 0)
			local level2 = (k==0 and pilot0.level > 1) or (k==1 and pilot1.level > 1) or (k==2 and pilot2.level > 1)
			if _G[pawn:GetType()].NicoIsBotLeader and level1 then
				local p1 = pawn:GetSpace()
				local death = {}
				if mission.LiveEnvironment and mission.LiveEnvironment.Locations then
					for k,v in pairs(mission.LiveEnvironment.Locations) do death[#death + 1] = v end
				end
				local targets = extract_table(Board:GetReachable(p1, 3, PATH_FLYER))
				local seen = {}
				local avoid_water = true
				math.randomseed(os.time())
				local i = math.random(#targets)
				i = math.random(#targets)
				while (Board:IsBlocked(targets[i], PATH_PROJECTILE) or Board:IsTerrain(targets[i],TERRAIN_LAVA) or (Board:IsTerrain(targets[i],TERRAIN_WATER) and avoid_water) or Board:IsTerrain(targets[i],TERRAIN_HOLE) or Board:IsPawnSpace(targets[i]) or list_contains(mission.Nico_BotDeploySpaces,targets[i]) or list_contains(death,targets[i]) or Board:IsEdge(targets[i]) or Board:IsDangerousItem(targets[i]) or Board:GetCustomTile(targets[i]) == "ground_rail.png" or Board:GetCustomTile(targets[i]) == "ground_rail2.png" or Board:GetCustomTile(targets[i]) == "ground_rail3.png") do
					if not list_contains(seen,targets[i]) then seen[#seen + 1] = targets[i] end
					if #seen == #targets then avoid_water = false end
					i = math.random(#targets)
				end
				local deploy = SpaceDamage(targets[i],0)
				mission.Nico_BotDeploySpaces[#mission.Nico_BotDeploySpaces + 1] = targets[i]
				deploy.sPawn = "Nico_cannonbot_deploy"
				ret:AddArtillery(p1,deploy,"effects/shotup_robot.png",NO_DELAY)
				owner:AddScript("Board:GetPawn("..targets[i]:GetString().."):SetOwner("..k..")")
				if level2 then
					seen = {}
					avoid_water = true
					while (Board:IsBlocked(targets[i], PATH_PROJECTILE) or Board:IsTerrain(targets[i],TERRAIN_LAVA) or (Board:IsTerrain(targets[i],TERRAIN_WATER) and avoid_water) or Board:IsTerrain(targets[i],TERRAIN_HOLE) or Board:IsPawnSpace(targets[i]) or list_contains(mission.Nico_BotDeploySpaces,targets[i]) or list_contains(death,targets[i]) or Board:IsEdge(targets[i]) or Board:IsDangerousItem(targets[i])) do
						if not list_contains(seen,targets[i]) then seen[#seen + 1] = targets[i] end
						if #seen == #targets then avoid_water = false end
						i = math.random(#targets)
					end
					local deploy = SpaceDamage(targets[i],0)
					mission.Nico_BotDeploySpaces[#mission.Nico_BotDeploySpaces + 1] = targets[i]
					deploy.sPawn = "Nico_cannonbot_deploy"
					ret:AddArtillery(p1,deploy,"effects/shotup_robot.png",NO_DELAY)
					owner:AddScript("Board:GetPawn("..targets[i]:GetString().."):SetOwner("..k..")")
				end
			end
		end
		if ret.effect:size() > 1 then
			for i = 1,#mission.Nico_BotDeploySpaces do
				ret:AddScript("modApi:scheduleHook(750, function() Board:SetFrozen("..mission.Nico_BotDeploySpaces[i]:GetString()..",true) end)")
			end
			ret:AddDelay(FULL_DELAY)
			ret:AddSound("/impact/generic/mech")
			for i = 1,#mission.Nico_BotDeploySpaces do
				local freeze = SpaceDamage(mission.Nico_BotDeploySpaces[i],0)
				freeze.iFrozen = 1
				ret:AddDamage(freeze)
			end
			Board:AddEffect(ret)
			Board:AddEffect(owner)
		end
		mission.Nico_BotDeployed = true
	end
end

local function Nico_BotLeader(mission, pawn, weaponId, p1, targetArea)
	if pawn and _G[pawn:GetType()].NicoIsBotLeader and pawn:IsDamaged() and weaponId ~= "Skill_Repair" and weaponId ~= "Move" then
		local n = targetArea:size()
		for i = 1,n do
			targetArea:erase(1)
		end
	end
end

local function EVENT_onModsLoaded()
	modApi:addMissionUpdateHook(Nico_DeployBots)
	modapiext:addTargetAreaBuildHook(Nico_BotLeader)
end

modApi.events.onModsLoaded:subscribe(EVENT_onModsLoaded)

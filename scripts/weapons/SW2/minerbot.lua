
local BoardEvents = require(modApi:getCurrentMod().scriptPath .."libs/boardEvents")

Nico_Freeze_Mine = { Image = "combat/freeze_mine.png", Damage = SpaceDamage(0), Tooltip = "freeze_mine", Icon = "combat/icons/icon_frozenmine_glow.png", UsedImage = ""}--needs to be global not local
Nico_Freeze_Mine2 = { Image = "combat/Nico_freeze_mine.png", Damage = SpaceDamage(0), Tooltip = "freeze_mine2", Icon = "combat/icons/icon_frozenmine_glow.png", UsedImage = ""}--needs to be global not local
TILE_TOOLTIPS[Nico_Freeze_Mine2.Tooltip] = {"Inactive Freeze Mine", "Any unit that is damaged on this space will be Frozen."}
------Miner Bot------
--The deployable units
Nico_Snowmine = Pawn:new{
    Name = "Mine-Bot Mark I",
    Health = 1,
    Class = "TechnoVek",
    DefaultTeam = TEAM_PLAYER,
    MoveSpeed = 0,
    MoveAtk = 3,
    IgnoreSmoke = true,
    Image = "Nico_minerbot_mech1",
    SkillList = { "Nico_minibot" },
    SoundLocation = "/enemy/snowmine_1/",
    DefaultTeam = TEAM_PLAYER,
    ImpactMaterial = IMPACT_METAL,
    Corpse = false,
	Portrait = "npcs/Pilot_Nico_minerbot_mech_MK1",
}
Nico_SnowmineA = Nico_Snowmine:new{
    Name = "Mine-Bot Mark II",
    MoveAtk = 4,
}
Nico_minibot = Skill:new{
    Name = "Minelayer",
    Class = "TechnoVek",
    Icon = "weapons/Nico_minerbot.png",
    Description = "Deploy a single Freeze mine.",
    TipImage = {
        Unit = Point(2,4),
        Target = Point(2,1),
        CustomPawn = "Nico_Snowmine",
    }
}
function Nico_minibot:GetTargetArea(point)
    return Board:GetReachable(point, _G[Pawn:GetType()].MoveAtk or 4, Pawn:GetPathProf())
end
function Nico_minibot:GetSkillEffect(p1,p2)
    local ret = SkillEffect()
    
    if p1 ~= p2 then
        local damage = SpaceDamage(p1)
        damage.sItem = "Freeze_Mine"
        ret:AddDamage(damage)
        ret:AddMove(Board:GetPath(p1, p2, Pawn:GetPathProf()), FULL_DELAY)
    end

    return ret
end
Nico_Snowmine2 = Pawn:new{
    Name = "Mine-Bot Mark III",
    Health = 1,
    Class = "TechnoVek",
    DefaultTeam = TEAM_PLAYER,
    MoveSpeed = 3,
    MoveAtk = 3,
    IgnoreSmoke = true,
    Image = "Nico_minerbot_mech2",
    SkillList = { "Nico_minibot2" },
    SoundLocation = "/enemy/snowmine_1/",
    DefaultTeam = TEAM_PLAYER,
    ImpactMaterial = IMPACT_METAL,
    Corpse = false,
	Portrait = "npcs/Pilot_Nico_minerbot_mech_MK2",
}
Nico_Snowmine2A = Nico_Snowmine2:new{
    Name = "Mine-Bot Mark IV",
    MoveAtk = 4,
    MoveSpeed = 4,
}
Nico_minibot2 = Skill:new{
    Name = "Minelayer MK2",
    Class = "TechnoVek",
    Icon = "weapons/Nico_minerbot.png",
    Description = "Deploy a single Freeze mine, allows Unit to move again.",
    TipImage = {
        Unit = Point(2,4),
        Target = Point(2,1),
        Second_Origin = Point(2,1),
        Second_Target = Point(1,2),
        CustomPawn = "Nico_Snowmine2",
    }
}
local mod = modApi:getCurrentMod()
local path = mod.scriptPath
local customAnim = require(path.."libs/customAnim")
function Nico_minibot2:GetTargetArea(point)
    return Board:GetReachable(point, _G[Pawn:GetType()].MoveAtk or 4, Pawn:GetPathProf())
end
function Nico_minibot2:GetSkillEffect(p1,p2)
    local ret = SkillEffect()

    if p1 ~= p2 then
        local damage = SpaceDamage(p1)
        damage.sItem = "Freeze_Mine"
        ret:AddDamage(damage)
        local mechId = Board:GetPawn(p1):GetId()
        ret:AddMove(Board:GetPath(p1, p2, Pawn:GetPathProf()), FULL_DELAY)
        ret:AddScript("Board:GetPawn("..mechId.."):SetActive(true)")
        ret:AddScript("Board:GetPawn("..mechId.."):SetBonusMove("..(_G[Pawn:GetType()].MoveAtk or 4)..")")
    end
    return ret
end

--The mech's weapon
Nico_minerbot = ArtilleryDefault:new{
    Icon = "weapons/Nico_minebot.png",
    Name = "Mine-Bot Deployer",
    Description = "Launch a Mine-Bot at a tile, pushing tiles to the left and right, creating an improved Mine-Bot on kill.",
    Class = "TechnoVek",
    ArtilleryStart = 2,
    ArtillerySize = 8,
    SpawnBot = "Nico_Snowmine",
    SpawnBot2 = "Nico_Snowmine2",
    LaunchSound = "/weapons/artillery_volley",
    ImpactSound = "/impact/generic/mech",
    Damage = 1,
    Upgrades = 2,
    KOSound = "/impact/generic/mech",
    UpgradeList = {"+1 Move","+2 Damage"},
    UpgradeCost = { 1,3 },
    TipImage = {
        Unit = Point(2,4),
        Second_Origin = Point(2,4),
        Enemy = Point(2,1),
        Enemy2 = Point(3,1),
        Target = Point(2,1),
        Second_Target = Point(2,2),
        CustomEnemy = "Leaper1",
        CustomPawn = "Nico_minerbot_mech",
        Length = 6,
    }
}

function Nico_minerbot:GetSkillEffect(p1,p2)
    local ret = SkillEffect()
    local dir = GetDirection(p2 - p1)
    local damage = SpaceDamage(p2)
    
    ret:AddBounce(p1, 1)
    ret:AddArtillery(damage,"effects/shotup_deploymine.png")
    if Board:IsValid(p2) and not Board:IsBlocked(p2,PATH_PROJECTILE) then
        damage.sPawn = self.SpawnBot
        damage.sAnimation = ""
        damage.iDamage = 0
        ret:AddBounce(p2, self.BounceAmount)
        ret:AddBoardShake(0.15)
        ret:AddSound(self.KOSound)
        ret:AddAnimation(damage.loc,"Nico_minerbot_mech1e", ANIM_DELAY)
        ret:AddDelay(0.1)
    else
        damage.iDamage = self.Damage
        damage.sAnimation = "ExploArt0"
        damage.bKO_Effect = Board:IsDeadly(damage,Pawn)
        ret:AddBounce(p2, self.BounceAmount)
        ret:AddBoardShake(0.15)
        ret:AddSound(self.KOSound)
    end
    
    ret:AddDamage(damage)
    local damagepush = SpaceDamage(p2 + DIR_VECTORS[(dir+1)%4], 0, (dir+1)%4)
    damagepush.sAnimation = "airpush_"..((dir+1)%4)
    ret:AddDamage(damagepush) 
    damagepush = SpaceDamage(p2 + DIR_VECTORS[(dir-1)%4], 0, (dir-1)%4)
    damagepush.sAnimation = "airpush_"..((dir-1)%4)
    ret:AddDamage(damagepush)
    
    if damage.bKO_Effect then
        damage.sPawn = self.SpawnBot2
        damage.sAnimation = ""
        damage.iDamage = 0
        ret:AddAnimation(damage.loc,"Nico_minerbot_mech2e", ANIM_DELAY)
        ret:AddDelay(0.6)
        ret:AddDamage(damage)
    end

	-- for the tip
	if Board:GetSize() == Point(6,6) then
		ret:AddScript(string.format(
			"Board:GetPawn(%s):FireWeapon(%s, 1)",
			self.TipImage.Target:GetString(),Point(0,1):GetString()
		))
		ret:AddDelay(-1)
		ret:AddScript(string.format(
			"Board:GetPawn(%s):FireWeapon(%s, 1)",
			Point(0,1):GetString(),Point(0,3):GetString()
		))
		ret:AddDelay(1.0)
		ret:AddScript(string.format(
			"Board:GetPawn(%s):FireWeapon(%s, 1)",
			self.TipImage.Second_Target:GetString(),Point(4,2):GetString()
		))
	end
    return ret
end
Nico_minerbot_A = Nico_minerbot:new{
    SpawnBot = "Nico_SnowmineA",
    SpawnBot2 = "Nico_Snowmine2A",
    UpgradeDescription = "Increases the Mine-Bot's move distance to 4.",
}

Nico_minerbot_B = Nico_minerbot:new{
    Damage = 3,
    UpgradeDescription = "Increases the artillery attack damage by 2.",
    TipImage = {
        Unit = Point(2,4),
        Second_Origin = Point(2,4),
        Enemy = Point(2,1),
        Enemy2 = Point(3,1),
        Target = Point(2,1),
        Second_Target = Point(2,2),
        CustomEnemy = "Firefly1",
        CustomPawn = "Nico_minerbot_mech",
    }
}
Nico_minerbot_AB = Nico_minerbot_B:new{
    SpawnBot = "Nico_SnowmineA",
    SpawnBot2 = "Nico_Snowmine2A",
}

local function Nico_MoveMine(mission, pawn, weaponId, p1, p2)
	if pawn and (pawn:GetType() == "Nico_minerbot_mech" or pawn:GetType() == "Nico_Snowmine2" or pawn:GetType() == "Nico_Snowmine2A") and weaponId == "Move" then
		mission.Nico_FireSpace = {p1,Board:IsFire(p1)}
        if Board:IsTerrain(p1,TERRAIN_WATER) or Board:IsTerrain(p1,TERRAIN_LAVA) or Board:IsTerrain(p1,TERRAIN_HOLE) then
            Board:SetItem(p1,"Nico_Freeze_Mine2")
        elseif Board:IsFire(p1) then
            Board:SetItem(p1,"Freeze_Mine")
        else
            Board:SetItem(p1,"Nico_Freeze_Mine")
        end
	end
end

local function Nico_UnMine(mission, pawn, undonePosition)
	if (pawn:GetType() == "Nico_minerbot_mech" or pawn:GetType() == "Nico_Snowmine2" or pawn:GetType() == "Nico_Snowmine2A") then
		if mission.Nico_FireSpace[2] then Board:SetFire(mission.Nico_FireSpace[1],true) end
		if Board:IsTerrain(pawn:GetSpace(),TERRAIN_WATER) then Board:RemoveItem(pawn:GetSpace()) end
	end
end

local function EVENT_onModsLoaded()
	modapiext:addSkillStartHook(Nico_MoveMine)
	modapiext:addPawnUndoMoveHook(Nico_UnMine)
end

modApi.events.onModsLoaded:subscribe(EVENT_onModsLoaded)

--this part copied from Lemon's Minelayer Mech
local undoPawnId_thisFrame = nil

modapiext.events.onPawnUndoMove:subscribe(function(mission, pawn)
	undoPawnId_thisFrame = pawn:GetId()
	modApi:runLater(function(mission)
		undoPawnId_thisFrame = nil
	end)
end)

BoardEvents.onItemRemoved:subscribe(function(loc, removed_item)
	if removed_item == "Nico_Freeze_Mine" or removed_item == "Nico_Freeze_Mine2" then
		local pawn = Board:GetPawn(loc)
		if pawn and pawn:GetId() == undoPawnId_thisFrame then
			-- do nothing
		else
			local freeze_damage = SpaceDamage(loc, 0)
			freeze_damage.sSound = "/props/freezing_mine"
			freeze_damage.sAnimation = ""
			freeze_damage.iFrozen = 1
			Board:DamageSpace(freeze_damage)
		end
	end
	if removed_item == "Freeze_Mine" then
		local pawn = Board:GetPawn(loc)
		if pawn and pawn:GetType() == "Train_Armored" and not pawn:IsShield() then
			pawn:SetFrozen(true)
		end
	end
end)

BoardEvents.onTerrainChanged:subscribe(function(p, terrain, terrain_prev)
	local item = Board:GetItem(p)
	if item == "Nico_Freeze_Mine" or item == "Freeze_Mine" then
		if terrain == TERRAIN_HOLE or terrain == TERRAIN_WATER then
            Board:SetItem(p,"Nico_Freeze_Mine2")
		end
    elseif item == "Nico_Freeze_Mine2" then
        if terrain == TERRAIN_ROAD or terrain == TERRAIN_GROUND then
            Board:SetItem(p,"Freeze_Mine")
        end
	end
end)
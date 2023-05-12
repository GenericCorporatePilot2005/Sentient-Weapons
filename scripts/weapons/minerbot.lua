local path = mod_loader.mods[modApi.currentMod].resourcePath
------Miner Bot------
	--The deployable's palettes
    modApi:addPalette{
        ID = "Nico_mine_iceflower",
        Name = "Mine-Bot Mark I",
        image="units/player/Nico_minerbot_mech_ns.png",
        PlateHighlight = {233,161,172},--lights
        PlateLight     = {189,220,255},--main highlight
        PlateMid       = {146,182,207},--main light
        PlateDark      = {91,107,158},--main mid
        PlateOutline   = {32,54,55},--main dark
        PlateShadow    = {60,91,117},--metal dark
        BodyColor      = {104,116,193},--metal mid
        BodyHighlight  = {219,255,242},--metal light
    }
    modApi:addPalette{
        ID = "Nico_mine_winter",
        Name = "Mine-Bot Mark III",
        image="units/player/Nico_minerbot_mech_ns.png",
        PlateHighlight = {255,245,101},--lights
        PlateLight     = {217,216,221},--main highlight
        PlateMid       = {123,122,128},--main light
        PlateDark      = {71,72,77},--main mid
        PlateOutline   = {46,45,51},--main dark
        PlateShadow    = {71,163,157},--metal dark
        BodyColor      = {144,215,219},--metal mid
        BodyHighlight  = {246,255,255},--metal light
    }
--The deployable units
    Nico_Snowmine = Pawn:new{
        Name = "Mine-Bot Mark I",
        Health = 1,
        Class = "TechnoVek",
        ImageOffset = modApi:getPaletteImageOffset("Nico_mine_iceflower"),
        DefaultTeam = TEAM_PLAYER,
        MoveSpeed = 0,
        MoveAtk = 3,
        IgnoreSmoke = true,
        Image = "Nico_minerbot_mech",
        SkillList = { "Nico_minibot" },
        SoundLocation = "/enemy/snowmine_1/",
        DefaultTeam = TEAM_PLAYER,
        ImpactMaterial = IMPACT_METAL,
        Corpse = false,
    }
    Nico_SnowmineA = Nico_Snowmine:new{
        Name = "Mine-Bot Mark II",
        MoveAtk = 4,
    }
    modApi:appendAsset("img/weapons/Nico_minerbot.png", path .."img/weapons/Nico_minerbot.png")
    Nico_minibot = Skill:new{
        Name = "Minelayer",
        Class="TechnoVek",
        Icon="weapons/Nico_minerbot.png",
        Description="Deploy a single Freeze mine.",
        TipImage = {
            Unit = Point(2,3),
            Target = Point(2,1),
            CustomPawn = "Nico_Snowmine",
        }
    }
    function Nico_minibot:GetTargetArea(point)
        return Board:GetReachable(point, _G[Pawn:GetType()].MoveAtk, Pawn:GetPathProf())
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
        MoveSpeed = 0,
        MoveAtk = 3,
        IgnoreSmoke = true,
        Image = "Nico_minerbot_mech",
        ImageOffset = modApi:getPaletteImageOffset("Nico_mine_winter"),
        SkillList = { "Nico_minibot2" },
        SoundLocation = "/enemy/snowmine_1/",
        DefaultTeam = TEAM_PLAYER,
        ImpactMaterial = IMPACT_METAL,
        Corpse = false,
    }
    Nico_Snowmine2A = Nico_Snowmine2:new{
        Name = "Mine-Bot Mark IV",
        MoveAtk = 4,
    }
    Nico_minibot2 = Skill:new{
        Name = "Double Minelayer",
        Class="TechnoVek",
        Icon="weapons/Nico_minerbot.png",
        Description="Deploy two Freeze mines.",
        TwoClick = true,
        TipImage = {
            Unit = Point(2,3),
            Target = Point(2,1),
            Second_Click = Point(2,3),
            CustomPawn = "Nico_Snowmine2",
        }
    }
    function Nico_minibot2:GetTargetArea(point)
        return Board:GetReachable(point, _G[Pawn:GetType()].MoveAtk, Pawn:GetPathProf())
    end
    function Nico_minibot2:GetSecondTargetArea(p1,p2)
        local ret = Board:GetReachable(p2, _G[Pawn:GetType()].MoveAtk, Pawn:GetPathProf())
        ret:push_back(p1)
        return ret
    end
    function Nico_minibot2:IsTwoClickException(p1,p2)
        return ((not Pawn:IsShield()) and (Board:GetItem(p2) == "Freeze_Mine" or Board:GetItem(p2) == "Nico_Freeze_Mine" or Board:GetItem(p2) == "lmn_Minelayer_Item_Mine")) or Board:GetItem(p2) == "Item_Mine"
    end
    function Nico_minibot2:GetSkillEffect(p1,p2)
        local ret = SkillEffect()
    
        if p1 ~= p2 then
            local damage = SpaceDamage(p1)
            damage.sItem = "Freeze_Mine"
            ret:AddDamage(damage)
            ret:AddMove(Board:GetPath(p1, p2, Pawn:GetPathProf()), FULL_DELAY)
        end
    
        return ret
    end
    function Nico_minibot2:GetFinalEffect(p1,p2,p3)
        local ret = self:GetSkillEffect(p1,p2)
        ret:AddDelay(0.2)--so it can pick up time pods
        if p2 ~= p3 then
            local damage = SpaceDamage(p2)
            damage.sItem = "Freeze_Mine"
            ret:AddDamage(damage)
            ret:AddMove(Board:GetPath(p2, p3, Pawn:GetPathProf()), FULL_DELAY)
        end
    
        return ret
    end
--The mech's weapon
Nico_minerbot=ArtilleryDefault:new{
Icon = "weapons/ranged_defensestrike.png",
Name="Mine-Bot Deployer",
Description="Launch a Mine-Bot at a tile, pushing tiles to the left and right, creating an improved Mine-Bot on kill.",
Class="TechnoVek",
ArtilleryStart = 2,
ArtillerySize = 8,
SpawnBot = "Nico_Snowmine",
SpawnBot2 = "Nico_Snowmine2",
LaunchSound = "/weapons/artillery_volley",
ImpactSound = "/impact/generic/mech",
Damage = 1,
Upgrades = 2,
KOSound = "/impact/generic/mech",
UpgradeList={"+1 Move","+2 Damage"},
UpgradeCost = { 1,3 },
TipImage = {
    Unit = Point(2,4),
    Second_Origin=Point(2,4),
    Enemy = Point(2,1),
    Enemy2 = Point(3,1),
    Target = Point(2,1),
    Second_Target=Point(2,2),
    CustomEnemy = "Leaper1",
    CustomPawn = "Nico_minerbot_mech",
}
}
    function Nico_minerbot:GetSkillEffect(p1,p2)
        local ret = SkillEffect()
        local dir = GetDirection(p2 - p1)
        local damage = SpaceDamage(p2, self.Damage)

        if Board:IsValid(p2) and not Board:IsBlocked(p2,PATH_PROJECTILE) then
            damage.sPawn = self.SpawnBot
            damage.sAnimation = ""
            damage.iDamage = 0
        else
            damage.sAnimation = "ExploArt0"
            damage.bKO_Effect = Board:IsDeadly(damage,Pawn)
            if damage.bKO_Effect then damage.sPawn = self.SpawnBot2 
            end
        end

        ret:AddBounce(p1, 1)
        ret:AddArtillery(damage,"effects/shotup_robot.png")

        ret:AddBounce(p2, self.BounceAmount)
        ret:AddBoardShake(0.15)
        ret:AddSound(self.KOSound)

        local damagepush = SpaceDamage(p2 + DIR_VECTORS[(dir+1)%4], 0, (dir+1)%4)
        damagepush.sAnimation = "airpush_"..((dir+1)%4)
        ret:AddDamage(damagepush) 
        damagepush = SpaceDamage(p2 + DIR_VECTORS[(dir-1)%4], 0, (dir-1)%4)
        damagepush.sAnimation = "airpush_"..((dir-1)%4)
        ret:AddDamage(damagepush)
        return ret
    end
    Nico_minerbot_A=Nico_minerbot:new{
        SpawnBot = "Nico_SnowmineA",
        SpawnBot2 = "Nico_Snowmine2A",
        UpgradeDescription = "Increases the Mine-Bot's move distance to 4.",
    }
Nico_minerbot_B=Nico_minerbot:new{
    Damage = 3,
    UpgradeDescription = "Increases the artillery attack damage by 2.",
    TipImage = {
        Unit = Point(2,4),
        Second_Origin=Point(2,4),
        Enemy = Point(2,1),
        Enemy2 = Point(3,1),
        Target = Point(2,1),
        Second_Target=Point(2,2),
        CustomEnemy = "Firefly1",
        CustomPawn = "Nico_minerbot_mech",
    }
}
Nico_minerbot_AB=Nico_minerbot_B:new{
    SpawnBot = "Nico_SnowmineA",
    SpawnBot2 = "Nico_Snowmine2A",
}
modApi:addWeaponDrop("Nico_minerbot")
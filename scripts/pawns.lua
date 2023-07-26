local mod = modApi:getCurrentMod()
-- this line just gets the file path for your mod, so you can find all your files easily.

local path = mod.scriptPath
require(path .."palettes")
--mechs
--Sentient weapons 1
    Nico_laserbot_mech = Pawn:new{
        Name = "Laser-Bot",
        NicoIsRobot = true,
        Class = "TechnoVek",
        Health = 1,
        MoveSpeed = 4,
        Massive = true,
        Corpse = true,
        Image = "Nico_laserbot_mech",
	    ImageOffset = modApi:getPaletteImageOffset("nico_snow"),
        SkillList = {"Nico_laserbot"},
	    SoundLocation = "/enemy/snowlaser_1/",
        DefaultTeam = TEAM_PLAYER,
	    ImpactMaterial = IMPACT_METAL,
        AddPawn("Nico_laserbot_mech")
    }
    Nico_artillerybot_mech = Pawn:new{
        Name = "Artillery-Bot",
        NicoIsRobot = true,
        Class = "TechnoVek",
        Health = 1,
        MoveSpeed = 3,
        Massive = true,
        Corpse = true,
        Image = "Nico_artillerybot_mech",
	    ImageOffset = modApi:getPaletteImageOffset("nico_snow"),
        SkillList = {"Nico_artillerybot"},
        SoundLocation = "/enemy/snowart_1/",
        DefaultTeam = TEAM_PLAYER,
	    ImpactMaterial = IMPACT_METAL,
        AddPawn("Nico_artillerybot_mech")
    }
    Nico_cannonbot_mech = Pawn:new{
        Name = "Cannon-Bot",
        NicoIsRobot = true,
        Class = "TechnoVek",
        Health = 1,
        MoveSpeed = 3,
        Massive = true,
        Corpse = true,
        Image = "Nico_cannonbot_mech",
        ImageOffset = modApi:getPaletteImageOffset("nico_snow"),
        SkillList = {"Nico_cannonbot"},
	    SoundLocation = "/enemy/snowtank_1/",
        DefaultTeam = TEAM_PLAYER,
	    ImpactMaterial = IMPACT_METAL,
        AddPawn("Nico_cannonbot_mech")
    }
--Sentient Weapons 2
    if modApi.achievements:isComplete("Nico_Sent_weap","Nico_Bot_SW2") then
        Nico_knightbot_mech = Pawn:new{
            Name = "Knight-Bot",
            NicoIsRobot = true,
            Class = "TechnoVek",
            Health = 1,
            MoveSpeed = 3,
            Massive = true,
            Corpse = true,
            Armor = true,
            Image = "Nico_knightbot_mech",
            ImageOffset = modApi:getPaletteImageOffset("nico_alpha_snow"),
            SkillList = {"Nico_knightbot"},
            SoundLocation = "/enemy/snowlaser_1/",
            DefaultTeam = TEAM_PLAYER,
            ImpactMaterial = IMPACT_METAL,
            AddPawn("Nico_knightbot_mech")
        }
        Nico_shieldbot_mech = Pawn:new{
            Name = "Shield-Bot",
            NicoIsRobot = true,
            Class = "TechnoVek",
            Health = 1,
            MoveSpeed = 4,
            Massive = true,
            Corpse = true,
            Flying=true,
            Image = "Nico_shieldbot_mech",
            ImageOffset = modApi:getPaletteImageOffset("nico_alpha_snow"),
            SkillList = {"Nico_shieldbot"},
            SoundLocation = "/enemy/snowlaser_1/",
            DefaultTeam = TEAM_PLAYER,
            ImpactMaterial = IMPACT_METAL,
            AddPawn("Nico_shieldbot_mech")
        }
        Nico_minerbot_mech = Pawn:new{
            Name = "Mine-Bot",
            NicoIsRobot = true,
            Class = "TechnoVek",
            Health = 1,
            MoveSpeed = 4,
            Massive = true,
            Corpse = true,
            Image = "Nico_minerbot_mech",
            ImageOffset = modApi:getPaletteImageOffset("nico_alpha_snow"),
            SkillList = {"Nico_minerbot"},
            SoundLocation = "/enemy/snowmine_1/",
            DefaultTeam = TEAM_PLAYER,
            ImpactMaterial = IMPACT_METAL,
            AddPawn("Nico_minerbot_mech")
        }
    end

--Sentient Weapon 3
    if modApi.achievements:isComplete("Nico_Sent_weap","Nico_Bot_SW3") then
        Nico_juggernautbot_mech = Pawn:new{
            Name = "Juggernaut-Bot",
            NicoIsRobot = true,
            Class = "TechnoVek",
            Health = 1,
            MoveSpeed = 1,
            Massive = true,
            Corpse = true,
            IgnoreSmoke = true,
            Image = "Nico_juggernautbot_mech",
            ImageOffset = modApi:getPaletteImageOffset("nico_boss_snow"),
            SkillList = {"Nico_juggernaut"},
            SoundLocation = "/enemy/snowart_2/",
            DefaultTeam = TEAM_PLAYER,
            ImpactMaterial = IMPACT_METAL,
            AddPawn("Nico_juggernautbot_mech")
        }
        Nico_botleader_mech = Pawn:new{
            Name = "Bot Leader",
            NicoIsBotLeader = true,
            Class = "TechnoVek",
            Health = 5,
            MoveSpeed = 3,
            Massive = true,
            Corpse = true,
            Image = "Nico_artillerybot_mech",
            ImageOffset = modApi:getPaletteImageOffset("nico_boss_snow"),
            SkillList = {"Nico_leaderbot"},
            SoundLocation = "/enemy/snowart_1/",
            DefaultTeam = TEAM_PLAYER,
            ImpactMaterial = IMPACT_METAL,
            AddPawn("Nico_botleader_mech")
        }
        Nico_hulkbot_mech = Pawn:new{
            Name = "Cryo Hulk",
            NicoIsRobot = true,
            Class = "TechnoVek",
            Health = 4,
            MoveSpeed = 3,
            Armor = true,
            Massive = true,
            Corpse = true,
            Image = "Nico_hulkbot_mech",
            ImageOffset = modApi:getPaletteImageOffset("nico_boss_snow"),
            SkillList = {"Nico_hulkbot"},
            SoundLocation = "/enemy/snowart_1/",
            DefaultTeam = TEAM_PLAYER,
            ImpactMaterial = IMPACT_METAL,
            AddPawn("Nico_hulkbot_mech")
        }
    end
--Boom Bots
    if modApi.achievements:isComplete("Nico_Sent_weap","Nico_Bot_SWBB") then
        Nico_laserboom_mech = Pawn:new{
            Name = "Boom Laser",
            NicoIsBoom = true,
            Class = "TechnoVek",
            Health = 1,
            MoveSpeed = 4,
            Massive = true,
            Corpse = true,
            Image = "Nico_laserboom_mech",
            ImageOffset = modApi:getPaletteImageOffset("Nico_boom_snow"),
            SkillList = {"Nico_laserboom"},
            SoundLocation = "/enemy/snowlaser_1/",
            DefaultTeam = TEAM_PLAYER,
            ImpactMaterial = IMPACT_METAL,
            --Explodes=true,
            AddPawn("Nico_laserboom_mech")
        }
        Nico_artilleryboom_mech = Pawn:new{
            Name = "Boom Artillery",
            NicoIsBoom = true,
            Class = "TechnoVek",
            Health = 1,
            MoveSpeed = 3,
            Massive = true,
            Corpse = true,
            Image = "Nico_artilleryboom_mech",
            ImageOffset = modApi:getPaletteImageOffset("Nico_boom_snow"),
            SkillList = {"Nico_artilleryboom"},
            SoundLocation = "/enemy/snowart_1/",
            DefaultTeam = TEAM_PLAYER,
            ImpactMaterial = IMPACT_METAL,
            --Explodes=true,
            AddPawn("Nico_artillerybot_mech")
        }
        Nico_cannonboom_mech = Pawn:new{
            Name = "Boom Cannon",
            NicoIsBoom = true,
            Class = "TechnoVek",
            Health = 1,
            MoveSpeed = 4,
            Massive = true,
            Corpse = true,
            Image = "Nico_cannonboom_mech",
            ImageOffset = modApi:getPaletteImageOffset("Nico_boom_snow"),
            SkillList = {"Nico_cannonboom"},
            SoundLocation = "/enemy/snowtank_1/",
            DefaultTeam = TEAM_PLAYER,
            ImpactMaterial = IMPACT_METAL,
            --Explodes=true,
            AddPawn("Nico_cannonboom_mech")
        }
    end
--Traits
    local trait = require(mod.scriptPath .."libs/trait")--where does it get the code for the rest of this to work

    Nico_Pawn_List = {"Nico_laserbot_mech", "Nico_cannonbot_mech", "Nico_artillerybot_mech", "Nico_knightbot_mech", "Nico_shieldbot_mech","Nico_minerbot_mech","Nico_juggernautbot_mech","Nico_hulkbot_mech"}

    for i = 1,8 do
    	trait:add{
		    pawnType=Nico_Pawn_List[i],--who will get the trait
		    icon = "img/icon_Nico_zenith_shield.png",--the icon itself
		    icon_offset = Point(0,9),--it's location
		    desc_title = "Zenith\'s Guard",--title
		    desc_text = "Gains a shield when moving, leaping, charging, or teleporting to a destination next to another Mech. Bots can repair other adjacent Bots.",--description
	    }
    end

    trait:add{
	    pawnType="Nico_botleader_mech",--who will get the trait
	    icon = "img/icon_Nico_shield_heal.png",--the icon itself
	    icon_offset = Point(0,9),--it's location
	    desc_title = "Bot Leader",--title
	    desc_text = "After taking any damage, the next action is a forced repair.\nAt mission start, can deploy a number of Cannon Mechs equal to pilot level.\nRevives when dead at the end of a battle.",--description
    }

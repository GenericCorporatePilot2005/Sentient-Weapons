local mod = modApi:getCurrentMod()
local path = mod_loader.mods[modApi.currentMod].resourcePath
-- this line just gets the file path for your mod, so you can find all your files easily.

local path2 = mod.scriptPath
require(path2 .."palettes")
--mechs
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
        AddPawn("Nico_laserbot_mech")}
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
        AddPawn("Nico_artillerybot_mech")}
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
        AddPawn("Nico_cannonbot_mech")}
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
        AddPawn("Nico_knightbot_mech")}
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
        AddPawn("Nico_shieldbot_mech")}
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
        AddPawn("Nico_minerbot_mech")}
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
        AddPawn("Nico_juggernautbot_mech")}
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
        AddPawn("Nico_botleader_mech")}
--Traits
    modApi:appendAsset("img/icon_Nico_zenith_shield.png", path.."img/icon_Nico_zenith_shield.png")--image of the trait
    modApi:appendAsset("img/icon_Nico_shield_heal.png", path.."img/icon_Nico_shield_heal.png")--image of the trait
    local mod = modApi:getCurrentMod()--the mod itself
    local trait = require(mod.scriptPath .."libs/trait")--where does it get the code for the rest of this to work

    Nico_Pawn_List = {"Nico_laserbot_mech", "Nico_cannonbot_mech", "Nico_artillerybot_mech", "Nico_knightbot_mech", "Nico_shieldbot_mech","Nico_minerbot_mech","Nico_juggernautbot_mech"}

    for i = 1,7 do
    	trait:add{
		    pawnType=Nico_Pawn_List[i],--who will get the trait
		    icon = "img/icon_Nico_zenith_shield.png",--the icon itself
		    icon_offset = Point(0,9),--it's location
		    desc_title = "Zenith\'s Guard",--title
		    desc_text = "Gains a shield when moving next to another Mech. Bots can repair other adjacent Bots.",--description
	    }
    end

    trait:add{
	    pawnType="Nico_botleader_mech",--who will get the trait
	    icon = "img/icon_Nico_shield_heal.png",--the icon itself
	    icon_offset = Point(0,9),--it's location
	    desc_title = "Bot Leader",--title
	    desc_text = "After taking any damage, the next action is a forced repair. Repairing fully heals the Bot Leader, and Shields it.",--description
    }

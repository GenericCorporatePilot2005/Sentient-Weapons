local mod = modApi:getCurrentMod()


-- this line just gets the file path for your mod, so you can find all your files easily.
local path = mod_loader.mods[modApi.currentMod].resourcePath
	modApi:appendAsset("img/portraits/pilots/Pilot_Nico_artillerybot_mech.png", path .."img/portraits/Pilot_Nico_artillerybot_mech.png")
	modApi:appendAsset("img/portraits/pilots/Pilot_Nico_laserbot_mech.png", path .."img/portraits/Pilot_Nico_laserbot_mech.png")
	modApi:appendAsset("img/portraits/pilots/Pilot_Nico_cannonbot_mech.png", path .."img/portraits/Pilot_Nico_cannonbot_mech.png")
    modApi:appendAsset("img/portraits/pilots/Pilot_Nico_knightbot_mech.png", path .."img/portraits/Pilot_Nico_knightbot_mech.png")
    modApi:appendAsset("img/portraits/pilots/Pilot_Nico_shieldbot_mech.png", path .."img/portraits/Pilot_Nico_shieldbot_mech.png")
    modApi:appendAsset("img/portraits/pilots/Pilot_Nico_minerbot_mech.png", path .."img/portraits/Pilot_Nico_minerbot_mech.png")
-- locate our mech assets.
local artmechPath = path .."img/units/player/"
-- make a list of our files.
local files = {
	"Nico_artillerybot_mech.png",
	"Nico_artillerybot_mech_a.png",
	"Nico_artillerybot_mech_w.png",
	"Nico_artillerybot_mech_w_broken.png",
	"Nico_artillerybot_mech_broken.png",
	"Nico_artillerybot_mech_ns.png",
	"Nico_artillerybot_mech_h.png",
}
for _, file in ipairs(files) do
	modApi:appendAsset("img/units/player/".. file, artmechPath .. file)
end
local a=ANIMS
	a.Nico_artillerybot_mech =a.MechUnit:new{Image="units/player/Nico_artillerybot_mech.png", PosX = -18, PosY = -9}
	a.Nico_artillerybot_mecha = a.MechUnit:new{Image="units/player/Nico_artillerybot_mech_a.png",  PosX = -18, PosY = -9, NumFrames = 4 }
	a.Nico_artillerybot_mechw = a.MechUnit:new{Image="units/player/Nico_artillerybot_mech_w.png", -18, PosY = -2}
	a.Nico_artillerybot_mech_broken = a.MechUnit:new{Image="units/player/Nico_artillerybot_mech_broken.png", PosX = -18, PosY = -9 }
	a.Nico_artillerybot_mechw_broken = a.MechUnit:new{Image="units/player/Nico_artillerybot_mech_w_broken.png", PosX = -18, PosY = -2 }
	a.Nico_artillerybot_mech_ns = a.MechIcon:new{Image="units/player/Nico_artillerybot_mech_ns.png"}

    -- locate our mech assets.
local lasermechPath = path .."img/units/player/"
-- make a list of our files.
local files = {
	"Nico_laserbot_mech.png",
	"Nico_laserbot_mech_a.png",
	"Nico_laserbot_mech_w.png",
	"Nico_laserbot_mech_w_broken.png",
	"Nico_laserbot_mech_broken.png",
	"Nico_laserbot_mech_ns.png",
	"Nico_laserbot_mech_h.png",
}
for _, file in ipairs(files) do
	modApi:appendAsset("img/units/player/".. file, lasermechPath .. file)
end
local a=ANIMS
	a.Nico_laserbot_mech =a.MechUnit:new{Image="units/player/Nico_laserbot_mech.png", PosX = -15, PosY = -2}
	a.Nico_laserbot_mecha = a.MechUnit:new{Image="units/player/Nico_laserbot_mech_a.png",  PosX = -15, PosY = -2, NumFrames = 4 }
	a.Nico_laserbot_mechw = a.MechUnit:new{Image="units/player/Nico_laserbot_mech_w.png", -15, PosY = 4}
	a.Nico_laserbot_mech_broken = a.MechUnit:new{Image="units/player/Nico_laserbot_mech_broken.png", PosX = -15, PosY = -2 }
	a.Nico_laserbot_mechw_broken = a.MechUnit:new{Image="units/player/Nico_laserbot_mech_w_broken.png", PosX = -15, PosY = 4 }
	a.Nico_laserbot_mech_ns = a.MechIcon:new{Image="units/player/Nico_laserbot_mech_ns.png"}

    -- locate our mech assets.
local cannonmechPath = path .."img/units/player/"
-- make a list of our files.
local files = {
	"Nico_cannonbot_mech.png",
	"Nico_cannonbot_mech_a.png",
	"Nico_cannonbot_mech_w.png",
	"Nico_cannonbot_mech_w_broken.png",
	"Nico_cannonbot_mech_broken.png",
	"Nico_cannonbot_mech_ns.png",
	"Nico_cannonbot_mech_h.png",
}
for _, file in ipairs(files) do
	modApi:appendAsset("img/units/player/".. file, cannonmechPath .. file)
end
local a=ANIMS

	a.Nico_cannonbot_mech =a.MechUnit:new{Image="units/player/Nico_cannonbot_mech.png", PosX = -20, PosY = 4}
	a.Nico_cannonbot_mecha = a.MechUnit:new{Image="units/player/Nico_cannonbot_mech_a.png",  PosX = -20, PosY = -4, NumFrames = 3 }
	a.Nico_cannonbot_mechw = a.MechUnit:new{Image="units/player/Nico_cannonbot_mech_w.png", -17, PosY = 2}
	a.Nico_cannonbot_mech_broken = a.MechUnit:new{Image="units/player/Nico_cannonbot_mech_broken.png", PosX = -20, PosY = -4 }
	a.Nico_cannonbot_mechw_broken = a.MechUnit:new{Image="units/player/Nico_cannonbot_mech_w_broken.png", PosX = -20, PosY = 2 }
	a.Nico_cannonbot_mech_ns = a.MechIcon:new{Image="units/player/Nico_cannonbot_mech_ns.png"}

-- locate our mech assets.
local knightmechPath = path .."img/units/player/"
-- make a list of our files.
local files = {
	"Nico_knightbot_mech.png",
	"Nico_knightbot_mech_a.png",
	"Nico_knightbot_mech_w.png",
	"Nico_knightbot_mech_w_broken.png",
	"Nico_knightbot_mech_broken.png",
	"Nico_knightbot_mech_ns.png",
	"Nico_knightbot_mech_h.png",
}
for _, file in ipairs(files) do
	modApi:appendAsset("img/units/player/".. file, artmechPath .. file)
end
local a=ANIMS
	a.Nico_knightbot_mech =a.MechUnit:new{Image="units/player/Nico_knightbot_mech.png", PosX = -24, PosY = -7}
	a.Nico_knightbot_mecha = a.MechUnit:new{Image="units/player/Nico_knightbot_mech_a.png",  PosX = -24, PosY = -7, NumFrames = 4 }
	a.Nico_knightbot_mechw = a.MechUnit:new{Image="units/player/Nico_knightbot_mech_w.png", -24, PosY = 0}
	a.Nico_knightbot_mech_broken = a.MechUnit:new{Image="units/player/Nico_knightbot_mech_broken.png", PosX = -24, PosY = -7 }
	a.Nico_knightbot_mechw_broken = a.MechUnit:new{Image="units/player/Nico_knightbot_mech_w_broken.png", PosX = -24, PosY = 0 }
	a.Nico_knightbot_mech_ns = a.MechIcon:new{Image="units/player/Nico_knightbot_mech_ns.png"}

-- locate our mech assets.
local shieldmechPath = path .."img/units/player/"
-- make a list of our files.
local files = {
	"Nico_shieldbot_mech.png",
	"Nico_shieldbot_mech_a.png",
	"Nico_shieldbot_mech_w.png",
	"Nico_shieldbot_mech_w_broken.png",
	"Nico_shieldbot_mech_broken.png",
	"Nico_shieldbot_mech_ns.png",
	"Nico_shieldbot_mech_h.png",
}
for _, file in ipairs(files) do
	modApi:appendAsset("img/units/player/".. file, shieldmechPath .. file)
end
local a=ANIMS
	a.Nico_shieldbot_mech =a.MechUnit:new{Image="units/player/Nico_shieldbot_mech.png", PosX = -18, PosY = -8}
	a.Nico_shieldbot_mecha = a.MechUnit:new{Image="units/player/Nico_shieldbot_mech_a.png",  PosX = -16, PosY = -8, NumFrames = 4 }
	a.Nico_shieldbot_mechw = a.MechUnit:new{Image="units/player/Nico_shieldbot_mech_w.png", -16, PosY = -1}
	a.Nico_shieldbot_mech_broken = a.MechUnit:new{Image="units/player/Nico_shieldbot_mech_broken.png", PosX = -17, PosY = 0 }
	a.Nico_shieldbot_mechw_broken = a.MechUnit:new{Image="units/player/Nico_shieldbot_mech_w_broken.png", PosX = -18, PosY = 10 }
	a.Nico_shieldbot_mech_ns = a.MechIcon:new{Image="units/player/Nico_shieldbot_mech_ns.png"}

-- locate our mech assets.
local minermechPath = path .."img/units/player/"
-- make a list of our files.
local files = {
	"Nico_minerbot_mech.png",
	"Nico_minerbot_mech_a.png",
	"Nico_minerbot_mech_w.png",
	"Nico_minerbot_mech_w_broken.png",
	"Nico_minerbot_mech_broken.png",
	"Nico_minerbot_mech_ns.png",
	"Nico_minerbot_mech_h.png",
}
for _, file in ipairs(files) do
	modApi:appendAsset("img/units/player/".. file, minermechPath .. file)
end
local a=ANIMS
	a.Nico_minerbot_mech =a.MechUnit:new{Image="units/player/Nico_minerbot_mech.png", PosX = -12, PosY = -9}
	a.Nico_minerbot_mecha = a.MechUnit:new{Image="units/player/Nico_minerbot_mech_a.png",  PosX = -20, PosY = 4, NumFrames = 4 }
	a.Nico_minerbot_mechw = a.MechUnit:new{Image="units/player/Nico_minerbot_mech_w.png", PosX = -15, PosY = -2}
	a.Nico_minerbot_mech_broken = a.MechUnit:new{Image="units/player/Nico_minerbot_mech_broken.png", PosX = -15, PosY = 0 }
	a.Nico_minerbot_mechw_broken = a.MechUnit:new{Image="units/player/Nico_minerbot_mech_w_broken.png", PosX = -15, PosY = 0 }
	a.Nico_minerbot_mech_ns = a.MechIcon:new{Image="units/player/Nico_minerbot_mech_ns.png"}
    
    modApi:addPalette{
        id = "nico_snow",
        image="units/player/Nico_artillerybot_mech_ns.png",
        name = "Sentient Weapon's Light Blue & Silver",
        colorMap = {
            PlateHighlight = {255,  14,  19},
            PlateLight     = {100, 151, 143},
            PlateMid       = { 50,  71,  88},
            PlateDark      = { 31,  34,  46},
            PlateOutline   = { 17,  17,  18},
            PlateShadow    = { 74,  76,  80},
            BodyColor      = {125, 135, 144},
            BodyHighlight  = {208, 213, 217},
        },
    }
    modApi:addPalette{
        ID = "nico_alpha_snow",
        image="units/player/Nico_knightbot_mech_ns.png",
        Name = "Sentient Weapon's Pink & Black",
        PlateHighlight = {255,  14,  19},
        PlateLight     = {181, 165, 216},
        PlateMid       = {151,  88, 153},
        PlateDark      = { 74,  58,  66},
        PlateOutline   = { 27,  25,  27},
        PlateShadow    = { 41,  50,  48},
        BodyColor      = { 71,  92,  85},
        BodyHighlight  = {137, 162, 153},
    }

local oldGetSkillInfo = GetSkillInfo
	function GetSkillInfo(skill)
       
	if NicoIsRobot then
		NicoIsRobot = nil
		if skill == "Survive_Death"    then
			return PilotSkill("Robot", "Normal Pilots cannot be equipped. Loses 25 XP when the unit is disabled.")
		end
	end
	return oldGetSkillInfo(skill)
end

CreatePilot{
 	Id = "Pilot_Nico_laserbot_mech",
    Personality = "Vek",
	Sex = SEX_VEK,
    Name = "Laser-Bot",
    GetSkill = function() NicoIsRobot = true; return "Survive_Death" end,
	Rarity = 0,
    Blacklist = {"Invulnerable","Thick","Popular","Grid","Health","Skilled","Regen","Pain"},
}
CreatePilot{
    Id = "Pilot_Nico_cannonbot_mech",
    Personality = "Vek",
    Sex = SEX_VEK,
    Name = "Cannon-Bot",
    GetSkill = function() NicoIsRobot = true; return "Survive_Death" end,
    Rarity = 0,
    Blacklist = {"Invulnerable","Thick","Popular","Grid","Health","Skilled","Regen","Pain"},
}
CreatePilot{
    Id = "Pilot_Nico_artillerybot_mech",
  	Personality = "Vek",
	Sex = SEX_VEK,
    Name = "Artillery-Bot",
    GetSkill = function() NicoIsRobot = true; return "Survive_Death" end,
	Rarity = 0,
    Blacklist = {"Invulnerable","Thick","Popular","Grid","Health","Skilled","Regen","Pain"},
}
CreatePilot{
    Id = "Pilot_Nico_knightbot_mech",
  	Personality = "Vek",
	Sex = SEX_VEK,
    Name = "Knight-Bot",
    GetSkill = function() NicoIsRobot = true; return "Survive_Death" end,
	Rarity = 0,
    Blacklist = {"Invulnerable","Thick","Popular","Grid","Health","Skilled","Regen","Pain"},
}
CreatePilot{
    Id = "Pilot_Nico_shieldbot_mech",
  	Personality = "Vek",
	Sex = SEX_VEK,
    Name = "Shield-Bot",
    GetSkill = function() NicoIsRobot = true; return "Survive_Death" end,
	Rarity = 0,
    Blacklist = {"Invulnerable","Thick","Popular","Grid","Health","Skilled","Regen","Pain"},
}
CreatePilot{
    Id = "Pilot_Nico_minerbot_mech",
  	Personality = "Vek",
	Sex = SEX_VEK,
    Name = "Shield-Bot",
    GetSkill = function() NicoIsRobot = true; return "Survive_Death" end,
	Rarity = 0,
    Blacklist = {"Invulnerable","Thick","Popular","Grid","Health","Skilled","Regen","Pain"},
}
Nico_laserbot_mech = Pawn:new{
    Name = "Laser-Bot",
    NicoIsRobot = true,
    -- FlameMech is also Prime, so this is redundant, but if you had no base, you would need a class.
    Class = "TechnoVek",
    
    -- various stats.
    Health = 1,
    MoveSpeed = 4,
    Massive = true,
    Corpse = true,
    
    -- reference the animations we set up earlier.
    Image = "Nico_laserbot_mech",
    
    -- ImageOffset specifies which color scheme we will be using.
    -- (only apporpirate if you draw your mechs with Archive olive green colors)
	ImageOffset = modApi:getPaletteImageOffset("nico_snow"),
    
    -- Any weapons this mech should start with goes in this table.
    SkillList = {"Nico_laserbot"},
    
    -- movement sounds.
	SoundLocation = "/enemy/snowlaser_1/",
    
    -- who will be controlling this unit.
    DefaultTeam = TEAM_PLAYER,
    
    -- impact sounds.
	ImpactMaterial = IMPACT_METAL,
    
    AddPawn("Nico_laserbot_mech")
}
Nico_artillerybot_mech = Pawn:new{
    Name = "Artillery-Bot",
    NicoIsRobot = true,
    -- FlameMech is also Prime, so this is redundant, but if you had no base, you would need a class.
    Class = "TechnoVek",
    
    -- various stats.
    Health = 1,
    MoveSpeed = 3,
    Massive = true,
    Corpse = true,
    
    -- reference the animations we set up earlier.
    Image = "Nico_artillerybot_mech",
    
    -- ImageOffset specifies which color scheme we will be using.
    -- (only apporpirate if you draw your mechs with Archive olive green colors)
	ImageOffset = modApi:getPaletteImageOffset("nico_snow"),
    
    -- Any weapons this mech should start with goes in this table.
    SkillList = {"Nico_artillerybot"},
    
    -- movement sounds.
    SoundLocation = "/enemy/snowart_1/",
    
    -- who will be controlling this unit.
    DefaultTeam = TEAM_PLAYER,
    
    -- impact sounds.
	ImpactMaterial = IMPACT_METAL,
    
    AddPawn("Nico_artillerybot_mech")
}
Nico_cannonbot_mech = Pawn:new{
    Name = "Cannon-Bot",
    NicoIsRobot = true,
    -- FlameMech is also Prime, so this is redundant, but if you had no base, you would need a class.
    Class = "TechnoVek",
    
    -- various stats.
    Health = 1,
    MoveSpeed = 3,
    Massive = true,
    Corpse = true,
    
    -- reference the animations we set up earlier.
    Image = "Nico_cannonbot_mech",
    
    -- ImageOffset specifies which color scheme we will be using.
    -- (only apporpirate if you draw your mechs with Archive olive green colors)
    ImageOffset = modApi:getPaletteImageOffset("nico_snow"),
    
    -- Any weapons this mech should start with goes in this table.
    SkillList = {"Nico_cannonbot"},
    
    -- movement sounds.
	SoundLocation = "/enemy/snowtank_1/",
    
    -- who will be controlling this unit.
    DefaultTeam = TEAM_PLAYER,
    
    -- impact sounds.
	ImpactMaterial = IMPACT_METAL,
    
    AddPawn("Nico_cannonbot_mech")
}
Nico_knightbot_mech = Pawn:new{
    Name = "Knight-Bot",
    NicoIsRobot = true,
    -- FlameMech is also Prime, so this is redundant, but if you had no base, you would need a class.
    Class = "TechnoVek",

    -- various stats.
    Health = 1,
    MoveSpeed = 3,
    Massive = true,
    Corpse = true,
    Armor = true,

    -- reference the animations we set up earlier.
    Image = "Nico_knightbot_mech",

    -- ImageOffset specifies which color scheme we will be using.
    -- (only apporpirate if you draw your mechs with Archive olive green colors)
    ImageOffset = modApi:getPaletteImageOffset("nico_alpha_snow"),

    -- Any weapons this mech should start with goes in this table.
    SkillList = {"Nico_knightbot"},

    -- movement sounds.
	SoundLocation = "/enemy/snowlaser_1/",
   
    -- who will be controlling this unit.
    DefaultTeam = TEAM_PLAYER,
    
    -- impact sounds.
	ImpactMaterial = IMPACT_METAL,
    
    AddPawn("Nico_knightbot_mech")
}
Nico_shieldbot_mech = Pawn:new{
    Name = "Shield-Bot",
    NicoIsRobot = true,
    -- FlameMech is also Prime, so this is redundant, but if you had no base, you would need a class.
    Class = "TechnoVek",
    
    -- various stats.
    Health = 1,
    MoveSpeed = 4,
    Massive = true,
    Corpse = true,
    Flying=true,
    
    -- reference the animations we set up earlier.
    Image = "Nico_shieldbot_mech",
    
    -- ImageOffset specifies which color scheme we will be using.
    -- (only apporpirate if you draw your mechs with Archive olive green colors)
    ImageOffset = modApi:getPaletteImageOffset("nico_alpha_snow"),
    
    -- Any weapons this mech should start with goes in this table.
    SkillList = {"Nico_shieldbot"},
    
    -- movement sounds.
	SoundLocation = "/enemy/snowlaser_1/",
    
    -- who will be controlling this unit.
    DefaultTeam = TEAM_PLAYER,
    
    -- impact sounds.
	ImpactMaterial = IMPACT_METAL,
    
    AddPawn("Nico_shieldbot_mech")
}
Nico_minerbot_mech = Pawn:new{
    Name = "Mine-Bot",
    NicoIsRobot = true,
    -- FlameMech is also Prime, so this is redundant, but if you had no base, you would need a class.
    Class = "TechnoVek",
    
    -- various stats.
    Health = 1,
    MoveSpeed = 4,
    Massive = true,
    Corpse = true,
    
    -- reference the animations we set up earlier.
    Image = "Nico_minerbot_mech",
    
    -- ImageOffset specifies which color scheme we will be using.
    -- (only apporpirate if you draw your mechs with Archive olive green colors)
	ImageOffset = modApi:getPaletteImageOffset("nico_alpha_snow"),
    
    -- Any weapons this mech should start with goes in this table.
    SkillList = {"Nico_minerbot"},
    
    -- movement sounds.
    SoundLocation = "/enemy/snowmine_1/",
    
    -- who will be controlling this unit.
    DefaultTeam = TEAM_PLAYER,
    
    -- impact sounds.
	ImpactMaterial = IMPACT_METAL,
    
    AddPawn("Nico_minerbot_mech")
}

modApi:appendAsset("img/icon_Nico_zenith_shield.png", path.."img/icon_Nico_zenith_shield.png")--image of the trait
local mod = modApi:getCurrentMod()--the mod itself
local trait = require(mod.scriptPath .."libs/trait")--where does it get the code for the rest of this to work

Nico_Pawn_List = {"Nico_laserbot_mech", "Nico_cannonbot_mech", "Nico_artillerybot_mech", "Nico_knightbot_mech", "Nico_shieldbot_mech","Nico_minerbot_mech"}

for i = 1,6 do
	trait:add{
		pawnType=Nico_Pawn_List[i],--who will get the trait
		icon = "img/icon_Nico_zenith_shield.png",--the icon itself
		icon_offset = Point(0,9),--it's location
		desc_title = "Zenith\'s Guard",--title
		desc_text = "Gains a shield when moving next to another Mech. Bots can repair other adjacent Bots.",--description
	}
end

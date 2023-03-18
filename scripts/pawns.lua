local path = GetParentPath(...)
require(path.."palette")
local mod = modApi:getCurrentMod()
local imageOffset = modApi:getPaletteImageOffset(mod.id)

-- this line just gets the file path for your mod, so you can find all your files easily.
local path = mod_loader.mods[modApi.currentMod].resourcePath
	modApi:appendAsset("img/portraits/pilots/Pilot_Nico_artillerybot_mech.png", path .."img/portraits/Pilot_Nico_artillerybot_mech.png")
	modApi:appendAsset("img/portraits/pilots/Pilot_Nico_laserbot_mech.png", path .."img/portraits/Pilot_Nico_laserbot_mech.png")
	modApi:appendAsset("img/portraits/pilots/Pilot_Nico_cannonbot_mech.png", path .."img/portraits/Pilot_Nico_cannonbot_mech.png")
    modApi:appendAsset("img/portraits/pilots/Pilot_Nico_knightbot_mech.png", path .."img/portraits/Pilot_Nico_knightbot_mech.png")
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
	a.Nico_knightbot_mech =a.MechUnit:new{Image="units/player/Nico_knightbot_mech.png", PosX = -18, PosY = -9}
	a.Nico_knightbot_mecha = a.MechUnit:new{Image="units/player/Nico_knightbot_mech_a.png",  PosX = -18, PosY = -9, NumFrames = 4 }
	a.Nico_knightbot_mechw = a.MechUnit:new{Image="units/player/Nico_knightbot_mech_w.png", -18, PosY = -2}
	a.Nico_knightbot_mech_broken = a.MechUnit:new{Image="units/player/Nico_knightbot_mech_broken.png", PosX = -18, PosY = -9 }
	a.Nico_knightbot_mechw_broken = a.MechUnit:new{Image="units/player/Nico_knightbot_mech_w_broken.png", PosX = -18, PosY = -2 }
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
	a.Nico_shieldbot_mech =a.MechUnit:new{Image="units/player/Nico_shieldbot_mech.png", PosX = -18, PosY = -9}
	a.Nico_shieldbot_mecha = a.MechUnit:new{Image="units/player/Nico_shieldbot_mech_a.png",  PosX = -18, PosY = -9, NumFrames = 4 }
	a.Nico_shieldbot_mechw = a.MechUnit:new{Image="units/player/Nico_shieldbot_mech_w.png", -18, PosY = -2}
	a.Nico_shieldbot_mech_broken = a.MechUnit:new{Image="units/player/Nico_shieldbot_mech_broken.png", PosX = -18, PosY = -9 }
	a.Nico_shieldbot_mechw_broken = a.MechUnit:new{Image="units/player/Nico_shieldbot_mech_w_broken.png", PosX = -18, PosY = -2 }
	a.Nico_shieldbot_mech_ns = a.MechIcon:new{Image="units/player/Nico_shieldbot_mech_ns.png"}


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
    Blacklist = {"Invulnerable", "Popular","Grid","Health","Skilled"},
}
CreatePilot{
    Id = "Pilot_Nico_cannonbot_mech",
    Personality = "Vek",
    Sex = SEX_VEK,
    Name = "Cannon-Bot",
    GetSkill = function() NicoIsRobot = true; return "Survive_Death" end,
    Rarity = 0,
    Blacklist = {"Invulnerable", "Popular","Grid","Health","Skilled"},
}
CreatePilot{
    Id = "Pilot_Nico_artillerybot_mech",
  	Personality = "Vek",
	Sex = SEX_VEK,
    Name = "Artillery-Bot",
    GetSkill = function() NicoIsRobot = true; return "Survive_Death" end,
	Rarity = 0,
    Blacklist = {"Invulnerable", "Popular","Grid","Health","Skilled"},
}
CreatePilot{
    Id = "Pilot_Nico_knightbot_mech",
  	Personality = "Vek",
	Sex = SEX_VEK,
    Name = "Knight-Bot",
    GetSkill = function() NicoIsRobot = true; return "Survive_Death" end,
	Rarity = 0,
    Blacklist = {"Invulnerable", "Popular","Grid","Health","Skilled"},
}
CreatePilot{
    Id = "Pilot_Nico_shieldbot_mech",
  	Personality = "Vek",
	Sex = SEX_VEK,
    Name = "Shield-Bot",
    GetSkill = function() NicoIsRobot = true; return "Survive_Death" end,
	Rarity = 0,
    Blacklist = {"Invulnerable", "Popular","Grid","Health","Skilled"},
}
Nico_laserbot_mech = Pawn:new{
    Name = "Laser-Bot",
    NicoIsRobot = true;
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
	ImageOffset = imageOffset,
    
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
    NicoIsRobot = true;
    -- FlameMech is also Prime, so this is redundant, but if you had no base, you would need a class.
    Class = "TechnoVek",
    
    -- various stats.
    Health = 1,
    MoveSpeed = 4,
    Massive = true,
    Corpse = true,
    
    -- reference the animations we set up earlier.
    Image = "Nico_artillerybot_mech",
    
    -- ImageOffset specifies which color scheme we will be using.
    -- (only apporpirate if you draw your mechs with Archive olive green colors)
	ImageOffset = imageOffset,
    
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
    NicoIsRobot = true;
    -- FlameMech is also Prime, so this is redundant, but if you had no base, you would need a class.
    Class = "TechnoVek",
    
    -- various stats.
    Health = 1,
    MoveSpeed = 4,
    Massive = true,
    Corpse = true,
    
    -- reference the animations we set up earlier.
    Image = "Nico_cannonbot_mech",
    
    -- ImageOffset specifies which color scheme we will be using.
    -- (only apporpirate if you draw your mechs with Archive olive green colors)
	ImageOffset = imageOffset,
    
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
    NicoIsRobot = true;
    -- FlameMech is also Prime, so this is redundant, but if you had no base, you would need a class.
    Class = "TechnoVek",

    -- various stats.
    Health = 1,
    MoveSpeed = 4,
    Massive = true,
    Corpse = true,
    Armor = true,

    -- reference the animations we set up earlier.
    Image = "Nico_knightbot_mech",

    -- ImageOffset specifies which color scheme we will be using.
    -- (only apporpirate if you draw your mechs with Archive olive green colors)
	ImageOffset = imageOffset,

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
    NicoIsRobot = true;
    -- FlameMech is also Prime, so this is redundant, but if you had no base, you would need a class.
    Class = "TechnoVek",
    
    -- various stats.
    Health = 1,
    MoveSpeed = 5,
    Massive = true,
    Corpse = true,
    Flying=true,
    
    -- reference the animations we set up earlier.
    Image = "Nico_shieldbot_mech",
    
    -- ImageOffset specifies which color scheme we will be using.
    -- (only apporpirate if you draw your mechs with Archive olive green colors)
	ImageOffset = imageOffset,
    
    -- Any weapons this mech should start with goes in this table.
    SkillList = {"Nico_laserbot"},
    
    -- movement sounds.
	SoundLocation = "/enemy/snowlaser_1/",
    
    -- who will be controlling this unit.
    DefaultTeam = TEAM_PLAYER,
    
    -- impact sounds.
	ImpactMaterial = IMPACT_METAL,
    
    AddPawn("Nico_shieldbot_mech")
}
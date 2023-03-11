local path = GetParentPath(...)
require(path.."palette")
local mod = modApi:getCurrentMod()
local imageOffset = modApi:getPaletteImageOffset(mod.id)

-- this line just gets the file path for your mod, so you can find all your files easily.
local path = mod_loader.mods[modApi.currentMod].resourcePath
	modApi:appendAsset("img/portraits/pilot_Nico_artillerybot_mech.png", path .."img/portraits/pilot_Nico_artillerybot_mech.png")
	modApi:appendAsset("img/portraits/pilot_Nico_laserbot_mech.png", path .."img/portraits/pilot_Nico_laserbot_mech.png")
	modApi:appendAsset("img/portraits/pilot_Nico_cannonbot_mech.png", path .."img/portraits/pilot_Nico_cannonbot_mech.png")
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
	a.Nico_artillerybot_mech =a.MechUnit:new{Image="units/player/Nico_artillerybot_mech.png", PosX = -22, PosY = 4}
	a.Nico_artillerybot_mecha = a.MechUnit:new{Image="units/player/Nico_artillerybot_mech_a.png",  PosX = -20, PosY = 4, NumFrames = 4 }
	a.Nico_artillerybot_mechw = a.MechUnit:new{Image="units/player/Nico_artillerybot_mech_w.png", -22, PosY = 10}
	a.Nico_artillerybot_mech_broken = a.MechUnit:new{Image="units/player/Nico_artillerybot_mech_broken.png", PosX = -22, PosY = 4 }
	a.Nico_artillerybot_mechw_broken = a.MechUnit:new{Image="units/player/Nico_artillerybot_mech_w_broken.png", PosX = -20, PosY = 10 }
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
	"Nico_laser_mech_ns.png",
	"Nico_laser_mech_h.png",
}
for _, file in ipairs(files) do
	modApi:appendAsset("img/units/player/".. file, lasermechPath .. file)
end
local a=ANIMS
	a.Nico_laserbot_mech =a.MechUnit:new{Image="units/player/Nico_laserbot_mech.png", PosX = -22, PosY = 4}
	a.Nico_laserbot_mecha = a.MechUnit:new{Image="units/player/Nico_laserbot_mech_a.png",  PosX = -20, PosY = 4, NumFrames = 3 }
	a.Nico_laserbot_mechw = a.MechUnit:new{Image="units/player/Nico_laserbot_mech_w.png", -22, PosY = 10}
	a.Nico_laserbot_mech_broken = a.MechUnit:new{Image="units/player/Nico_laserbot_mech_broken.png", PosX = -22, PosY = 4 }
	a.Nico_laserbot_mechw_broken = a.MechUnit:new{Image="units/player/Nico_laserbot_mech_w_broken.png", PosX = -20, PosY = 10 }
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
	a.Nico_cannonbot_mech =a.MechUnit:new{Image="units/player/Nico_cannonbot_mech.png", PosX = -22, PosY = 4}
	a.Nico_cannonbot_mecha = a.MechUnit:new{Image="units/player/Nico_cannonbot_mech_a.png",  PosX = -20, PosY = 4, NumFrames = 4 }
	a.Nico_cannonbot_mechw = a.MechUnit:new{Image="units/player/Nico_cannonbot_mech_w.png", -22, PosY = 10}
	a.Nico_cannonbot_mech_broken = a.MechUnit:new{Image="units/player/Nico_cannonbot_mech_broken.png", PosX = -22, PosY = 4 }
	a.Nico_cannonbot_mechw_broken = a.MechUnit:new{Image="units/player/Nico_cannonbot_mech_w_broken.png", PosX = -20, PosY = 10 }
	a.Nico_cannonbot_mech_ns = a.MechIcon:new{Image="units/player/Nico_cannonbot_mech_ns.png"}


local oldGetSkillInfo = GetSkillInfo
	function GetSkillInfo(skill)
	if IsRobot then
		IsRobot = nil
		if skill == "Survive_Death"    then
			return PilotSkill("Robot", "Normal Pilots cannot be equipped. Loses 25 XP when the unit is disabled.")
		end
	end
	return oldGetSkillInfo(skill)
end

CreatePilot{
 	Id = "pilot_Nico_laserbot_mech",
    Personality = "Vek",
	Sex = SEX_VEK,
    Name = "LAS-891",
    GetSkill = function() IsRobot = true; return "Survive_Death" end,
	Rarity = 0,
    Blacklist = {"Invulnerable", "Popular","Grid"},
}
CreatePilot{
    Id = "pilot_Nico_cannonbot_mech",
    Personality = "Vek",
    Sex = SEX_VEK,
    Name = "C4NN0N-GRU",
    GetSkill = function() IsRobot = true; return "Survive_Death" end,
    Rarity = 0,
    Blacklist = {"Invulnerable", "Popular","Grid"},
}
CreatePilot{
    Id = "pilot_Nico_artillerybot_mech",
  	Personality = "Vek",
	Sex = SEX_VEK,
  	Name = "B4RRAG-UNI7",
  	GetSkill = function() IsRobot = true; return "Survive_Death" end,
	Rarity = 0,
}

Nico_laserbot_mech = Pawn:new{
    Name = "Laser-Bot",
    
    -- FlameMech is also Prime, so this is redundant, but if you had no base, you would need a class.
    Class = "TechnoVek",
    
    -- various stats.
    Health = 3,
    MoveSpeed = 4,
    Massive = true,
    Corpse = true,
    
    -- reference the animations we set up earlier.
    Image = "Nico_laserbot_mech",
    
    -- ImageOffset specifies which color scheme we will be using.
    -- (only apporpirate if you draw your mechs with Archive olive green colors)
	ImageOffset = imageOffset,
    
    -- Any weapons this mech should start with goes in this table.
    SkillList = {"Prime_Lasermech"},
    
    -- movement sounds.
	SoundLocation = "/enemy/snowlaser_1/",
    
    -- who will be controlling this unit.
    DefaultTeam = TEAM_PLAYER,
    
    -- impact sounds.
    ImpactMaterial = IMPACT_INSECT,
    
    AddPawn("Nico_laserbot_mech")
}
Nico_artillerybot_mech = Pawn:new{
    Name = "Artyllery-Bot",
    
    -- FlameMech is also Prime, so this is redundant, but if you had no base, you would need a class.
    Class = "TechnoVek",
    
    -- various stats.
    Health = 3,
    MoveSpeed = 4,
    Massive = true,
    Corpse = true,
    
    -- reference the animations we set up earlier.
    Image = "Nico_artillerybot_mech",
    
    -- ImageOffset specifies which color scheme we will be using.
    -- (only apporpirate if you draw your mechs with Archive olive green colors)
	ImageOffset = imageOffset,
    
    -- Any weapons this mech should start with goes in this table.
    SkillList = {"Prime_Lasermech"},
    
    -- movement sounds.
    SoundLocation = "/enemy/snowart_1/",
    
    -- who will be controlling this unit.
    DefaultTeam = TEAM_PLAYER,
    
    -- impact sounds.
    ImpactMaterial = IMPACT_INSECT,
    
    AddPawn("Nico_artillerybot_mech")
}
Nico_cannonbot_mech = Pawn:new{
    Name = "Cannon-Bot",
    
    -- FlameMech is also Prime, so this is redundant, but if you had no base, you would need a class.
    Class = "TechnoVek",
    
    -- various stats.
    Health = 3,
    MoveSpeed = 4,
    Massive = true,
    Corpse = true,
    
    -- reference the animations we set up earlier.
    Image = "Nico_cannonbot_mech",
    
    -- ImageOffset specifies which color scheme we will be using.
    -- (only apporpirate if you draw your mechs with Archive olive green colors)
	ImageOffset = imageOffset,
    
    -- Any weapons this mech should start with goes in this table.
    SkillList = {"Prime_Lasermech"},
    
    -- movement sounds.
	SoundLocation = "/enemy/snowtank_1/",
    
    -- who will be controlling this unit.
    DefaultTeam = TEAM_PLAYER,
    
    -- impact sounds.
    ImpactMaterial = IMPACT_INSECT,
    
    AddPawn("Nico_cannonbot_mech")
}
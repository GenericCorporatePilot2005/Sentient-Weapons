local mod = modApi:getCurrentMod()

--portraits
    local path = mod_loader.mods[modApi.currentMod].resourcePath
	modApi:appendAsset("img/portraits/pilots/Pilot_Nico_artillerybot_mech.png", path .."img/portraits/Pilot_Nico_artillerybot_mech.png")
	modApi:appendAsset("img/portraits/pilots/Pilot_Nico_laserbot_mech.png", path .."img/portraits/Pilot_Nico_laserbot_mech.png")
	modApi:appendAsset("img/portraits/pilots/Pilot_Nico_cannonbot_mech.png", path .."img/portraits/Pilot_Nico_cannonbot_mech.png")
    modApi:appendAsset("img/portraits/pilots/Pilot_Nico_knightbot_mech.png", path .."img/portraits/Pilot_Nico_knightbot_mech.png")
    modApi:appendAsset("img/portraits/pilots/Pilot_Nico_shieldbot_mech.png", path .."img/portraits/Pilot_Nico_shieldbot_mech.png")
    modApi:appendAsset("img/portraits/pilots/Pilot_Nico_minerbot_mech.png", path .."img/portraits/Pilot_Nico_minerbot_mech.png")
    modApi:appendAsset("img/portraits/pilots/Pilot_Nico_juggernautbot_mech.png", path .."img/portraits/Pilot_Nico_juggernautbot_mech.png")
    modApi:appendAsset("img/portraits/pilots/Pilot_Nico_botleader_mech.png", path .."img/portraits/Pilot_Nico_botleader_mech.png")

--pilots
    CreatePilot{
        Id = "Pilot_Nico_laserbot_mech",
       Personality = "Artificial",
       Sex = SEX_VEK,
       Name = "Laser-Bot",
       GetSkill = function() NicoIsRobot = true; return "Survive_Death" end,
       Rarity = 0,
       Blacklist = {"Invulnerable","Thick","Popular","Health","Skilled","Regen","Pain"},
   }
   CreatePilot{
       Id = "Pilot_Nico_cannonbot_mech",
       Personality = "Artificial",
       Sex = SEX_VEK,
       Name = "Cannon-Bot",
       GetSkill = function() NicoIsRobot = true; return "Survive_Death" end,
       Rarity = 0,
       Blacklist = {"Invulnerable","Thick","Popular","Health","Skilled","Regen","Pain"},
   }
   CreatePilot{
       Id = "Pilot_Nico_artillerybot_mech",
         Personality = "Artificial",
       Sex = SEX_VEK,
       Name = "Artillery-Bot",
       GetSkill = function() NicoIsRobot = true; return "Survive_Death" end,
       Rarity = 0,
       Blacklist = {"Invulnerable","Thick","Popular","Health","Skilled","Regen","Pain"},
   }
   CreatePilot{
       Id = "Pilot_Nico_knightbot_mech",
         Personality = "Artificial",
       Sex = SEX_VEK,
       Name = "Knight-Bot",
       GetSkill = function() NicoIsRobot = true; return "Survive_Death" end,
       Rarity = 0,
       Blacklist = {"Invulnerable","Thick","Popular","Health","Skilled","Regen","Pain"},
   }
   CreatePilot{
       Id = "Pilot_Nico_shieldbot_mech",
         Personality = "Artificial",
       Sex = SEX_VEK,
       Name = "Shield-Bot",
       GetSkill = function() NicoIsRobot = true; return "Survive_Death" end,
       Rarity = 0,
       Blacklist = {"Invulnerable","Thick","Popular","Health","Skilled","Regen","Pain"},
   }
   CreatePilot{
       Id = "Pilot_Nico_minerbot_mech",
         Personality = "Artificial",
       Sex = SEX_VEK,
       Name = "Mine-Bot",
       GetSkill = function() NicoIsRobot = true; return "Survive_Death" end,
       Rarity = 0,
       Blacklist = {"Invulnerable","Thick","Popular","Health","Skilled","Regen","Pain"},
   }
   CreatePilot{
       Id = "Pilot_Nico_juggernautbot_mech",
         Personality = "Artificial",
       Sex = SEX_VEK,
       Name = "Juggernaut-Bot",
       GetSkill = function() NicoIsRobot = true; return "Survive_Death" end,
       Rarity = 0,
       Blacklist = {"Invulnerable","Popular","Health","Skilled","Regen","Pain"},
   }
   CreatePilot{
       Id = "Pilot_Nico_botleader_mech",
       Name = "Bot Leader",
       Personality = "Artificial",
       Sex = SEX_VEK,
       GetSkill = function() NicoIsRobot = true; return "Survive_Death" end,
       Rarity = 0,
       Blacklist = {"Invulnerable","Popular","Health","Skilled"},
   }
--replacement for the skill's name and description
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
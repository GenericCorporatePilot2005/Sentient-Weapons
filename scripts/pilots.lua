local mod = modApi:getCurrentMod()
local scriptPath = modApi:getCurrentMod().scriptPath
local replaceRepair = require(scriptPath.."replaceRepair/replaceRepair")

--portraits
    local path = mod_loader.mods[modApi.currentMod].resourcePath
	modApi:appendAsset("img/portraits/pilots/Pilot_Nico_artillerybot_mech.png", path .."img/portraits/Pilot_Nico_artillerybot_mech.png")
	modApi:appendAsset("img/portraits/pilots/Pilot_Nico_laserbot_mech.png", path .."img/portraits/Pilot_Nico_laserbot_mech.png")
	modApi:appendAsset("img/portraits/pilots/Pilot_Nico_cannonbot_mech.png", path .."img/portraits/Pilot_Nico_cannonbot_mech.png")
    modApi:appendAsset("img/portraits/pilots/Pilot_Nico_knightbot_mech.png", path .."img/portraits/Pilot_Nico_knightbot_mech.png")
    modApi:appendAsset("img/portraits/pilots/Pilot_Nico_shieldbot_mech.png", path .."img/portraits/Pilot_Nico_shieldbot_mech.png")
    modApi:appendAsset("img/portraits/pilots/Pilot_Nico_minerbot_mech.png", path .."img/portraits/Pilot_Nico_minerbot_mech.png")
    modApi:appendAsset("img/portraits/pilots/Pilot_Nico_artilleryboom_mech.png", path .."img/portraits/Pilot_Nico_artilleryboom_mech.png")
	modApi:appendAsset("img/portraits/pilots/Pilot_Nico_laserboom_mech.png", path .."img/portraits/Pilot_Nico_laserboom_mech.png")
	modApi:appendAsset("img/portraits/pilots/Pilot_Nico_cannonboom_mech.png", path .."img/portraits/Pilot_Nico_cannonboom_mech.png")
    modApi:appendAsset("img/portraits/pilots/Pilot_Nico_juggernautbot_mech.png", path .."img/portraits/Pilot_Nico_juggernautbot_mech.png")
    modApi:appendAsset("img/portraits/pilots/Pilot_Nico_botleader_mech.png", path .."img/portraits/Pilot_Nico_botleader_mech.png")
    modApi:appendAsset("img/portraits/pilots/Pilot_Nico_hulkbot_mech.png", path .."img/portraits/Pilot_Nico_hulkbot_mech.png")

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
        Id = "Pilot_Nico_laserboom_mech",
        Personality = "Artificial",
        Sex = SEX_VEK,
        Name = "Boom Laser",
        GetSkill = function() NicoIsRobot = true; return "Survive_Death" end,
        Rarity = 0,
        Blacklist = {"Invulnerable","Thick","Popular","Health","Skilled","Regen","Pain"},
    }
    CreatePilot{
        Id = "Pilot_Nico_cannonboom_mech",
        Personality = "Artificial",
        Sex = SEX_VEK,
        Name = "Boom Cannon",
        GetSkill = function() NicoIsRobot = true; return "Survive_Death" end,
        Rarity = 0,
        Blacklist = {"Invulnerable","Thick","Popular","Health","Skilled","Regen","Pain"},
    }
    CreatePilot{
        Id = "Pilot_Nico_artilleryboom_mech",
        Personality = "Artificial",
        Sex = SEX_VEK,
        Name = "Boom Artillery",
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
        Skill = "Nico_BotRepair",
        Rarity = 0,
        Blacklist = {"Invulnerable","Popular","Pain","Health"},
    }
    CreatePilot{
        Id = "Pilot_Nico_hulkbot_mech",
        Personality = "Artificial",
        Sex = SEX_VEK,
        Name = "Cryo-Hulk",
        GetSkill = function() NicoIsRobot = true; return "Survive_Death" end,
        Rarity = 0,
        Blacklist = {"Invulnerable","Popular"},
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
--Bot Leader's skill replacement

    local this={}
    function this:init(mod)

        replaceRepair:addSkill{
            Name = "Pinnacle Technologies",
            Description = "Repairing fully heals the Bot Leader, and Shields it.\nAt mission start, deploy a number of Cannon Bots equal to pilot level.\nRevives when dead at the end of a battle.",
            weapon = "Nico_BotRepair",
            pilotSkill = "Nico_BotRepair",
            Icon = "img/weapons/repair_super.png",
            IsActive = function(pawn)
                return pawn:IsAbility("Nico_BotRepair")
            end
        }
        Nico_BotRepair=Skill_Repair:new{
            Name = "Bot Repair",
            Description = "Repairing fully heals the Bot Leader, and Shields it.",
            Icon="img/weapons/repair_super",
            Amount=-10,
            TipImage = {
                Unit = Point(2,2),
                Target = Point(2,2),
                Fire = Point(2,2),
                CustomPawn="Nico_botleader_mech",
            }
        }
        function Nico_BotRepair:GetSkillEffect(p1,p2)
            local ret = SkillEffect()
            local damage = SpaceDamage(p2,self.Amount)
            damage.iFire = EFFECT_REMOVE
            damage.iAcid = EFFECT_REMOVE
            damage.bHide=true
            local shield= SpaceDamage(p2,0)
            shield.iShield = 1
            shield.sImageMark= "effects/Nico_icon_shield_glow.png"
            
            local mechs = extract_table(Board:GetPawns(TEAM_MECH))
            for i,id in pairs(mechs) do
                local point = Board:GetPawnSpace(id)
                if point == p2 or IsPassiveSkill("Mass_Repair") then
                    damage.loc = point
                    shield.loc = point
                    if Board:IsPawnSpace(point) then
                        shield.iShield = 1
                        if Board:GetPawn(point):IsAcid() then
                            damage.iAcid = EFFECT_REMOVE
                        end
                    end
                    ret:AddDamage(shield)
                    ret:AddDamage(damage)
                end
            end
            
            ret:AddDamage(shield)
            ret:AddDamage(damage)
            return ret       
        end
    end
    local path = mod_loader.mods[modApi.currentMod].resourcePath
    modApi:appendAsset("img/effects/Nico_icon_shield_glow.png", path.."img/weapons/Nico_icon_shield_glow.png")
    Location["effects/Nico_icon_shield_glow.png"] = Point(-16,8)
    return this

local mod = modApi:getCurrentMod()
local scriptPath = modApi:getCurrentMod().scriptPath
local replaceRepair = require(scriptPath.."replaceRepair/replaceRepair")
require(scriptPath .."Achievements/achievements1")
local this={}

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
    if modApi.achievements:isComplete("Nico_Sent_weap","Nico_Bot_SW2") then
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
            GetSkill = function() NicoIsMine = true; return "Survive_Death" end,
            Rarity = 0,
            Blacklist = {"Invulnerable","Thick","Popular","Health","Skilled","Regen","Pain"},
        }
    end
    if modApi.achievements:isComplete("Nico_Sent_weap","Nico_Bot_SW3") then
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
            Blacklist = {"Invulnerable","Popular","Pain","Health","Skilled"},
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
    end
    if modApi.achievements:isComplete("Nico_Sent_weap","Nico_Bot_SW4") then
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
    end

--Bot Leader's skill replacement
function this:init(mod)
    if modApi.achievements:isComplete("Nico_Sent_weap","Nico_Bot_SW3") then
        replaceRepair:addSkill{
            Name = "Pinnacle Technologies",
            Description = "Repairing fully heals the Bot Leader, and Shields it.\nAt mission start, deploy a number of Cannon Bots equal to pilot level.\nRevives when dead at the end of a battle.",
            weapon = "Nico_BotRepair",
            pilotSkill = "Nico_BotRepair",
            Icon = "img/weapons/Nico_Bot_Repair.png",
            iconFrozen = "img/weapons/Nico_Bot_Repair_frozen.png",
            IsActive = function(pawn)
                return pawn:IsAbility("Nico_BotRepair")
            end
        }
        Nico_BotRepair=Skill_Repair:new{
            Name = "Bot Repair",
            Description = "Repairing fully heals the Bot Leader, and Shields it.",
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
            damage.bHide = true
            local shield= SpaceDamage(p2,0)
            damage.iShield = 1
            shield.sImageMark= "combat/icons/Nico_icon_shield+10.png"
            
            local mechs = extract_table(Board:GetPawns(TEAM_MECH))
            for i,id in pairs(mechs) do
                local point = Board:GetPawnSpace(id)
                if point == p2 or IsPassiveSkill("Mass_Repair") then
                    damage.loc = point
                    shield.loc = point
                    if Board:IsPawnSpace(point) then
                        damage.iShield = 1
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
        local HOOK_pawnTracked = function(mission, pawn)--Funny hehehaha Easter Egg
            if pawn:IsAbility("Nico_BotRepair") and mission.ID == "Mission_Repair" then
                local TotalHP = pawn:GetMaxHealth()
                pawn:SetHealth(TotalHP)
            end
        end
        local function EVENT_onModsLoaded()
            modapiext:addPawnTrackedHook(HOOK_pawnTracked)
        end
        modApi.events.onModsLoaded:subscribe(EVENT_onModsLoaded)
    end
end
return this
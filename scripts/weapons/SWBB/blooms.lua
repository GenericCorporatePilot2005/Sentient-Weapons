local mod = modApi:getCurrentMod()
local path = mod.scriptPath
require(path .."Achievements/achievements1")
require(path .."palettes")

--laser bloom
Nico_laserbloom = Pawn:new{
	Name = "Bloom-Laser",
	Health = 1,
	Nico_onDeath = "BloomDeath",
	Class = "TechnoVek",
	ImageOffset = modApi:getPaletteImageOffset("Nico_bloom_1"),
	DefaultTeam = TEAM_PLAYER,
	MoveSpeed = 3,
	Image = "Nico_Laser_Bloom",
	SkillList = { "Nico_laserheal" },
	SoundLocation = "/enemy/snowlaser_1/",
	DefaultTeam = TEAM_PLAYER,
	ImpactMaterial = IMPACT_METAL,
	Corpse = false,
	Explodes = true,
}
Nico_laserheal = Nico_laserbot:new{
    Name="K-bL00m Beam Mark I",
	Class="TechnoVek",
    Description="Sacrifice self to fire a piercing beam that repairs all targets and shields the adjacent friendly target.",
	Explosion = "",
	Sound = "",
	Icon="weapons/Nico_bloom_laser.png",
	Damage = -1,
	Fire = -1,
    SelfDamage=DAMAGE_DEATH,
	PowerCost = 0,
	MinDamage = -1,
	FriendlyDamage = true,
	BuildingDamage = true,
	ZoneTargeting = ZONE_DIR,
	Upgrades = 0,
	UpgradeList = {},
	UpgradeCost = {},
	TipImage = {
		Unit = Point(2,4),
		Enemy = Point(2,3),
		Friendly_Damaged = Point(2,2),
		Target = Point(2,3),
		Friendly2_Damaged = Point(2,1),
		Building = Point(2,0),
		CustomEnemy = "Leaper1",
        CustomPawn="Nico_laserbloom",
	}
}

function Nico_laserheal:AddLaser(ret,point,direction)
	local queued = queued or false
	local minDamage = self.MinDamage or 1
	local damage = self.Damage
	local start = point - DIR_VECTORS[direction]
	--if forced_end ~= nil then
	--	LOG("Forced end = "..forced_end:GetString())
	--else
	--	LOG("No forced end!")
	--end
	ret:AddDamage(SpaceDamage(start, self.SelfDamage))
	while Board:IsValid(point) do
	
		local temp_damage = damage  --This is so that if damage is set to 0 because of an ally, it doesn't affect the damage calculation of the laser.
		
		if (not self.FriendlyDamage and Board:IsPawnTeam(point, TEAM_PLAYER)) or (not self.BuildingDamage and Board:IsBuilding(point)) then
			temp_damage = DAMAGE_ZERO
		end
		
		local dam = SpaceDamage(point, temp_damage)
		
		dam.iSmoke = self.Smoke
		dam.iAcid = self.Acid
		dam.iFire = self.Fire
		dam.iFrozen = self.Freeze
		dam.sScript = "Board:SetFire("..point:GetString()..",false)"
		if (start:Manhattan(point) == 1 and Board:IsPawnTeam(point, TEAM_PLAYER)) then
            local shield=SpaceDamage(dam.loc,0)
            shield.sImageMark= "combat/icons/Nico_icon_shield+1.png"
			dam.iShield = 1
            dam.bHide=true
			dam.sScript = "Board:SetFire("..point:GetString()..",false) modApi:runLater(function() Board:AddShield("..point:GetString()..") end)"
            ret:AddDamage(shield)
		end
		
		-- if it's the end of the line (ha), add the laser art -- not pretty
		if forced_end == point or not Board:IsValid(point + DIR_VECTORS[direction]) then
			if queued then 
				ret:AddQueuedProjectile(dam,self.LaserArt)
			else
				ret:AddProjectile(start,dam,self.LaserArt,FULL_DELAY)
			end
			break
		else
			if queued then
				ret:AddQueuedDamage(dam)  
			else
				ret:AddDamage(dam)   --JUSTIN TEST
			end
		end
		
		damage = damage - 1
		if damage < minDamage then damage = minDamage end
					
		point = point + DIR_VECTORS[direction]	
	end
end

--cannon bloom
Nico_cannonbloom = Pawn:new{
	Name = "Bloom-Cannon",
	Health = 1,
	Nico_onDeath="BloomDeath",
	Class = "TechnoVek",
	ImageOffset = modApi:getPaletteImageOffset("Nico_bloom_2"),
	DefaultTeam = TEAM_PLAYER,
	MoveSpeed = 3,
	Image = "Nico_Cannon_Bloom",
	SkillList = { "Nico_cannonheal" },
	SoundLocation = "/enemy/snowtank_1/",
	DefaultTeam = TEAM_PLAYER,
	ImpactMaterial = IMPACT_METAL,
	Corpse = false,
	Explodes = true,
}
Nico_cannonheal = TankDefault:new{
    Name="Cannon Grow Mark I",
	Class="TechnoVek",
	Range = RANGE_PROJECTILE,
	PathSize = INT_MAX,
	Description="Sacrifice self to fire a projectile that repairs and shields the target.",
	Icon="weapons/Nico_bloom_cannon.png",
	SelfDamage = DAMAGE_DEATH,
	Damage = -1,
    Fire = -1,
	Shield = 1,
    Push=0,
	PowerCost=0,
	Upgrades=0,
	ProjectileArt = "effects/shot_mechtank",
	Explo = "airpush1_",
	ShieldFriendly = true,
	UpgradeCost={},
	UpgradeList = {},
	Projectile = "effects/shot_mechtank",
	LaunchSound = "/enemy/snowtank_1/attack",
	ImpactSound = "/impact/generic/explosion",
	TipImage = {
		Unit = Point(2,4),
		Friendly_Damaged = Point(2,2),
		Target = Point(2,3),
        CustomPawn="Nico_cannonbloom",
	}
}
function Nico_cannonheal:GetSkillEffect(p1,p2)
	local ret = SkillEffect()
	local direction = GetDirection(p2 - p1)
	local target = GetProjectileEnd(p1,p2,PATH_PROJECTILE)
	
	ret:AddDamage(SpaceDamage(p1,self.SelfDamage))
	local dam = SpaceDamage(target,self.Damage)
	dam.iFire = -1
	dam.sImageMark= "combat/icons/Nico_icon_shield+1.png"
	dam.sScript = "Board:SetFire("..target:GetString()..",false)"-- modApi:runLater(function() Board:AddShield("..target:GetString()..") end)"
	ret:AddProjectile(dam, self.ProjectileArt, FULL_DELAY)
	local shield=SpaceDamage(target,0)
	shield.bHide=true
	shield.iShield = 1
	ret:AddDamage(shield)
	return ret
end

--bloom artillery
Nico_artillerybloom = Pawn:new{
	Name = "Bloom-Artillery",
	Health = 1,
	Class = "TechnoVek",
	Nico_onDeath="BloomDeath",
	ImageOffset = modApi:getPaletteImageOffset("Nico_bloom_3"),
	DefaultTeam = TEAM_PLAYER,
	MoveSpeed = 3,
	Image = "Nico_Artillery_Bloom",
	SkillList = { "Nico_artilleryheal" },
	SoundLocation = "/enemy/snowart_1/",
	DefaultTeam = TEAM_PLAYER,
	ImpactMaterial = IMPACT_METAL,
	Corpse = false,
	Explodes = true,
}

Nico_artilleryheal = SnowartAtk1:new{
	Name="Vk8 Repair Rockets Mark I",
	ArtillerySize = 8,
	Explosion = "ExploRepulse2",
	Damage = -1,
	Fire = -1,
	Queued = false,
	SelfDamage = DAMAGE_DEATH,
	Class = "TechnoVek",
	Description="Sacrifice self to fire three rockets that repair the targets.",
	Icon="weapons/Nico_bloom_artillery.png",
	LaunchSound = "/enemy/snowart_1/attack",
	ImpactSound = "/impact/generic/explosion",
	Projectile = "effects/shotup_bloom_artillery.png",
	TipImage = {
		Unit = Point(2,3),
		Friendly_Damaged1 = Point(1,1),
		Friendly_Damaged2 = Point(2,1),
		Friendly_Damaged3 = Point(3,1),
		Target = Point(2,1),
		CustomPawn = "Nico_artillerybloom",
	}
}

function Nico_artilleryheal:GetSkillEffect(p1,p2)
	local ret = SkillEffect()
	local dir = GetDirection(p2-p1)
	
	ret:AddDamage(SpaceDamage(p1,self.SelfDamage))
	local dam = SpaceDamage(p2, self.Damage)
	dam.iFire = -1
	dam.sScript = "Board:SetFire("..p2:GetString()..",false)"
	ret:AddArtillery(dam,self.Projectile, NO_DELAY)
	dam.loc = p2 + DIR_VECTORS[(dir + 1)% 4]
	dam.sScript = "Board:SetFire("..(p2 + DIR_VECTORS[(dir + 1)% 4]):GetString()..",false)"
	ret:AddArtillery(dam,self.Projectile, NO_DELAY)
	dam.loc = p2 + DIR_VECTORS[(dir - 1)% 4]
	dam.sScript = "Board:SetFire("..(p2 + DIR_VECTORS[(dir - 1)% 4]):GetString()..",false)"
	ret:AddArtillery(dam,self.Projectile, NO_DELAY)
	
	return ret
end

BloomDeath = Emitter:new{
	image = "effects/Bloom_Bot's_petal.png",
	image_count = 1,
	max_alpha = 1.0,
	min_alpha = 0.0,
	rot_speed = 100,
	x = 0, y = 10, variance_x = 0, variance_y = 0,
	angle = 20, angle_variance = 220,
	timer = 0,
	burst_count = 1, speed = 1.00, lifespan = 1.0, birth_rate = 0,
	max_particles = 16,
	gravity = true,
	layer = LAYER_FRONT
}

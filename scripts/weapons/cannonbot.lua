------Cannon Bot------
Nico_cannonbot=Skill:new{
	Name="Cannon 8R Mark II",
	Class="TechnoVek",
	Range = RANGE_PROJECTILE,
	PathSize = INT_MAX,
	Description="Projectile that causes target to burn.",
	Icon = "advanced/weapons/SnowtankAtk1_Player.png",
	Damage=1,
    Fire = 1,
    Push=1,
	PowerCost=0,
	Upgrades=2,
	ProjectileArt = "effects/shot_mechtank",
	Explo = "explopush1_",
	ShieldFriendly = false,
	UpgradeCost={2,2},
	UpgradeList = { "+1 Damage", "Shield Friendly"},
	Projectile = "effects/shot_mechtank",
	UpShot = "effects/shotup_ignite_fireball.png",
	LaunchSound = "",
	ImpactSound = "",
	TipImage = {
		Unit = Point(2,4),
		Enemy1 = Point(2,0),
		Enemy2 = Point(2,2),
		Target = Point(2,2),
		Second_Origin = Point(2,4),
		Second_Target = Point(2,0),
		CustomEnemy = "Digger1",
		CustomPawn = "Nico_cannonbot_mech",
	},
	}

	function Nico_cannonbot:GetTargetArea(point)
		local ret = PointList()
		for i = DIR_START, DIR_END do
			for k = 1, 7 do
				ret:push_back(DIR_VECTORS[i]*k + point)
			end
		end
		return ret
	end

	function Nico_cannonbot:GetSkillEffect(p1,p2)
		local ret = SkillEffect()
		local direction = GetDirection(p2 - p1)
		local target = GetProjectileEnd(p1,p1+DIR_VECTORS[direction])
		if p1:Manhattan(target) < p1:Manhattan(p2) then
			ret:AddBounce(p1, self.Damage)
			ret:AddSound("/weapons/fireball")
			local damage = SpaceDamage(p2,self.Damage)
			damage.sAnimation = (self.Damage == 1 and "ExploArt2") or "explo_fire1"
			damage.iFire = 1
			ret:AddArtillery(damage, self.UpShot)
			ret:AddSound("/props/fire_damage")
			if self.ShieldFriendly then
				for dir = DIR_START, DIR_END do
					local spaceDamage = SpaceDamage(p2 + DIR_VECTORS[dir], 0)
					if Board:IsBuilding(p2 + DIR_VECTORS[dir]) or Board:GetPawnTeam(p2 + DIR_VECTORS[dir]) == TEAM_PLAYER then
						spaceDamage.iShield = 1
						ret:AddDamage(spaceDamage)
					end
				end
			end
		else
			ret:AddSound("/enemy/snowtank_1/attack")
		  	local damage = SpaceDamage(target, self.Damage)
			damage.iFire = self.Fire
			if self.Push == 1 then
				damage.iPush = direction
			end
			damage.sAnimation = self.Explo..direction
		
			ret:AddProjectile(damage, self.ProjectileArt, 0.1*p1:Manhattan(target))--"effects/shot_mechtank")
			ret:AddSound("/impact/generic/explosion")
			if self.ShieldFriendly then
				--ret:AddDelay()
				for dir = DIR_START, DIR_END do
					local spaceDamage = SpaceDamage(target + DIR_VECTORS[dir], 0)
					if Board:IsBuilding(target + DIR_VECTORS[dir]) or Board:GetPawnTeam(target + DIR_VECTORS[dir]) == TEAM_PLAYER then
						spaceDamage.iShield = 1
						ret:AddDamage(spaceDamage)
					end
				end
			end
		end

		return ret
	end


	Nico_cannonbot_A=Nico_cannonbot:new{
		Damage=2,
		Explo = "explopush2_",
		UpShot = "effects/shotup_fireball.png",
		UpgradeDescription = "Increases damage by 1.",
		TipImage = {
			Unit = Point(2,4),
			Enemy1 = Point(2,0),
			Enemy2 = Point(2,2),
			Target = Point(2,2),
			Second_Origin = Point(2,4),
			Second_Target = Point(2,0),
			CustomEnemy = "Firefly1",
			CustomPawn = "Nico_cannonbot_mech",
		},
	}

	Nico_cannonbot_B=Nico_cannonbot:new{
	    Damage=1,
		ShieldFriendly = true,
	    UpgradeDescription = "Shields allied units and buildings adjacent to the target.",
		TipImage = {
			Unit = Point(2,4),
			Enemy1 = Point(2,0),
			Enemy2 = Point(2,2),
			Target = Point(2,2),
			Building1 = Point(2,1),
			Building2 = Point(1,2),
			Friendly = Point(3,0),
			Second_Origin = Point(2,4),
			Second_Target = Point(2,0),
			CustomEnemy = "Firefly1",
			CustomPawn = "Nico_cannonbot_mech",
		},
	}

	Nico_cannonbot_AB=Nico_cannonbot_B:new{
		Damage=2,
		Explo = "explopush2_",
		UpShot = "effects/shotup_fireball.png",
		TipImage = {
			Unit = Point(2,4),
			Enemy1 = Point(2,0),
			Enemy2 = Point(2,2),
			Target = Point(2,2),
			Building1 = Point(2,1),
			Building2 = Point(1,2),
			Friendly = Point(3,0),
			Second_Origin = Point(2,4),
			Second_Target = Point(2,0),
			CustomEnemy = "Scarab2",
			CustomPawn = "Nico_cannonbot_mech",
		},
	}
	modApi:addWeaponDrop("Nico_cannonbot")

local mod = modApi:getCurrentMod()
------Boom Cannon------
Nico_cannonboom = Nico_cannonbot:new{
	Name = "Cannon Explo Mark I",
	Class = "TechnoVek",
	Range = RANGE_PROJECTILE,
	PathSize = INT_MAX,
	Description = "Fire a shot from Guided Janus Cannon, AP Cannon, Ricochet Rocket, or Quick-Fire Rockets. Has knockback.",
	Icon = "weapons/Nico_cannonboom.png",
	Damage = 1,
	SelfDamage = 0,
    Fire = 1,
    Push = 1,
	PowerCost = 0,
	Upgrades = 2,
	ProjectileArt = "effects/shot_mechtank",
	Explo = "explopush1_",
	Exploart = "explopush1_",
	TwoClick = true,
	UpgradeCost = {1,3},
	UpgradeList = { "+1 Damage Each", "+1 Damage"},
	Projectile = "effects/shot_mechtank",
	UpShot = "effects/shotup_ignite_fireball.png",
	LaunchSound = "",
	ImpactSound = "/impact/generic/explosion",
	CustomTipImage = "Nico_cannonboom_Tip",
}

function Nico_cannonboom:GetTargetArea(point)
	return Board:GetSimpleReachable(point, self.PathSize, self.CornersAllowed)
end

function Nico_cannonboom:GetSecondTargetArea(p1,p2)
	local target = GetProjectileEnd(p1,p2)
	local ret = PointList()
	
	if target ~= p2 or not Board:IsBlocked(p2,PATH_PROJECTILE) then
        ret = Board:GetSimpleReachable(p2, self.PathSize, self.CornersAllowed)
        self:RemoveBackwards(ret,p1,p2)
        self:RemoveForwards(ret,p1,p2)
    end

	-- build list of points between self and target, including self and target, and already seen points
	local ignore = {p1}
	local curr = p1
	for i = 1,p1:Manhattan(target) do
		curr = curr + DIR_VECTORS[GetDirection(target - p1)]
		ignore[#ignore + 1] = curr
	end
	for i = 1,ret:size() do
		ignore[#ignore + 1] = ret:index(i)
	end
	
	-- call second target areas then filter out the ignore points when adding to ret
	local ret1 = Board:GetSimpleReachable(p1, self.PathSize, self.CornersAllowed)
	local ret2 = Board:GetSimpleReachable(target, self.PathSize, self.CornersAllowed)
	for i = 1,ret1:size() do
		if not list_contains(ignore,ret1:index(i)) then ret:push_back(ret1:index(i)) end
	end
	for i = 1,ret2:size() do
		if not list_contains(ignore,ret2:index(i)) then ret:push_back(ret2:index(i)) end
	end

	return ret
end

function Nico_cannonboom:GetSkillEffect(p1,p2)
	local ret = SkillEffect()
	local direction = GetDirection(p2-p1)
	ret:AddDamage(SpaceDamage(p1,self.SelfDamage))
	ret:AddProjectile(SpaceDamage(p2,0,direction), self.ProjectileArt, NO_DELAY)
	return ret
end

function Nico_cannonboom:GetFinalEffect(p1,p2,p3)
	local ret = SkillEffect()
	local dir = GetDirection(p2-p1)
	local target = GetProjectileEnd(p1,p2)
	local janus_flag = false
	if not Board:IsBlocked(p2,PATH_PROJECTILE) then
		if dir%2 == 0 then--p1.x == p2.x
			if p2.y == p3.y then janus_flag = true end
		else--p1.y == p2.y
			if p2.x == p3.x then janus_flag = true end
		end
	end
	
	if janus_flag then
	--Janus Cannon
		local backdir = GetDirection(p1 - p2)
		local backtarget = GetProjectileEnd(p1,p1 + DIR_VECTORS[backdir])
		local distance = p1:Manhattan(p2)
		local opposite = p1 + DIR_VECTORS[backdir]*distance
		ret:AddSound("/weapons/mirror_shot")
		-- knockback
		ret:AddDamage(SpaceDamage(p1,self.SelfDamage,GetDirection(p2-p3)))
		-- create pre-turn attack
		local damage = SpaceDamage(p2, 0)
		damage.sSound = "/weapons/bomb_strafe"
		ret:AddProjectile(damage, "effects/shot_mechtank", NO_DELAY)
		-- create backshot
		if backtarget ~= p1 then
			if (p1:Manhattan(backtarget)<p1:Manhattan(opposite)) or Board:IsBlocked(opposite, PATH_PROJECTILE) then
			-- case 1: backshot collides before it turns
				local backdamage = SpaceDamage(backtarget, self.Damage, backdir)
				backdamage.sAnimation = self.Exploart..backdir
				ret:AddProjectile(backdamage, "effects/shot_mechtank", NO_DELAY)
			else-- case 2: backshot is able to turn
				local backdamage = SpaceDamage(opposite, 0)
				damage.sSound = "/weapons/bomb_strafe"
				ret:AddProjectile(backdamage, "effects/shot_mechtank", NO_DELAY)
			end
		end
		
		local targ = GetProjectileEnd(p2,p3,PATH_PROJECTILE)
		local direction = GetDirection(p3-p2)
		local backdir = GetDirection(p1-p2)
		local backtarget = GetProjectileEnd(p1,p1 + DIR_VECTORS[backdir])
		local reverse_dir = ((direction + 2) % 4)
		local distance = p1:Manhattan(p2)
		local opposite = p1 + DIR_VECTORS[backdir]*distance
		local opp_turn = opposite + DIR_VECTORS[direction]
		ret:AddDelay(distance*0.1)
		
		local damagepush = SpaceDamage(p2,0)  --smoke when it turns
		damagepush.sAnimation = "airpush_"..reverse_dir
		ret:AddDamage(damagepush)
		
		local final_damage = SpaceDamage(targ,self.Damage,direction)
		final_damage.sAnimation = self.Exploart..direction
		final_damage.sSound = "/impact/generic/explosion"
		ret:AddProjectile(p2, final_damage, "effects/shot_mechtank", NO_DELAY)
		
		if (not Board:IsBlocked(opposite, PATH_PROJECTILE)) and (backtarget ~= p1) and (not (p1:Manhattan(backtarget)<p1:Manhattan(opposite))) then
			-- create second turning shot
			opp_target = GetProjectileEnd(opposite,opp_turn,PATH_PROJECTILE)
			
			local opp_damagepush = SpaceDamage(opposite,0)  --smoke when it turns
			opp_damagepush.sAnimation = "airpush_"..reverse_dir
			ret:AddDamage(opp_damagepush)
			
			local opp_final_damage = SpaceDamage(opp_target,self.Damage,direction)
			opp_final_damage.sAnimation = self.Exploart..direction
			opp_final_damage.sSound = "/impact/generic/explosion"
			ret:AddProjectile(opposite, opp_final_damage, "effects/shot_mechtank", NO_DELAY)
		end
	elseif p3:Manhattan(p1)<p3:Manhattan(target) then
	--Quick-Fire Rockets
		ret:AddSound("/weapons/doubleshot")
		local pathing = self.Phase and PATH_PHASING or PATH_PROJECTILE
		local target1 = GetProjectileEnd(p1,p2,pathing)
		
		local knockback = GetDirection(p1-p3)
		if GetDirection(p2-p1) == GetDirection(p1-p3) then knockback = DIR_NONE end
		--knockback
		ret:AddDamage(SpaceDamage(p1,self.SelfDamage,knockback))
		ret:AddBounce(p1,3)
		
		local damage = SpaceDamage(target1, self.Damage, dir)
		damage.sAnimation = self.Exploart..dir
		
		ret:AddProjectile(damage, "effects/shot_quickfire", NO_DELAY)
		
		dir = GetDirection(p3-p1)
		local target2 = GetProjectileEnd(p1,p3,pathing)  
		damage = SpaceDamage(target2, self.Damage, dir)
		damage.sAnimation = self.Exploart..dir
		ret:AddProjectile(damage, "effects/shot_quickfire", NO_DELAY)
	
	elseif GetDirection(target-p1) == GetDirection(p3-target) then
	--AP Cannon
		ret:AddSound("/weapons/pierce_shot")
		local first_tar = GetProjectileEnd(p1,p2,PATH_PROJECTILE)  
		local second_tar = GetProjectileEnd(first_tar,first_tar+DIR_VECTORS[dir],PATH_PROJECTILE)  
		
		--knockback
		ret:AddDamage(SpaceDamage(p1,self.SelfDamage,GetDirection(p1 - p2)))
		
		local pushdam = SpaceDamage(p1+DIR_VECTORS[dir],0)
		pushdam.sAnimation = "airpush_"..dir
		ret:AddDamage(pushdam)
		
		local damage = SpaceDamage(second_tar, self.Damage + 1, dir)
		
		damage.sAnimation = "explopush2_"..dir
		ret:AddProjectile(damage, "effects/shot_pierce", NO_DELAY)
		
		local distance = first_tar:Manhattan(p1)
		ret:AddDelay(distance*0.1 + 0.2)
		local first_damage = SpaceDamage(first_tar, 0, dir)
		first_damage.sAnimation = "airpush_"..dir
		ret:AddDamage(first_damage)
		ret:AddSound("/impact/generic/explosion")
	else
	--Ricochet Rocket
		ret:AddSound("/weapons/modified_cannons")
		local first_dir = GetDirection(p2 - p1)
		local first_tar = GetProjectileEnd(p1,p2,PATH_PROJECTILE)  

		local second_dir = GetDirection(p3 - target)
		local second_tar = GetProjectileEnd(target,p3,PATH_PROJECTILE)  
		
		--knockback
		local pushdam = SpaceDamage(p1,self.SelfDamage,GetDirection(target - p3))
		pushdam.sAnimation = "airpush_"..first_dir
		ret:AddDamage(pushdam)
		
		ret:AddProjectile(SpaceDamage(first_tar), "effects/shot_smokerocket")
		
		if Board:IsValid(p3) then
			local damage = SpaceDamage(second_tar,self.Damage,second_dir)
			damage.sSound = "/impact/generic/explosion"
			damage.sAnimation = self.Exploart..second_dir
			if not self.AllyDamage and Board:IsPawnTeam(second_tar, TEAM_PLAYER) then 
				damage.iDamage = DAMAGE_ZERO 	
				damage.sAnimation = "airpush_"..second_dir
			end 
			--if not self.BuildingDamage and Board:IsBuilding(second_tar) then	damage.iDamage = DAMAGE_ZERO 	end 
			ret:AddProjectile(target, damage, "effects/shot_smokerocket", NO_DELAY)
		end
		
		local damage = SpaceDamage(first_tar, self.Damage, first_dir)
		damage.sSound = "/impact/generic/ricochet"
		damage.sAnimation = self.Exploart..first_dir
		if not self.AllyDamage and Board:IsPawnTeam(first_tar, TEAM_PLAYER) then 
			damage.iDamage = DAMAGE_ZERO 	
			damage.sAnimation = "airpush_"..first_dir
		end 
		--if not self.BuildingDamage and Board:IsBuilding(first_tar) then	damage.iDamage = DAMAGE_ZERO 	end 
		ret:AddDamage(damage)
	end
	if self.SelfDamage==1 then
		for i = 1,ret.effect:size() do
			ret.effect:index(i).bKO_Effect = Board:IsDeadly(ret.effect:index(i),Pawn)
			if ret.effect:index(i).bKO_Effect and (ret.effect:index(i).loc ~= p1 or (ret.effect:index(i).loc == p1 and Board:IsCracked(ret.effect:index(i).loc))) then
				ret:AddSound("/weapons/arachnoid_ko")
				local damage = SpaceDamage(ret.effect:index(i).loc)
				if Board:IsTerrain(ret.effect:index(i).loc,TERRAIN_WATER) or Board:IsTerrain(ret.effect:index(i).loc,TERRAIN_LAVA) or Board:IsTerrain(ret.effect:index(i).loc,TERRAIN_HOLE) or Board:IsCracked(ret.effect:index(i).loc) or (Board:IsTerrain(ret.effect:index(i).loc,TERRAIN_ICE) and Board:IsCracked(ret.effect:index(i).loc)) then
					ret:AddAnimation(damage.loc,"Nico_Copter_Bloome", ANIM_NO_DELAY)
					ret:AddDelay(1.03)
					ret:AddBounce(damage.loc,1)
					damage.sPawn = "Copter_Bloom_Bot"
				else
					ret:AddAnimation(damage.loc,"Nico_Cannon_Bloome", ANIM_NO_DELAY)
					ret:AddDelay(1.45)
					ret:AddBounce(damage.loc,1)
					damage.sPawn = "Nico_cannonbloom"
				end
				damage.bKO_Effect = true
				ret:AddDamage(damage)
				if Board:IsTerrain(ret.effect:index(i).loc,TERRAIN_LAVA) then--this checks that the tile the copter spawns is a lava tile
					local minifire = SpaceDamage(ret.effect:index(i).loc)
					minifire.iFire = 1
					ret:AddDamage(minifire)
				end
				if Board:IsAcid(ret.effect:index(i).loc) and Board:IsTerrain(ret.effect:index(i).loc,TERRAIN_WATER) then --this does the same but for acid water
					local miniacid = SpaceDamage(ret.effect:index(i).loc)
					miniacid.iAcid = 1
					ret:AddDamage(miniacid)
				end
			elseif ret.effect:index(i).bKO_Effect and ret.effect:index(i).loc == p1 then
				ret.effect:index(i).bKO_Effect = false
			end
		end
	end
	return ret
end

Nico_cannonboom_A=Nico_cannonboom:new{
	Damage=2,
	SelfDamage=1,
	Explo = "explopush2_",
	Exploart = "explopush2_",
	UpgradeDescription = "Increases damage by 1 and damages self. On kill, create a Bloom-Cannon.",
	CustomTipImage = "Nico_cannonboom_Tip_A",
}

Nico_cannonboom_B=Nico_cannonboom:new{
	Damage=2,
	Explo = "explopush2_",
	Exploart = "explopush2_",
	UpgradeDescription = "Increases damage by 1.",
	CustomTipImage = "Nico_cannonboom_Tip_B",
}

Nico_cannonboom_AB=Nico_cannonboom_A:new{
	Damage=3,
	CustomTipImage = "Nico_cannonboom_Tip_AB",
}
	
Nico_cannonboom_Tip = Nico_cannonboom:new{
	TipImage = {
		Unit = Point(2,3),
		Enemy1 = Point(2,2),
		Enemy2 = Point(2,1),
		Enemy3 = Point(3,2),
		Enemy4 = Point(1,3),
		Mountain1 = Point(2,0),
		Mountain2 = Point(3,1),
		Mountain3 = Point(4,2),
		Mountain4 = Point(0,3),
		Target = Point(2,2),
		Second_Click = Point(2,1),
		CustomPawn = "Nico_cannonboom_mech",
		CustomEnemy="Scorpion1",
	},
}
Nico_cannonboom_Tip_A = Nico_cannonboom_Tip:new{ Damage=2, SelfDamage=1, Explo = "explopush2_", Exploart = "explopush2_", }
Nico_cannonboom_Tip_B = Nico_cannonboom_Tip:new{ Damage=2, Explo = "explopush2_", Exploart = "explopush2_", }
Nico_cannonboom_Tip_AB = Nico_cannonboom_Tip_A:new{ Damage = 3, }

function Nico_cannonboom_Tip:GetFinalEffect(p1,p2,p3)
	local ret = SkillEffect()
	local x = math.random(4)
	if self.SelfDamage == 0 and self.Damage == 1 then
		if x == 1 then
			ret = Nico_cannonboom:GetFinalEffect(Point(2,3),Point(3,3),Point(3,2))
		elseif x == 2 then
			ret = Nico_cannonboom:GetFinalEffect(Point(2,3),Point(2,2),Point(2,1))
		elseif x == 3 then
			ret = Nico_cannonboom:GetFinalEffect(Point(2,3),Point(2,2),Point(1,3))
		else
			ret = Nico_cannonboom:GetFinalEffect(Point(2,3),Point(2,2),Point(3,2))
		end
	elseif self.SelfDamage == 1 and self.Damage == 2 then
		if x == 1 then
			ret = Nico_cannonboom_A:GetFinalEffect(Point(2,3),Point(3,3),Point(3,2))
		elseif x == 2 then
			ret = Nico_cannonboom_A:GetFinalEffect(Point(2,3),Point(2,2),Point(2,1))
		elseif x == 3 then
			ret = Nico_cannonboom_A:GetFinalEffect(Point(2,3),Point(2,2),Point(1,3))
		else
			ret = Nico_cannonboom_A:GetFinalEffect(Point(2,3),Point(2,2),Point(3,2))
		end
	elseif self.SelfDamage == 0 and self.Damage == 2 then
		if x == 1 then
			ret = Nico_cannonboom_B:GetFinalEffect(Point(2,3),Point(3,3),Point(3,2))
		elseif x == 2 then
			ret = Nico_cannonboom_B:GetFinalEffect(Point(2,3),Point(2,2),Point(2,1))
		elseif x == 3 then
			ret = Nico_cannonboom_B:GetFinalEffect(Point(2,3),Point(2,2),Point(1,3))
		else
			ret = Nico_cannonboom_B:GetFinalEffect(Point(2,3),Point(2,2),Point(3,2))
		end
	else
		if x == 1 then
			ret = Nico_cannonboom_AB:GetFinalEffect(Point(2,3),Point(3,3),Point(3,2))
		elseif x == 2 then
			ret = Nico_cannonboom_AB:GetFinalEffect(Point(2,3),Point(2,2),Point(2,1))
		elseif x == 3 then
			ret = Nico_cannonboom_AB:GetFinalEffect(Point(2,3),Point(2,2),Point(1,3))
		else
			ret = Nico_cannonboom_AB:GetFinalEffect(Point(2,3),Point(2,2),Point(3,2))
		end
	end
	return ret
end

modApi:addWeaponDrop("Nico_cannonboom")

------Knight Bot------
Nico_knightbot = Punch:new{
	Name = "0th KPR Sword Mark II",
	Description = "Dash through Buildings and Mountains to damage and push the target. If the target was shielded, smoke it and attack again. If the destination is blocked, leap backwards to the nearest empty tile.",
	Icon = "weapons/Nico_knightbot.png",
	Class = "TechnoVek",
	Damage = 1,
	PathSize = INT_MAX,
	ZoneTargeting = ZONE_DIR,
	Dash = true,
	Phase = true,
	Shield = false,
	Upgrades = 2,
	UpgradeList={"Shield","+2 Damage"},
	UpgradeCost={2,3},
	Push = true,
	LaunchSound="/weapons/charge",
	ImpactSound="",--/weapons/sword",
	TipImage = {
		Unit = Point(4,2),
		Second_Origin = Point(2,2),
		Target = Point(3,2),
		Second_Target = Point(2,0),
		Enemy1 = Point(1,2),
		Enemy2 = Point(2,0),
		Queued2 = Point(2,1),
		Building = Point(2,1),
		Mountain = Point(3,2),
		CustomPawn = "Nico_knightbot_mech",
	}
}
	function Nico_knightbot:GetTargetArea(point)
		local ret = PointList()
		local curr = point
		for i = 0,3 do
			curr = point + DIR_VECTORS[i]
			ret:push_back(curr)
			while not Board:IsBlocked(curr,PATH_PROJECTILE) do
				curr = curr + DIR_VECTORS[i]
				ret:push_back(curr)
			end
			if self.Phase then
				for j = 1,7 do
					if Board:IsPawnSpace(curr) then break end
					if not Board:IsPawnSpace(curr) and Board:IsValid(curr) then
						curr = curr + DIR_VECTORS[i]
						ret:push_back(curr)
					end
				end
			end
		end
		return ret
	end

	function Nico_knightbot:GetSkillEffect(p1, p2)
		if Board:IsTipImage() then
			Board:AddShield(Point(2,0))
		end
		local ret = SkillEffect()
		local direction = GetDirection(p2 - p1)
		local mech = Board:GetPawn(p1)
		local target = GetProjectileEnd(p1,p1+DIR_VECTORS[direction],PATH_PROJECTILE)
		local damage = SpaceDamage(target, self.Damage, direction)
		damage.sAnimation = "explospear1_"..direction

		if self.Phase then
			local curr = target
			for i = 1,7 do
				if Board:IsPawnSpace(curr) then break end
				if not Board:IsPawnSpace(curr) and Board:IsValid(curr) then
					curr = curr + DIR_VECTORS[direction]
				end
			end
			target = curr
		end

    	if not Board:IsBlocked(target,PATH_PROJECTILE) then -- dont attack an empty edge square, just run to the edge
		 	target = target + DIR_VECTORS[direction]
		end

		if self.Shield then
			ret:AddCharge(Board:GetPath(p1, target - DIR_VECTORS[direction], PATH_FLYER), NO_DELAY)
			local temp = p1
			local dam = SpaceDamage(p1,0)
			dam.iShield = 1
			while temp ~= target do
				if Board:IsBuilding(temp) or Board:IsTerrain(temp,TERRAIN_MOUNTAIN) then dam.loc = temp ret:AddDamage(dam) end
				--ret:AddBounce(temp,-3)
				temp = temp + DIR_VECTORS[direction]
				if temp ~= target then
					ret:AddDelay(0.07)
				end
			end
		else
			ret:AddCharge(Board:GetPath(p1, target - DIR_VECTORS[direction], PATH_FLYER), FULL_DELAY)
		end
		
		local targ = target

		if Board:IsBuilding(target) and self.Phase then damage.iDamage = 0 end
		damage.loc = target
		damage.fDelay = -1
		if Board:IsValid(target) then damage.sSound = "/weapons/sword" end
	
		local double_flag = Board:IsPawnSpace(target) and Board:GetPawn(target):IsShield()
		local stable = Board:IsPawnSpace(target) and Board:GetPawn(target):IsGuarding()
		local unstable_pushed = Board:IsPawnSpace(target) and not Board:GetPawn(target):IsGuarding() and not Board:IsBlocked(target + DIR_VECTORS[direction],PATH_PROJECTILE) and Board:IsValid(target + DIR_VECTORS[direction])
		local unstable_blocked = Board:IsPawnSpace(target) and not Board:GetPawn(target):IsGuarding() and (Board:IsBlocked(target + DIR_VECTORS[direction],PATH_PROJECTILE) or not Board:IsValid(target + DIR_VECTORS[direction]))
		if double_flag then local smokeDam = SpaceDamage(target,0) smokeDam.iSmoke = 1 ret:AddDamage(smokeDam) damage.iSmoke = 1 end
		ret:AddMelee(target - DIR_VECTORS[direction], damage)
		if double_flag then
			if stable or unstable_blocked then ret:AddMelee(target - DIR_VECTORS[direction], damage) end
			if unstable_pushed then
				damage.iSmoke = 0
				damage.loc = target + DIR_VECTORS[direction]
				damage.sAnimation = ""--"explospear2_"..direction
				ret:AddScript("Board:AddAnimation("..target:GetString()..", \"explospear2_"..direction.."\", 0)")
				ret:AddMelee(target - DIR_VECTORS[direction], damage)
			end
		end
	
		if target - DIR_VECTORS[direction] ~= p1 and Board:IsBlocked(target - DIR_VECTORS[direction],PATH_PROJECTILE) then
			local landing = target - DIR_VECTORS[direction]
			while landing ~= p1 and Board:IsBlocked(landing,PATH_PROJECTILE) do
				landing = landing - DIR_VECTORS[direction]
			end
			local damage = SpaceDamage(0)--phantom damage to stall board state
			damage.fDelay = 0.017
			ret:AddDamage(damage)
			local move = PointList()
			move:push_back(target - DIR_VECTORS[direction])
			move:push_back(landing)
			ret:AddBurst(target - DIR_VECTORS[direction],"Emitter_Burst_$tile",DIR_NONE)
			ret:AddSound("/weapons/boosters")
			ret:AddLeap(move, FULL_DELAY)
			ret:AddBurst(landing,"Emitter_Burst_$tile",DIR_NONE)
			ret:AddBounce(landing,3)
			ret:AddSound("/impact/generic/mech")
		end
		if Board:IsTipImage() then
			mech:RemoveWeapon(1)
			mech:AddWeapon(self.__Id)
		end
		if self.Shield and GAME.additionalSquadData.squad == "Nico_Sent_weap2" and not modApi.achievements:isComplete("Nico_Sent_weap","Nico_Bot_Knight") then
			local curr = p1
			local mons = 0
			for i = 1,p1:Manhattan(targ) do
				curr = curr + DIR_VECTORS[direction]
				if Board:IsTerrain(curr, TERRAIN_MOUNTAIN) then mons = mons + 1 end
			end
		
			if mons > 2 then
				ret:AddScript("Nico_Sent_weap2squad_Chievo('Nico_Bot_Knight')")
			end
		end
		return ret
	end
	Nico_knightbot_A=Nico_knightbot:new{
		Shield = true,
		UpgradeDescription="Shield Buildings and Mountains.",
	}
	Nico_knightbot_B=Nico_knightbot:new{
		UpgradeDescription="Increases damage by 2.",
		Damage=3,
	}
	Nico_knightbot_AB=Nico_knightbot_A:new{
		Damage=3,
	}

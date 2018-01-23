--[[

MODULES A: Find Targets

]]--

PFService = game:GetService("PathfindingService")

function module.findTarget(mob,args) --args = {playerFocus = 0.5, coreFocus = 1, buildingFocus = 0.2, maxRange = 1000}
	local mobHRP = mob:FindFirstChild("HumanoidRootPart") or return nil
	local target = nil

	for _,v in pairs(game.Workspace:GetChildren())do
		if (v:FindFirstChild("Humanoid") or v:FindFirstChild("Health")) and v:FindFirstChild("IsAZombie") == nil then
			local hp = v:FindFirstChild("Humanoid") or v:FindFirstChild("Health")
			
			if hp.ClassName == "Humanoid" then
				local torso = v:FindFirstChild("HumanoidRootPart")
				
				if torso and hp.Health > 0 then
					print(mob:GetFullName().. " found a living humanoid with a torso")
					
					local dist = (torso.Position - mobHRP.Position).Magnitude
					
					if dist <= args.maxRange * (args.playerFocus or 0.5) then
						target = torso
						args.maxRange = dist
					end
				end
			elseif hp.ClassName == "IntValue" then
				local torso = v:FindFirstChild("Center")
				
				if torso and hp.Value > 0 then
					print(mob:GetFullName().. " found some sort of stucture with a Center")
					
					if v.Name == "Core" then
						local dist = (torso.Position - mobHRP.Position).Magnitude
						
						if dist <= args.maxRange * (args.coreFocus or 1) then
							target = torso
							args.maxRange = dist
						end
					else
						local dist = (torso.Position - mobHRP.Position).Magnitude
						
						if dist <= args.maxRange * (args.buildingFocus or 0.2) then
							target = torso
							args.maxRange = dist
						end
					end
				end
			end
		end
	end
	
	return target
end -- retuns a BasePart = target's HumanoidRootPart or nil

function module.findTargetSmart(mob,args) --args = {playerFocus = 0.5, coreFocus = 1, buildingFocus = 0.2, maxRange = 1000, maxPathfindRange = 200}
	local mobHRP = mob:FindFirstChild("HumanoidRootPart") or return nil
	local target = nil

	for _,v in pairs(game.Workspace:GetChildren())do
		if (v:FindFirstChild("Humanoid") or v:FindFirstChild("Health")) and v:FindFirstChild("IsAZombie") == nil then
			local hp = v:FindFirstChild("Humanoid") or v:FindFirstChild("Health")
			
			if hp.ClassName == "Humanoid" then
				local torso = v:FindFirstChild("HumanoidRootPart")
				
				if torso and hp.Health > 0 then
					print(mob:GetFullName().. " found a living humanoid with a torso")
					
					local dist = (torso.Position - mobHRP.Position).Magnitude
					
					if dist <= args.maxRange * (args.playerFocus or 0.5) then
						target = torso
						args.maxRange = dist
					end
				end
			elseif hp.ClassName == "IntValue" then
				local torso = v:FindFirstChild("Center")
				
				if torso and hp.Value > 0 then
					print(mob:GetFullName().. " found some sort of stucture with a Center")
					
					if v.Name == "Core" then
						local dist = (torso.Position - mobHRP.Position).Magnitude
						
						if dist <= args.maxRange * (args.coreFocus or 1) then
							target = torso
							args.maxRange = dist
						end
					else
						local dist = (torso.Position - mobHRP.Position).Magnitude
						
						if dist <= args.maxRange * (args.buildingFocus or 0.2) then
							target = torso
							args.maxRange = dist
						end
					end
				end
			end
		end
	end
	
	if target and (target.Position - mobHRP.Position).Magnitude <= args.maxPathfindRange then
		local path = PFService:FindPathASync(mobHRP.Position,target.Position)
		
		return path
	else
		return target
	end
end -- returns a Path or a BasePart = target's HumanoidRootPart or nil

--[[

MODULES B: Walk to Target, pathing or not

]]--

function module.walkToTarget(mob,var)
	local mobHRP = mob:FindFirstChild("HumanoidRootPart") or return nil
	local mobHuman = mob:FindFirstChild("Humanoid") or return nil
	
	if var:IsA("BasePart") then
		mobHuman:WalkTo(var.Position,var)
	else
		local wayPoints = var:GetWaypoints()
		
		
	end
end
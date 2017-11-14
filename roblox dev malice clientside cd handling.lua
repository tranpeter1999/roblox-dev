local player = game.Players.LocalPlayer
local char = player.Character

if not char or not char.Parent then
	char = player.CharacterAdded:wait()
end

local charCDsFolder = char:WaitForChild("Humanoid"):WaitForChild("cds")

local characterFolder = game.ReplicatedStorage.characterAbilities:FindFirstChild(char.Name)

local function visualize()
	for _,v in pairs(script.Parent.MainUI.Cooldowns:GetChildren())do
		local cdFolder = characterFolder.cds:FindFirstChild(v.Name)
		
		v.DescriptionFrame.AbilityNameTextLabel.Text = cdFolder.AbilityName.Value
		v.DescriptionFrame.AbilityDescTextLabel.Text = cdFolder.AbilityDesc.Value
		v.DescriptionFrame.AbilityCostTextLabel.Text = cdFolder.AbilityCost.Value.."%"
		v.DescriptionFrame.AbilityCDTextLabel.Text = math.ceil(cdFolder.AbilityCD.Value/10)/10.."s"
		
		v.AbilityCostTextLabel.Text = cdFolder.AbilityCost.Value.."%"
		
		local currentCD = charCDsFolder:FindFirstChild(cdFolder.AbilityName.Value)
		
		if currentCD then
			local perc = (currentCD.Value-10)/cdFolder.AbilityCD.Value
			v.CDBarFrame.Bar:TweenSize(UDim2.new(1,0,perc,0),"Out","Linear",0.1,true)
			cdFrame.CDBarFrame.Bar.Transparency = 0.5
		end
	end
end

charCDsFolder.ChildAdded:connect(function(child)
	if characterFolder.cds:FindFirstChild(child.Name) then
		local cdFrame = nil
		
		for _,v in pairs(script.Parent.MainUI.Cooldowns:GetChildren())do
			if v.DescriptionFrame.AbilityNameTextLabel.Text == child.Name then
				cdFrame = v
			end
		end
		
		cdFrame.CDBarFrame.Bar.Size = UDim2.new(1,0,1,0)
		cdFrame.CDBarFrame.Bar.Transparency = 0.5
	end
end)

charCDsFolder.ChildRemoved:connect(function(child)
	if characterFolder.cds:FindFirstChild(child.Name) then
		local cdFrame = nil
		
		for _,v in pairs(script.Parent.MainUI.Cooldowns:GetChildren())do
			if v.DescriptionFrame.AbilityNameTextLabel.Text == child.Name then
				cdFrame = v
			end
		end
		
		cdFrame.CDBarFrame.Bar:TweenSize = (UDim2.new(1,0,1,0),"Out","Quad",0.25,false)
		cdFrame.CDBarFrame.Bar.Transparency = 0.5
		delay(0.25,function()
			while charCDsFolder:FindFirstChild(child.Name) == nil and cdFrame.CDBarFrame.Bar.Transparency < 1 do
				cdFrame.CDBarFrame.Bar.Transparency = 0.5 + (i/10)*0.5
			end
		end)
	end
end)

game.Workspace.UpdateCDs.Changed:connect(function()
	spawn(visualize)
end)

--[[
cds
	ability1
		AbilityName
		AbilityCost
		AbilityCD
		AbilityDesc
	ability2
		AbilityName
		AbilityCost
		AbilityCD
		AbilityDesc
	ability3
		...
	...
]]

--[[
abilityFrame
	DescriptionFrame
		AbilityNameTextLabel
		AbilityDescTextLabel
		AbilityCostTextLabel
		AbilityCDTextLabel
	AbilityCostTextLabel
	CDBarFrame
		Bar
	
]]
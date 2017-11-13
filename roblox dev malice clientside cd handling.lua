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
		
		if currentCD == nil then
			v.CDBarFrame.Frame.Size = UDim2.new(0,0,0,0)
		else
			local perc = currentCD.Value/cdFolder.AbilityCD.Value
			
		end
	end
end

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
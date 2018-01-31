local player = game.Players.LocalPlayer
local cam = game.Workspace.CurrentCamera
local storeFrame = script.Parent:WaitForChild("StoreFrame")

local currentStore = {}
local currentIndex = 1

local function intializeStore(storeFolder)
	currentStore = storeFolder:GetChildren()
	currentIndex = 1
	
	--[[ v.Heiarchy
		v
			ItemName
			ItemDesc
			ItemPrice
			
			BACKPACK ONLY
			BackpackSize
			Backpack
			
			TOOL ONLY
			Tool
	]]--
end

local function addStat(stat)
	local name = nil
	local perc = false
	
	if stat.Name == "BackpackSize" then
		name = "Backpack Size"
	elseif stat.Name == "StoneRate" then
		name = "Stone Gather Power"
		perc = true
	elseif stat.Name == "WoodRate" then
		name = "Wood Gather Power"
		perc = true
	elseif stat.Name == "Rate" then
		name = "Gather Power"
		perc = true
	elseif stat.Name == "Damage" then
		name = "Damage"
		perc = true
	elseif stat.Name == "GoldRate" then
		name = "Gold Gather Power"
		perc = true
	end
	
	if name ~= nil then
		local num = stat.Value
		
		if perc then
			num = math.ceil(num*100) .. "%"
		end
	
		local tLabel = Instance.new("TextLabel")
		tlabel.BackgroundTransparency = 1
		tLabel.Name = stat.Name
		tLabel.Text = name .. " : " .. num
		tLabel.Parent = storeFrame.Stats
	end
end

local statsString = " Rate GoldRate StoneRate WoodRate Damage "

local function displayCurrentItem()
	if currentStore then
		local currentItem = currentStore[tostring(currentIndex)]
		
		if currentItem:FindFirsChild("ItemName") then
			storeFrame.iNameTextLabel.Text = currentItem.ItemName.Value
		end
		
		if currentItem:FindFirsChild("ItemDesc") then
			storeFrame.iDescTextLabel.Text = currentItem.ItemDesc.Value
		end
		
		if currentItem:FindFirsChild("ItemPrice") then
			storeFrame.iPriceTextLabel.Text = currentItem.ItemPrice.Value .. " Gold"
		end
		
		storeFrame.Stats:ClearAllChildren()
		
		if currentItem:FindFirstChild("BackpackSize") then
			addStat(currentItem.BackpackSize)
		elseif currentItem:FindFirstChildWhichIsA("Tool") then
			local tool = currentItem:FindFirstChildWhichIsA("Tool")
			
			for _,v in pairs(tool:GetChildren())do
				if string.find(statsString," " .. v.Name .. " ") then
					addStat(v)
				end
			end
		end
		
		delay(0.01,function()
			storeFrame.Stats.CanvasSize = UDim2.new(0,0,0,storeFrame.Stats.UIListLayout.AbsoluteContentSize.Y)
		end)
	end
end
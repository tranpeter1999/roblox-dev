local function weld(a, b)
	local weld = Instance.new("ManualWeld", a)
	weld.C0 = a.CFrame:inverse() * b.CFrame
	weld.Part0 = a
	weld.Part1 = b
	return weld
end

local function trueWeld(a, b)
	local weld = Instance.new("ManualWeld", a)
	weld.Part0 = a
	weld.Part1 = b
	return weld
end

local function equipArmor(client,slot)
	if client and client.Character and slot and slot:FindFirstChild("id") then
		local itemId = slot.id.Value
		local itemFolder = game.ReplicatedStorage.Equipment:FindFirstChild(slot.Name):FindFirstChild(tostring(itemId))
		
		local model = itemFolder.Model:Clone()
		model.Name = "equipped"..slot
		
		for _,v in pairs(model:GetChildren())do
			for _,x in pairs(v:GetChildren())do
				if x:IsA("BasePart") and x.Name ~= "Middle" then
					weld(x,v.Middle)
					
					x.Anchored = false
					x.CanCollide = false
				end
			end
			
			trueWeld(v.Middle,client.Character:FindFirstChild(v.Middle.WeldTo.Value)
			
			v.Middle.Anchored = false
			v.Middle.CanCollide = false
		end
		
		model.Parent = client.Character
	end
end

--[[
	DEFENSE FORMULA
	total damage = 50
	total defense = 20
	
	newDamage = math.max(0,damage - (defense^2/damage))
	damageRatio = newDamage/damage
	
	finalDamage = (0.1*damage^2) + (0.9*newDamage)

	game
		ReplicatedStorage
			Equipment
				1
					itemName	--Bandit's Cloak
					itemDesc	--A cloak that improves melee capabilities and provides minimal defense
					level
					Model
						PhysDValue		-- 
						MagiDValue		-- 
						WeaponAttributes
							onehsword	-- +10%
							twohsword	-- +10%
							katana		-- +10%
							rapier		-- +10%
							dagger		-- +10%
							onehaxe		-- +10%
							spear		-- +0%
							polearm		-- +0%
							bow			-- -25%
							crossbow	-- -25%
							revolver	-- -10%
							staff		-- -50%
							wand		-- -50%
							magic		-- 75%
							physical	-- 110%
						Part
						Part
						Part
						Middle
							WeldTo
--]]
local function process()
	for _,v in pairs(game.Players:GetChildren())do
		if v.Character and v.Character.Parent and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid:FindFirstChild("cds") then
			for _,x in pairs(v.Character.Humanoid.cds:GetChildren())do
				if x.ClassName == "IntValue" then
					x.Value = x.Value - 10
					
					if x.Value <= 0 then
						x:Destroy()
					end
				end
			end
		end
	end
	
	if game.Workspace.UpdateCDS.Value ~= 0 then
		game.Workspace.UpdateCDs.Value = 0
	else
		game.Workspace.UpdateCDS.Value = 1
	end
end

while wait(0.1) do
	spawn(process)
end	
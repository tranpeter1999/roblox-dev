local EnemyAI = {}
EnemyAI.__index = EnemyAI

function EnemyAI.new(enemyType, position, pathMap, path)
	local enemy = {}
	setmetatable(enemy, EnemyAI)
	
	enemy.Position = position
	enemy.Direction = Vector3.new(0,0,1)
	enemy.PathMap = pathMap --table of PathNodes
	enemy.Path = path
	enemy.Destination = path.MainDestination
	enemy.Moving = false

	--[[local mainPart = Instance.new("Part")
	mainPart.CFrame = CFrame.new(position)
	
	local typeIdentifier = Instance.new("StringValue")
	typeIdentifier.Name = "Type"
	typeIdentifier.Value = enemyType
	typeIdentifier.Parent = mainPart
	
	local state = Instance.new("IntValue")
	state.Name = "State"
	state.Value = 0 --0=walking, 1=in battle, 2=fainted
	state.Parent = mainPart
	
	mainPart.Parent = workspace.Enemies]]
	
	return enemy
end

function EnemyAI:Traverse()
	self.Destination = nil
	local currDestination = self.Path and self.Path.MainDestination
	
	if currDestination.State == 0 then
		self.Destination = currDestination
	else
		currDestination = self.Path and self.Path.BackUpDestination
		
		if currDestination then
			self.Destination = currDestination
		else
			warn("There was no back up destination, so enemy is now stuck")
		end
	end
	
	if self.Destination then
		self.Moving = true
		
		while (self.Position - self.Destination.Position).Magnitude > 1 do
			self.Position = self.Position + 2*(self.Destination.Position - self.Position)/(self.Destination.Position - self.Position).Magnitude
		end
		
		self.Moving = false
	end
end

function EnemyAI:Destroy()
	self = nil
end

return EnemyAI
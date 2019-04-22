local PathNode = {}
PathNode.__index = PathNode

function PathNode.new(position, mainDestination, backupDestination)
	local newnode = {}
	setmetatable(newnode, PathNode)
	
	newnode.Position = position
	newnode.MainDestination = mainDestination
	newnode.BackUpDestination = backupDestination
	newnode.State = 0 --0=free, 1=blocked (by a battle circle)
	
	--[[local mainDest = Instance.new("ObjectValue")
	mainDest.Name = "MainDestination"
	mainDest.Value = mainDestination
	mainDest.Parent = part
	
	local backupDest = Instance.new("ObjectValue")
	backupDest.Name = "BackUpDestination"
	backupDest.Value = backupDestination
	backupDest.Parent = part
	
	local state = Instance.new("IntValue")
	state.Name = "State"
	state.Value = 0 --0=free, 1=blocked (by a battle circle)
	state.Parent = part]]
	
	return newnode
end

function PathNode:Destroy()
	--self.part:ClearAllChildren()
	self = nil
end

return PathNode
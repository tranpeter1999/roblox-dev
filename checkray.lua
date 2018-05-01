local function checkRay(p1,p2)
	local ray = Ray.new(p1,(p2-p1))
	local hit,pos = game.Workspace:FindPartOnRayWithWhitelist(ray,{game.Workspace.Landmarks,game.Workspace.Terrain,game.Workspace.Harvestables,game.Workspace.Structures})
	
	return (hit and hit.CanCollide)
end

if checkRay(lastPos,startPos) then
	--teleport player back to lastpos
end
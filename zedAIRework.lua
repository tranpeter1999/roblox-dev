--declarations
local main		= script.Parent
local lleg		= main:WaitForChild("Left Leg")
local rleg		= main:WaitForChild("Right Leg")
local larm		= main:WaitForChild("Left Arm")
local rarm		= main:WaitForChild("Right Arm")
local torso		= main:WaitForChild("Torso")
local head		= main:WaitForChild("Head")
local hrp		= main:WaitForChild("HumanoidRootPart")

--logical declarations
local walkingAnimation		= script:WaitForChild("WalkingAnimation")
local chargingAnimation		= script:FindFirstChild("ChargingAnimation")
local health				= main:WaitForChild("Health")
local headHealth			= main:WaitForChild("HeadHealth")
local currentTarget			= nil
local settings =
{
	baseSpeed = 10;
	baseDamage = 7;
}
local speed = settings.baseSpeed

--sound declarations
local attackSounds =
{
	torso:WaitForChild("Attack1Sound");
	torso:WaitForChild("Attack2Sound");
}
local dieSounds =
{
	torso:WaitForChild("DieSound");
}
local hurtSounds =
{
	torso:WaitForChild("Hurt1Sound");
	torso:WaitForChild("Hurt2Sound");
}

local function playSound(sound,parent)
	if parent == nil then
		parent = head or torso or hrp
	end
	
	
end

local function findTarget()
	--find target logic, sets currentTarget
end

local function walkToTarget()
	--walk to target logic, gets currentTarget
end

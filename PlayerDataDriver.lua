-- Set up table to return to any script that requires this module script
local PlayerStatManager = {}
 
local DataStoreService = game:GetService("DataStoreService")
local playerData = DataStoreService:GetDataStore("PlayerData")
 
-- Table to hold player information for the current session
local sessionData = {}
 
local AUTOSAVE_INTERVAL = 60
 
-- Function that other scripts can call to change a player's stats
function PlayerStatManager:ChangeStat(player, statName, value)
	assert(typeof(sessionData[playerUserId][statName]) == typeof(value), "ChangeStat error: types do not match")
	local playerUserId = "Player_" .. player.UserId
	if typeof(sessionData[playerUserId][statName]) == "number" then
		sessionData[playerUserId][statName] = sessionData[playerUserId][statName] + value
	else
		sessionData[playerUserId][statName] = value
	end
end
 
-- Function to add player to the 'sessionData' table
local function setupPlayerData(player)
	local playerUserId = "Player_" .. player.UserId
	local success, data = pcall(function()
		return playerData:GetAsync(playerUserId)
	end)
	if success then
		if data then
			-- Data exists for this player
			sessionData[playerUserId] = data
		else
			-- Data store is working, but no current data for this player
			sessionData[playerUserId] = {Money=0, Experience=0}
		end
	else
		warn("Cannot access data store for player!")
	end
end
 
-- Function to save player's data
local function savePlayerData(playerUserId)
	if sessionData[playerUserId] then
		local success, err = pcall(function()
			playerData:SetAsync(playerUserId, sessionData[playerUserId])
		end)
		if not success then
			warn("Cannot save data for player!")
		end
	end
end
 
-- Function to save player data on exit
local function saveOnExit(player)
	local playerUserId = "Player_" .. player.UserId
	savePlayerData(playerUserId)
end
 
-- Function to periodically save player data
local function autoSave()
	while wait(AUTOSAVE_INTERVAL) do
		for playerUserId, data in pairs(sessionData) do
			savePlayerData(playerUserId)
		end
	end
end
 
-- Start running 'autoSave()' function in the background
spawn(autoSave)
 
-- Connect 'setupPlayerData()' function to 'PlayerAdded' event
game.Players.PlayerAdded:Connect(setupPlayerData)
 
-- Connect 'saveOnExit()' function to 'PlayerRemoving' event
game.Players.PlayerRemoving:Connect(saveOnExit)
 
return PlayerStatManager
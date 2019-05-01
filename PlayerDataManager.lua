local DataManager = {}
 
local version = "Alpha0.1"
local DataStoreService = game:GetService("DataStoreService")
local playerData = DataStoreService:GetDataStore("PlayerData"..version)
 
local sessionData = {}
 
local AUTOSAVE_INTERVAL = 60

local function getDeck(player, deckName)
	local playerUserId = "Player_" .. player.UserId
	if sessionData[playerUserId] then
		return sessionData[playerUserId].decks
	end
end

local function getEquippedDeck(player)
	local playerUserId = "Player_" .. player.UserId
	if sessionData[playerUserId]] then
		return sessionData[playerUserId].equipment.deck
	end
end

local function setupPlayerData(player)
	local playerUserId = "Player_" .. player.UserId
	local success, data = pcall(function()
		return playerData:GetAsync(playerUserId)
	end)
	local online, onlineState = pcall(function()
		return playerData:GetAsync(playerUserId .. "Online")
	end)
	if online and onlineState == 0 and success then
		if data then
			sessionData[playerUserId] = data
		else
			sessionData[playerUserId] =
			{
				spellsLearned = 
				{
					FireSchool = {
						
					};
					IceSchool = {
						
					};
					StormSchool = {
						
					};
					NatureSchool = {
						
					};
					SpiritSchool = {
						
					};
					ChaosSchool = {
						
					};
				};
				decks =
				{
					["Deck1"] = {
						["Name"] = "My First Deck";
						["Firebolt"] = 4;
						["Will-o-Wisp"] = 1;
						["Flame Conduit"] = 2;
						["Flame Focus"] = 3;
					};
				};
				equipment =
				{
					deck = "Deck1";
				};
				inventory =
				{
					hats =
					{
						
					};
					decks =
					{
						
					}
				}
			}
		end
	elseif online and onlineState ~= 0 then
		warn(player.Name .. " is online, yet still connected to a server...? Lag, or exploiting?")
		player:Kick("Unable to connect to server, you may already be connected. Please try again later.")
	else
		warn("Cannot access data store for player!")
		player:Kick("Unable to properly connect to server, data store servers may be down, or slow. Please try again later.")
	end
end

local savingData = {}
local closing = false
 
local function savePlayerData(playerUserId)
	spawn(function()
		if sessionData[playerUserId] then
			local success = false
			local err = nil
			savingData[playerUserId] = true
			
			while not success do
				success, err = pcall(function()
					playerData:SetAsync(playerUserId, sessionData[playerUserId])
					playerData:SetAsync(playerUserId .. "Online", 0)
				end)
				if not success then
					warn("Cannot save data for player!, trying again in 10 seconds")
					if closing then wait(3) else wait(10) end
				end
			end
			
			savingData[playerUserId] = nil
		end
	end)
end
 
local function saveOnExit(player)
	local playerUserId = "Player_" .. player.UserId
	savePlayerData(playerUserId)
end
 
spawn(function()
	while wait(AUTOSAVE_INTERVAL) do
		for playerUserId, data in pairs(sessionData) do
			savePlayerData(playerUserId)
		end
	end
end)

game.Players.PlayerAdded:Connect(setupPlayerData)
game.Players.PlayerRemoving:Connect(saveOnExit)

game:BindToClose(function()
	if game:GetService("RunService"):IsStudio() then return end
	
	for playerUserId, data in pairs(sessionData) do
		savePlayerData(playerUserId)
	end
	
	repeat wait(1) until #savingData <= 0
end)
 
return PlayerStatManager
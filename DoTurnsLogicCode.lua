--code snippets
--TO DO
--players' decks will be stored like this
--stats
----spells learned
------FireSpells 		-StringValue: Value = JSON:Encode(table of keys and owned) i.e. {["Firebolt"] = true; ["Fireball"] = false; ["Fire Conduit"] = true;}
------IceSpells  		-StringValue: Value = JSON:Encode(table of keys and owned)
------StormSpells  		-StringValue: Value = JSON:Encode(table of keys and owned)
------NatureSpells		-StringValue: Value = JSON:Encode(table of keys and owned)
------SpiritSpells		-StringValue: Value = JSON:Encode(table of keys and owned)
------ChaosSpells		-StringValue: Value = JSON:Encode(table of keys and owned)
----decks
------Deck1 -StringValue: Value = JSON:Encode(table of cards) and ["DeckName"] = "My Deck Name";
----equipment
------deck: -StringValue: Value = "Deck"..x 


--store players' hands somewhere in battle, then display players' hands
--we'll let players discard locally, and update the discard list when we send the player's action choice
--create RemoteEvent in Remotes.BattleState named "Action"

local playerData = require(game.ServerScriptService.PlayerDataManager)

--store hands like this
local decks = {}
local hands = {}

for _,player in pairs(battle.Players)do
	local deck = playerData.getDeck(player, playerData.getEquippedDeck(player))
	decks[player] = deck
	decks[player]["DeckName"] = nil
	
	hands[player] = {}
	
	for i = 1,7 do
		local drawnCard = math.random(1,#decks[player])
		hands[player][i] = decks[player][drawnCard]
		decks[player][drawnCard] = nil
	end
end


--SERVER
--turn timer set to 30, counts down
timer = 30

for _,player in pairs(battle.Players)do
	spawn(function()
		game.ReplicatedStorage.Remotes.BattleState.SetState:FireClient(player,1)
	end)
end

local actions = {}

while timer > 0 and #actions < #battle.Players do

end

--snippet to receive player's action choice
game.ReplicatedStorage.Remotes.BattleState.Action.OnServerEvent:Connect(function(card, discards)
	
end)

--[[discard logic
 1  2  3  4  5  6  7
[ ][ ][ ][ ][ ][ ][ ] --hand of 7 cards

[X][ ][X][ ][ ][X][ ] --player chooses these 3 cards, so we stop *displaying* the cards, but we still keep them in memory

when the player chooses to do an action, the player sends an array that lists the discards {1,3,6}


]]

--CLIENT
--battle state set to 1 (do turn)

battleState = 1

--cam tween


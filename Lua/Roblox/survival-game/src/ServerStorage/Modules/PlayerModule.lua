local PlayerModule = {}

-- SERVICES
local Players = game:GetService("Players")
local DataStoreService = game:GetService("DataStoreService")

-- CONSTANTS
local PLAYER_DEFAULT_DATA = {
	hunger = 100,
	inventory = {
        Stone = 10,
        Copper = 10,
        Wood = 80,
    },
	level = 1,
}

-- MEMBERS
local playersCached = {} --- Dictionary with all players in the game
local database = DataStoreService:GetDataStore("Survival")
local PlayerLoaded: BindableEvent = game.ServerStorage.BindableEvents.PlayerLoaded
local PlayerUnloaded: BindableEvent = game.ServerStorage.BindableEvents.PlayerUnloaded

local PlayerHungerUpdated:RemoteEvent = game.ReplicatedStorage.Network.PlayerHungerUpdated
local PlayerInventoryUpdated:RemoteEvent = game.ReplicatedStorage.Network.PlayerInventoryUpdated
local PlayerLevelUp:RemoteEvent = game.ReplicatedStorage.Network.PlayerLevelUp

--- Normalizes the hunger value
local function normalizeHunger(hunger: number): number
	if hunger < 0 then
		hunger = 0
	end

	if hunger > 100 then
		hunger = 100
	end

	return hunger
end

function PlayerModule.IsLoaded(player: Player): boolean
	local isLoaded = playersCached[player.UserId] and true or false
	return isLoaded
end

function PlayerModule.GetLevel(player: Player): number
    return playersCached[player.UserId].level
end

function PlayerModule.SetLevel(player: Player, level: number)
    playersCached[player.UserId].level = level
end

function PlayerModule.GetInventory(player: Player): table
    return playersCached[player.UserId].inventory
end

function PlayerModule.SetInventory(player: Player, inventory: table)
    playersCached[player.UserId].inventory = inventory
end

function PlayerModule.AddToInventory(player: Player, key: string, value: number)
    local inventory = playersCached[player.UserId].inventory

    if inventory[key] then
        inventory[key] += value
        return
    end

    inventory[key] = value
end

--- Sets the hunger of given player
function PlayerModule.SetHunger(player: Player, hunger: number)
    hunger = normalizeHunger(hunger)
	playersCached[player.UserId].hunger = hunger
end

--- Gets the hunger of given player
function PlayerModule.GetHunger(player: Player): number
	local hunger = normalizeHunger(playersCached[player.UserId].hunger)
	return hunger
end

local function onPlayerAdded(player: Player)
	player.CharacterAdded:Connect(function(_)
		local data = database:GetAsync(player.UserId)
		if not data then
			data = PLAYER_DEFAULT_DATA
		end
		playersCached[player.UserId] = data

		-- Players is fully loaded
		PlayerLoaded:Fire(player)

        -- Update client UI
        PlayerHungerUpdated:FireClient(player, PlayerModule.GetHunger(player))
        PlayerInventoryUpdated:FireClient(player, PlayerModule.GetInventory(player))
        PlayerLevelUp:FireClient(player, PlayerModule.GetLevel(player))
	end)
end

local function onPlayerRemoving(player: Player)
	PlayerUnloaded:Fire(player)
	database:SetAsync(player.UserId, playersCached[player.UserId])
	
    -- MANUAL RESET
    -- database:SetAsync(player.UserId, false)
	playersCached[player.UserId] = nil
end

Players.PlayerAdded:Connect(onPlayerAdded)
Players.PlayerRemoving:Connect(onPlayerRemoving)

return PlayerModule

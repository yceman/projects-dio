-- SERVICES
local ProximityPromptService = game:GetService("ProximityPromptService")

-- MEMBERS
local PlayerModule = require(game.ServerStorage.Modules.PlayerModule)
local PlayerLevelUp:RemoteEvent = game.ReplicatedStorage.Network.PlayerLevelUp
local PlayerInventoryUpdated: RemoteEvent = game.ReplicatedStorage.Network.PlayerInventoryUpdated

-- CONSTANT
local PROXIMITY_ACTION = "LevelUp"
local LEVEL_CAP = 3
local RESOURCES_REQUIRED = {
    [2] = {
        Stone = 50 * 2,
        Copper = 10 * 2,
        Wood = 100 * 2,
    },
    [3] = {
        Stone = 50 * 3,
        Copper = 10 * 3,
        Wood = 100 * 3,
    }
}



-- Detect when prompt is triggered
local function onPromptTriggered(promptObject:ProximityPrompt, player)
    -- Check if prompt triggered is an Eat action
    if promptObject.Name ~= PROXIMITY_ACTION then
        return
    end

    local inventory = PlayerModule.GetInventory(player)
    local level = PlayerModule.GetLevel(player)

    if level >= LEVEL_CAP then
        return
    end

    local required = RESOURCES_REQUIRED[level+1]

    if inventory.Stone < required.Stone then
        return
    end

    if inventory.Copper < required.Copper then
        return
    end

    if inventory.Wood < required.Wood then
        return
    end

    inventory.Stone -= required.Stone
    inventory.Copper -= required.Copper
    inventory.Wood -= required.Wood

    PlayerModule.SetLevel(player, level + 1)
    PlayerLevelUp:FireClient(player, PlayerModule.GetLevel(player))
    PlayerInventoryUpdated:FireClient(player, PlayerModule.GetInventory(player))
end

-- Connect prompt events to handling functions
ProximityPromptService.PromptTriggered:Connect(onPromptTriggered)
-- CONSTANTS
local CORE_LOOP_INTERVAL = 2
local HUNGER_DECREMENT = 1

-- MEMBERS
local PlayerModule = require(game.ServerStorage.Modules.PlayerModule)
local PlayerLoaded: BindableEvent = game.ServerStorage.BindableEvents.PlayerLoaded
local PlayerUnloaded:BindableEvent = game.ServerStorage.BindableEvents.PlayerUnloaded
local PlayerHungerUpdated:RemoteEvent = game.ReplicatedStorage.Network.PlayerHungerUpdated

local function coreLoop(player: Player)
    -- Whether or not the routine should run
    local isRunning = true
    
    -- Listen to the Player Unloaded event to stop this thread
    PlayerUnloaded.Event:Connect(function(playerUnloaded: Player)
        if playerUnloaded == player then
            isRunning = false 
        end
    end)

    -- Main loop
	while true do
        if not isRunning then
            break
        end

		local currentHunger = PlayerModule.GetHunger(player)
		PlayerModule.SetHunger(player, currentHunger - HUNGER_DECREMENT)

        -- Notify client
        PlayerHungerUpdated:FireClient(player, PlayerModule.GetHunger(player))

		wait(CORE_LOOP_INTERVAL)
	end
end

local function onPlayerLoaded(player: Player)
	spawn(function()
		coreLoop(player)
	end)
end

PlayerLoaded.Event:Connect(onPlayerLoaded)

local PlayerLevelUp:RemoteEvent = game.ReplicatedStorage.Network.PlayerLevelUp

-- CONSTANTS
local LEVEL_CAP = 3

-- Members
local homeStorage:Folder = game.ReplicatedStorage.HomeStorage

local function onPlayerLevelUp(level)
    for _, instance in workspace.Home:GetChildren() do
        instance:Destroy()
    end

    local home 
    if level >= LEVEL_CAP then
        home = homeStorage:FindFirstChild(LEVEL_CAP):Clone()    
    else
        home = homeStorage:FindFirstChild(level):Clone()
    end

    home.Parent = workspace.Home
end

PlayerLevelUp.OnClientEvent:Connect(onPlayerLevelUp)
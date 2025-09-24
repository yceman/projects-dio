local PlayerHungerUpdated:RemoteEvent = game.ReplicatedStorage.Network.PlayerHungerUpdated

-- SERVICES
local Players = game:GetService("Players")

-- CONSTANTS
local BAR_FULL_COLOR = Color3.fromRGB(154, 255, 1)
local BAR_LOW_COLOR =  Color3.fromRGB(255, 154, 1)

-- MEMBERS
local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
local hud:ScreenGui = PlayerGui:WaitForChild("HUD")
local leftBar:Frame = hud:WaitForChild("LeftBar")
local hungerUi:Frame = leftBar:WaitForChild("Hunger")
local hungerBar:Frame = hungerUi:WaitForChild("Bar")

PlayerHungerUpdated.OnClientEvent:Connect(function(hunger: number)
    -- Updates the hunger bar X axis size
    hungerBar.Size = UDim2.fromScale(hunger/100, hungerBar.Size.Y.Scale)

    -- Updates the bar's color according to the hunger value
    if hungerBar.Size.X.Scale >= 0.45 then
        hungerBar.BackgroundColor3 = BAR_FULL_COLOR
    else
        hungerBar.BackgroundColor3 = BAR_LOW_COLOR
    end

end)
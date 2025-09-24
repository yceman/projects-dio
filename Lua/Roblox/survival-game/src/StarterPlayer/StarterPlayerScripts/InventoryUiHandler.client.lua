local PlayerInventoryUpdated:RemoteEvent = game.ReplicatedStorage.Network.PlayerInventoryUpdated

-- SERVICES
local Players = game:GetService("Players")

-- CONSTANTS
-- ...

-- MEMBERS
local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
local hud:ScreenGui = PlayerGui:WaitForChild("HUD")
local leftBar:Frame = hud:WaitForChild("LeftBar")
local inventoryUi:Frame = leftBar:WaitForChild("Inventory")
local inventoryButton:ImageButton = inventoryUi:WaitForChild("Button")

local inventoryWindow:Frame = hud:WaitForChild("Inventory")
local inventoryWindowOriginalPosition = inventoryWindow.Position.X.Scale
inventoryWindow.Position = UDim2.fromScale(-1, inventoryWindow.Position.Y.Scale)

local stoneNumberLabel:TextLabel = inventoryWindow.Stone.Number
local copperNumberLabel:TextLabel = inventoryWindow.Copper.Number
local woodNumberLabel:TextLabel = inventoryWindow.Wood.Number

inventoryUi.MouseEnter:Connect(function()
    -- print("Mouse enter")
    -- inventoryWindow.Visible = true
end)

inventoryUi.MouseLeave:Connect(function()
    -- print("Mouse leave")
    -- inventoryWindow.Visible = false
end)

inventoryButton.MouseButton1Click:Connect(function()
    inventoryWindow.Visible = not inventoryWindow.Visible
    if inventoryWindow.Visible then
        inventoryWindow:TweenPosition(UDim2.fromScale(inventoryWindowOriginalPosition, 
        inventoryWindow.Position.Y.Scale), 
        Enum.EasingDirection.Out, 
        Enum.EasingStyle.Quint)
    else
        inventoryWindow.Position = UDim2.fromScale(-1, inventoryWindow.Position.Y.Scale)
    end
end)

PlayerInventoryUpdated.OnClientEvent:Connect(function(inventory: table)
   stoneNumberLabel.Text = inventory.Stone and inventory.Stone or 0
   copperNumberLabel.Text = inventory.Copper and inventory.Copper or 0
   woodNumberLabel.Text = inventory.Wood and inventory.Wood or 0
end)
-- SERVICES
local Players = game:GetService("Players")
local SocialService = game:GetService("SocialService")

-- CONSTANTS
-- ...

-- MEMBERS
local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
local hud:ScreenGui = PlayerGui:WaitForChild("HUD")
local inviteFriends:TextButton = hud:WaitForChild("InviteFriends")
local player = Players.LocalPlayer
 
local function promptGameInvite(targetPlayer)
	local res, canInvite = pcall(SocialService.PromptGameInvite, SocialService, targetPlayer)
	return res and canInvite
end
 
local function openGameInvitePrompt(targetPlayer)
	local promptOpened = promptGameInvite(targetPlayer)
	return promptOpened
end
 

inviteFriends.MouseButton1Click:Connect(function()
    openGameInvitePrompt(player)
end)
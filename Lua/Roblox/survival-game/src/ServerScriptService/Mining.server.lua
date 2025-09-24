-- SERVICES
local ProximityPromptService = game:GetService("ProximityPromptService")

-- CONSTANT
local PROXIMITY_ACTION = "Mining"
local PICKAXE_SOUND_ID = "rbxassetid://7650217335"

-- MEMBERS
local PlayerModule = require(game.ServerStorage.Modules.PlayerModule)
local PlayerInventoryUpdated: RemoteEvent = game.ReplicatedStorage.Network.PlayerInventoryUpdated
local animation = Instance.new("Animation")
animation.AnimationId = "rbxassetid://10026280725"

local isPressing = false

local function playPickaxeSound()
    local pickaxeSound = Instance.new("Sound", game:GetService("Workspace"))
	pickaxeSound.SoundId = PICKAXE_SOUND_ID
	local random = Random.new() 
	local value = random:NextNumber(1, 1.1)

	pickaxeSound.Pitch = value
	pickaxeSound.Parent = workspace
	pickaxeSound:Play()
end


-- Detect when prompt is triggered
local function onPromptTriggered(promptObject: ProximityPrompt, player)
	-- Check if prompt triggered is an Eat action
	if promptObject.Name ~= PROXIMITY_ACTION then
		return
	end

	local miningModel = promptObject.Parent
    local miningValue = miningModel:FindFirstChildWhichIsA("NumberValue")

    PlayerModule.AddToInventory(player, miningValue.Name, miningValue.Value)
    PlayerInventoryUpdated:FireClient(player, PlayerModule.GetInventory(player))
    
    miningModel:Destroy()
end

-- Detect when prompt hold begins
local function onPromptHoldBegan(promptObject, player:Player)
	-- Check if prompt triggered is an Eat action
	if promptObject.Name ~= PROXIMITY_ACTION then
		return
	end
    isPressing = true

    local character = player.Character
    local humanoid = character.Humanoid

    local humanoidAnimator:Animator = humanoid.Animator
    local animationTrack:AnimationTrack = humanoidAnimator:LoadAnimation(animation)

    while isPressing do
        animationTrack:Play(nil, nil, 2.5)
        -- playPickaxeSound()
        wait(.5) 
    end
end

-- Detect when prompt hold ends
local function onPromptHoldEnded(promptObject, player)
 	-- Check if prompt triggered is an Eat action
     if promptObject.Name ~= PROXIMITY_ACTION then
		return
	end
    isPressing = false
end

-- Connect prompt events to handling functions
ProximityPromptService.PromptTriggered:Connect(onPromptTriggered)
ProximityPromptService.PromptButtonHoldBegan:Connect(onPromptHoldBegan)
ProximityPromptService.PromptButtonHoldEnded:Connect(onPromptHoldEnded)

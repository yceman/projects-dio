local parent:Part = script.Parent
local spawnLocation = workspace.SpawnLocation
local debouncing = {}
local confetes: Folder = parent.Confetes

-- Services
local Players = game:GetService("Players")

parent.Touched:Connect(function(hit)
	local playerName = hit.Parent.Name
	if debouncing[playerName] then
		return
	end
	
	-- Inicia o debouncing	
	debouncing[playerName] = true

	local character:Model = hit.Parent
	
	-- Checa se o que está encostando na peça é um jogador ou não
	local player = Players:GetPlayerFromCharacter(character)
	if not player then
		return
	end
	
	local primaryPart = character.PrimaryPart
	
	-- Incrementa um ponto ao jogador
	local leaderstats = player:FindFirstChild("leaderstats")
	if leaderstats then
		local score:IntValue = leaderstats:FindFirstChild("Score")
		score.Value += 1
	end
	
	-- Iterar sobre todos os confetes dentro da pasta
	for _, confete in confetes:GetChildren() do
		local particleEmitter = Instance.new("ParticleEmitter")
		particleEmitter.Rate = 100
		particleEmitter.Speed = NumberRange.new(15, 20)
		particleEmitter.SpreadAngle = Vector2.new(25, 4)
		particleEmitter.Parent = confete	
		
		-- Para de emitir as partículas		
		delay(1, function()
			particleEmitter.Enabled = false
		end)
		
		-- Destrói as partículas
		delay(6, function()
			particleEmitter:Destroy()
		end)
	end
	
	-- Teleporta o jogador de volta para o início	
	delay(1, function()
		primaryPart.CFrame = spawnLocation.CFrame * CFrame.new(0, 15, 0)

	end)	
	
	-- Elimina os debouncings
	delay(3, function()
		debouncing[playerName] = false
	end)
end)
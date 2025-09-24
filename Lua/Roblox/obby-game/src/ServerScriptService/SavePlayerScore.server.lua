-- Services
local Players = game:GetService("Players")
local DataStoreService = game:GetService("DataStoreService")

-- Carrega o banco de dados
local database = DataStoreService:GetDataStore("Score")

local function onPlayerRemoving(player : Player)
	local score:IntValue = 0
	
	-- Tenta localizar a pontuação atual utilizando o leaderstats
	local leaderstats = player:FindFirstChild("leaderstats")
	if leaderstats then
		score = leaderstats:FindFirstChild("Score")
	end

	-- Salva a pontuação atual
	local success, message = pcall(function()
		database:SetAsync(player.UserId, score.Value)
	end)
	
	if success then
		print("Dados salvos com sucesso!")
	end
end

Players.PlayerRemoving:Connect(onPlayerRemoving)
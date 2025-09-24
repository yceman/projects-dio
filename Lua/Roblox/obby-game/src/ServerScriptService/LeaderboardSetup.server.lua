-- Services
local DataStoreService = game:GetService("DataStoreService")
local Players = game:GetService("Players")

-- Carrega o banco de dados
local database = DataStoreService:GetDataStore("Score")

local function onPlayerAdded(player: Player)
	local leaderstats = Instance.new("Folder")
	leaderstats.Name = "leaderstats"
	leaderstats.Parent = player
	
	-- Carrega os dados do jogador
	local success, playerData  = pcall(function()
		return database:GetAsync(player.UserId)		
	end)
	
	if success then
		local score = Instance.new("IntValue")
		score.Name = "Score"
		score.Value = playerData and playerData or 0
		score.Parent = leaderstats
	else
		print("Deu errado!")
		print(playerData)
	end
end

-- Listeners
Players.PlayerAdded:Connect(onPlayerAdded)
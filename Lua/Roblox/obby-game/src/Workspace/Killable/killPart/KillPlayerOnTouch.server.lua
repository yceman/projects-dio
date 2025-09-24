local parent:Part = script.Parent
local debouncing = {}

parent.Touched:Connect(function(hit)
	local playerName = hit.Parent.Name
	if debouncing[playerName] then
		return
	end
	
	-- Inicia o debouncing	
	debouncing[playerName] = true
	
	local character:Model = hit.Parent
	if not character then
		return
	end
	
	local humanoid:Humanoid = character:FindFirstChild("Humanoid")
	if not humanoid then
		return
	end
	
	-- Mata o jogador
	humanoid.Health -= 25
	delay(1, function()
		print("Resetou o debouncing")
		debouncing[playerName] = false
	end)
end)
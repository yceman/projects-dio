local name = "Rafa"
local forecast = "ensolarado"
local min = 22
local max = 35

local function convertCelsiusToFahrenheit(c)
	local f = (c * 9/5) + 32
	return f
end
local minF = convertCelsiusToFahrenheit(min)
local maxF = convertCelsiusToFahrenheit(max)

print(string.format("Olá %s.", name))
print()
print(string.format("A previsão para hoje é um dia %s", forecast))
print(string.format("A temperatura irá variar entre %d C e %d C", min, max))
print(string.format("A temperatura irá variar entre %d e %d graus celsius (%.1f e %.1f Fahrenheit)", min, max, minF, maxF))

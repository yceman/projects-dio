-- Valores dos materiais
local valores = {
    Agua = 100,
    Lava = 500,
    Obsidian = 600
}

-- Lista de materiais disponíveis
local materiais = {"Agua", "Lava"}

-- Descobertas do jogador
local descobertas = {}

-- Materiais escolhidos pelo jogador
local selecionado1 = nil
local selecionado2 = nil
local resultado = nil

-- Função que combina materiais
function combinar(material1, material2)
    local soma = valores[material1] + valores[material2]
    for nome, valor in pairs(valores) do
        if valor == soma then
            local chave = material1 .. " + " .. material2
            descobertas[chave] = nome
            return nome
        end
    end
    return "Desconhecido"
end

function love.load()
    love.window.setTitle("Diário de Combinações")
    love.graphics.setFont(love.graphics.newFont(18))
end

function love.mousepressed(x, y, button)
    if button == 1 then
        -- Simula botão de combinação
        if x > 50 and x < 250 and y > 200 and y < 240 then
            if selecionado1 and selecionado2 then
                resultado = combinar(selecionado1, selecionado2)
            end
        end
    end
end

function love.draw()
    love.graphics.print("Selecione dois materiais:", 50, 20)

    for i, nome in ipairs(materiais) do
        love.graphics.print(i .. ": " .. nome .. " (" .. valores[nome] .. ")", 50, 50 + i * 30)
    end

    love.graphics.print("Pressione 1 ou 2 para selecionar", 50, 130)
    love.graphics.print("Selecionado 1: " .. tostring(selecionado1), 50, 160)
    love.graphics.print("Selecionado 2: " .. tostring(selecionado2), 50, 190)

    love.graphics.rectangle("line", 50, 200, 200, 40)
    love.graphics.print("Combinar", 100, 210)

    if resultado then
        love.graphics.print("Resultado: " .. resultado, 50, 260)
    end

    love.graphics.print("?? Descobertas:", 400, 20)
    local y = 50
    for combinacao, res in pairs(descobertas) do
        love.graphics.print(combinacao .. " = " .. res, 400, y)
        y = y + 25
    end
end

function love.keypressed(key)
    if key == "1" then
        selecionado1 = materiais[1]
    elseif key == "2" then
        selecionado2 = materiais[2]
    end
end

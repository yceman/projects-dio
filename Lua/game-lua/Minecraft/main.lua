local valores = {
    Agua = 100,
    Lava = 500,
    Obsidian = 600
}

local descobertas = {}

-- Salva descobertas em um arquivo
function salvarDescobertas()
    local arquivo = io.open("descobertas.txt", "w")
    for combinacao, resultado in pairs(descobertas) do
        arquivo:write(combinacao .. " = " .. resultado .. "\n")
    end
    arquivo:close()
end

-- Carrega descobertas do arquivo
function carregarDescobertas()
    local arquivo = io.open("descobertas.txt", "r")
    if arquivo then
        for linha in arquivo:lines() do
            local combinacao, resultado = linha:match("^(.-)%s*=%s*(.+)$")
            if combinacao and resultado then
                descobertas[combinacao] = resultado
            end
        end
        arquivo:close()
    end
end

-- Função que cria material com metatable
function criarMaterial(nome)
    local material = {nome = nome, valor = valores[nome]}

    setmetatable(material, {
        __add = function(m1, m2)
            local soma = m1.valor + m2.valor
            for nome, valor in pairs(valores) do
                if valor == soma then
                    local chave = m1.nome .. " + " .. m2.nome
                    descobertas[k chave] = nome
                    salvarDescobertas()  -- salva após cada nova descoberta
                    return criarMaterial(nome)
                end
            end
            return {nome = "Desconhecido", valor = soma}
        end,

        __tostring = function(m)
            return m.nome .. " (" .. m.valor .. ")"
        end
    })

    return material
end

-- Mostrar descobertas
function mostrarDescobertas()
    print("?? Descobertas salvas:")
    for combinacao, resultado in pairs(descobertas) do
        print(" - " .. combinacao .. " = " .. resultado)
    end
end

-- ?? Início do programa
carregarDescobertas()

local agua = criarMaterial("Agua")
local lava = criarMaterial("Lava")
local resultado = agua + lava

print(agua .. " + " .. lava .. " = " .. resultado)

mostrarDescobertas()

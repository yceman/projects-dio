/**const sfxCard = document.getElementById("sfx-card");
const sfxLegendary = document.getElementById("sfx-legendary");

// Exemplo de cartas e sons associados
const cardSounds = {
    "Blue-Eyes White Dragon": "dragao.mp3",
    "Dark Magician": "feiticeira.mp3",
    "Warrior": "guerreiro.mp3",
    // Adicione mais aqui
};

// Lista de cartas lendárias
const legendaryCards = ["Blue-Eyes White Dragon", "Exodia", "Slifer the Sky Dragon"];

function tocarSomCarta(nomeCarta) {
    // Toca som associado à carta
    const soundFile = cardSounds[nomeCarta];
    if (soundFile) {
        sfxCard.src = `sons/cartas/${soundFile}`;
        sfxCard.currentTime = 0;
        sfxCard.volume = parseFloat(localStorage.getItem("sfxVolume")) || 1;
        sfxCard.play().catch(console.warn);
    }

    // Toca swoosh se for lendária
    if (legendaryCards.includes(nomeCarta)) {
        sfxLegendary.currentTime = 0;
        sfxLegendary.volume = 1; // pode ajustar separado se quiser
        sfxLegendary.play().catch(console.warn);
    }
}

function jogarCarta(carta) {
    // Lógica do jogo aqui
    tocarSomCarta(carta.nome);
}**/

const sfxCard = document.getElementById("sfx-card");
const sfxLegendary = document.getElementById("sfx-legendary");

// Exemplo de cartas e sons associados
const cardSounds = {
    "Blue-Eyes White Dragon": "dragao.mp3",
    "Dark Magician": "feiticeira.mp3",
    "Warrior": "guerreiro.mp3",
    // Adicione mais aqui
};

// Lista de cartas lendárias
const legendaryCards = ["Blue-Eyes White Dragon", "Exodia", "Slifer the Sky Dragon"];

function tocarSomCarta(nomeCarta) {
    // Toca som associado à carta
    const soundFile = cardSounds[nomeCarta];
    if (soundFile) {
        sfxCard.src = `sons/cartas/${soundFile}`;
        sfxCard.currentTime = 0;
        sfxCard.volume = parseFloat(localStorage.getItem("sfxVolume")) || 1;
        sfxCard.play().catch(console.warn);
    }
    if (legendaryCards.includes(nomeCarta)) {
        sfxLegendary.currentTime = 0;
        sfxLegendary.play().catch(console.warn);

        // Supondo que você tenha o elemento da carta do jogador
        const cartaDOM = document.getElementById("player-field-card");
        animarCartaLendaria(cartaDOM);
        }


    // Toca swoosh se for lendária
    /**if (legendaryCards.includes(nomeCarta)) {
        sfxLegendary.currentTime = 0;
        sfxLegendary.volume = 1; // pode ajustar separado se quiser
        sfxLegendary.play().catch(console.warn);
    }**/

    function animarCartaLendaria(elementoCarta) {
        // Efeito de brilho dourado
        elementoCarta.classList.add("glow");

        // Efeito de shake na tela (no body ou container principal)
        document.body.classList.add("shake");

        // Remover as classes após alguns milissegundos
        setTimeout(() => {
            elementoCarta.classList.remove("glow");
            document.body.classList.remove("shake");
        }, 1000);
    }
}

function jogarCarta(carta) {
    // Lógica do jogo aqui
    tocarSomCarta(carta.nome);
}

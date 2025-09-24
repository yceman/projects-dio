const state = {
	score: {
		playerScore: 0,
		computerScore: 0,
		scoreBox: document.getElementById("score_points"),
	},
	cardSprites: {
		avatar: document.getElementById("card-image"),
		name: document.getElementById("card-name"),
		type: document.getElementById("card-type"),
	},
	fieldCards: {
		player: document.getElementById("player-field-card"),
		computer: document.getElementById("computer-field-card"),
	},
	button: document.getElementById("next-duel"),
};

const sfx = {
    attack: document.getElementById("sfx-attack"),
    draw: document.getElementById("sfx-draw"),
    volumeControl: document.getElementById("sfx-volume"),
};

// Define o volume inicial
sfx.attack.volume = sfx.volumeControl.value;
sfx.draw.volume = sfx.volumeControl.value;

// Atualiza o volume em tempo real
sfx.volumeControl.addEventListener("input", () => {
    sfx.attack.volume = sfx.volumeControl.value;
    sfx.draw.volume = sfx.volumeControl.value;

    // Se quiser salvar a preferência do usuário:
    localStorage.setItem("sfxVolume", sfx.volumeControl.value);
});

// Recupera volume salvo (se existir)
const savedVolume = localStorage.getItem("sfxVolume");
if (savedVolume !== null) {
    sfx.volumeControl.value = savedVolume;
    sfx.attack.volume = savedVolume;
    sfx.draw.volume = savedVolume;
}

// Exemplo de uso nos momentos certos:
function atacar() {
    sfx.attack.currentTime = 0;
    sfx.attack.play();
    // lógica de ataque…
}

function comprarCarta() {
    sfx.draw.currentTime = 0;
    sfx.draw.play();
    // lógica de compra…
}

function init() {
    const bgm = document.getElementById("bgm");
    const muteButton = document.getElementById("toggle-mute");

    const isMuted = localStorage.getItem("bgmMuted") === "true";
    bgm.muted = isMuted
    muteButton.textContent = isMuted ? "🔇 Som Mutado" : "🔊 Som Ligado";

    // Espera a interação do usuário para reproduzir o som
    state.button.addEventListener("click", () => {
        if (bgm.paused) {
            bgm.play().catch((err) => {
                console.warn("Falha ao tocar o áudio:", err);
            });
        }
    });

    const startAudio = () => {
        if (bgm.paused) {
            bgm.play().catch((err) => {
                console.warn("Falha ao tocar o áudio:", err);
            });
        }
        // Só ativa uma vez
        document.removeEventListener("click", startAudio);
        document.removeEventListener("touchstart", startAudio);
    };

    // Reproduz música com primeira interação (clique ou toque)
    document.addEventListener("click", startAudio);
    document.addEventListener("touchstart", startAudio);


    // Botão de mudo alterna e salva a preferência
    muteButton.addEventListener("click", () => {
    	bgm.muted = !bgm.muted;
    	localStorage.setItem("bgmMuted", bgm.muted);// salva o estado
    	muteButton.textContent = bgm.muted ? "🔇 Som Mutado" : "🔊 Som Ligado";
    });
}

/**function init() {
	const bgm = document.getElementById("bgm");
	bgm.play();
}**/
init();


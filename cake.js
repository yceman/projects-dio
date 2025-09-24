class formaDeBolo {
	constructor(saborDaMassa, saborRecheio, saborCobertura) {
		this.saborDaMassa = saborDaMassa
		this.saborRecheio = saborRecheio
		this.saborCobertura = saborCobertura

		escrever() {
			console.log(`Um delicioso bolo de ${this.saborDaMassa}, com recheio de ${this.saborRecheio}`)
		}

		assar() {
			console.log("bolo assando de " + this.saborDaMassa)
		}
	}
}
/*Chantilli, Merengue, Ganache*/
let boloFesta = new formaDeBolo("chocolate", "nutella")
let boloPremium = new formaDeBolo("baunilha", "coco")

boloFesta.escrever()
boloPremium.escrever()@
boloPremium.assar()

console.log(boloFesta)

/*class formaDeBolo {
	constructor(saborDaMassa, saborRecheio) {
		this.saborDaMassa = saborDaMassa
		this.saborRecheio = saborRecheio
	}
}

let boloFesta = new formaDeBolo("massa de chocolate", "recheio de nutella")

console.log(boloFesta)*/
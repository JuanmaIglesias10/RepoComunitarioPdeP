import planetas.*

class Persona {
	var edad
	
	method edad() = edad
	method inteligencia() {
		if(edad.between(20,40)){
			return 12
		}
		else return 8
	}
	method potencia() = 20
	method esDestacado() = edad == 25 || edad == 35
	method darTributo(unPlaneta) {}
	method valor() = self.potencia() + self.inteligencia()
}


class Atleta inherits Persona {
	var masaMuscular = 4
	var cantidadDeTecnicas = 2
	
	override method potencia() = super() + (masaMuscular * cantidadDeTecnicas)
	override method esDestacado() = super() || cantidadDeTecnicas > 5
	
	method entrenar(unosDias) {
		masaMuscular += unosDias / 5
		}
	method aprenderUnaTecnica() {
		cantidadDeTecnicas ++
	}
	
	override method darTributo(unPlaneta) {
		unPlaneta.construirMurallas(2)
	}
}
	
class Docente inherits Persona {
	 var cantidadDeCursos = 0
	 
	 override method inteligencia() = super() + 2 * cantidadDeCursos
	 override method esDestacado() = cantidadDeCursos > 3
	 override method darTributo(unPlaneta) {
		unPlaneta.fundarMuseo()
	}
	override method valor() = super() + 5
}

class Soldado inherits Persona {
	var arsenal = #{}
	override method potencia() = super() + self.potenciaDelArsenal()
	override method darTributo(unPlaneta) {
		unPlaneta.construirMurallas(5)
	}
	method potenciaDelArsenal() {
		return arsenal.sum{unArma => unArma.potencia(self)}
	}
}

class Arma {
	method potencia(unSoldado)
}

class Pistolete inherits Arma {
	const largoEnCm
	override method potencia(unSoldado) {
		if(unSoldado.edad() > 30) {
			return largoEnCm * 3
		}
		else {
			return largoEnCm * 2
		}
	}
}

class Espadon inherits Arma {
	const pesoEnKg
	override method potencia(unSoldado) {
		if(unSoldado.edad() < 40) {
			return pesoEnKg / 2
		}
		else {
			return 6
		}
	}
}
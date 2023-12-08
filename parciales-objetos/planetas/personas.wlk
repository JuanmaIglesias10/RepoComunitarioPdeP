class Persona {
	var edad
	
	method inteligencia() {
		if(edad.between(20,40)){
			return 12
		}
		else return 8
	}
	
	method potencia() = 20
	method esDestacado() = edad == 25 || edad == 35
	method darTributo(unPlaneta) {}
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
}



















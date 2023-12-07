import equipamiento.*

class Habitante {
	const valentia
	const inteligencia
	
	method poder() = valentia + inteligencia
}
 
class Soldado inherits Habitante {
 	const equipamiento = []
 	
 	override method poder() = super() + self.poderPorEquipamiento()
 	
 	method poderPorEquipamiento() {
 		return self.equipoBueno().sum({equipo => equipo.potencia()})
 	}
 	
 	method equipoBueno() {
 		return equipamiento.filter({equipo => equipo.estaEnBuenEstado() && equipo.potencia() > 10})
 	} 	
 }
  
class Maestro inherits Habitante {
	const midiclorianos
 	var lado
 	const sableDeLuz
 	
 	method sableDeLuz() = sableDeLuz
 	method midiclorianos() = midiclorianos
 	method lado() = lado 
 	
 	override method poder() = super() + self.midiclorianos() / 1000 + lado.poderDeSable(sableDeLuz)

 	method cambiarDeLado() {
 		
 	}
 }

class Jedi {
	var tiempo
	method poderDeSable(unSable) = unSable.energia() * tiempo
}

class Sith {
	var tiempo
	method poderDeSable(unSable) = unSable.energia() *2 + tiempo
}

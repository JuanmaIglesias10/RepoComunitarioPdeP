import equipamiento.*
import sucesos.*

class Habitante {
	const valentia
	const inteligencia
	var equipamiento = []
	method poder() = valentia + inteligencia
}
 
class Soldado inherits Habitante {
 	override method poder() = super() + self.poderPorEquipamiento()
 	
 	method poderPorEquipamiento() {
 		return self.equipoBueno().sum({equipo => equipo.potencia()})
 	}
 	
 	method equipoBueno() {
 		return equipamiento.filter({equipo => equipo.estaEnBuenEstado() && equipo.potencia() > 10})
 	} 	
 }
  
class Maestro inherits Habitante (equipamiento = [sableDeLuz]) {
	const midiclorianos
 	var lado
 	const sableDeLuz
 	
 	method midiclorianos() = midiclorianos 
 	method cambiarLado(nuevoLado) {
 		lado = nuevoLado
 	}
 	
 	override method poder() = super() + self.midiclorianos() / 1000 + lado.poderDeSable(sableDeLuz)

 	method vivir(unSuceso) {
 		lado.pasoDelTiempo()
 		if (lado.esNecesarioCambiar(unSuceso.cargaEmocional())) {
 			if(lado.esIgualA(jedi)) {
 				self.cambiarLado(sith)
 			}
 			else self.cambiarLado(jedi)
 		}
 		else lado.modificarSentimiento(unSuceso.cargaEmocional())
 	}
 }

object jedi {
	var tiempo
	var pazInterior
	
	method esIgualA(jedi) {
    return self == jedi
	}
	
	method tiempo() = tiempo
	method pasoDelTiempo() {
		tiempo ++
	}
	
	method poderDeSable(unSable) = unSable.energia() * tiempo
	
	method esNecesarioCambiar(unaCargaEmocional) = unaCargaEmocional + pazInterior == 0
	
	method modificarSentimiento(unaCargaEmocional) {
		pazInterior += unaCargaEmocional
	}
}

object sith {
	var tiempo
	var odio
	method poderDeSable(unSable) = unSable.energia() *2 + tiempo
	
	method esNecesarioCambiar(unaCargaEmocional) = unaCargaEmocional > odio

	method modificarSentimiento(unaCargaEmocional) {
		odio += 0.1 * odio
	}
}
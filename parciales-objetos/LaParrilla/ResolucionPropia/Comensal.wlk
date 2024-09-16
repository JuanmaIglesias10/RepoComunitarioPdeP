// https://docs.google.com/document/u/1/d/e/2PACX-1vTk6E7nY0HX9aTxkGlGhojzd6y7PfNs0c0C0Qs6VgKm3cJoV5OjdptV48ovMyJmpPajgXx2OKiAdRF0/pub

import Plato.*

class NoTieneSuficienteDinero inherits Exception{}

class Comensal {
	var dineroDisponible
	var tipo
	
	
	method gastarDinero(unaCantidad) {
		dineroDisponible -= unaCantidad
	}
	method modificarTipo(nuevoTipo){
		tipo = nuevoTipo
	}
	method aumentarDinero(unaCantidad) {
		dineroDisponible += unaCantidad
	}
	method tieneDineroSuficiente(unosPlatos) = not self.platosQuePuedePagar(unosPlatos).isEmpty()
	method platosQuePuedePagar(unosPlatos) = unosPlatos.filter{unPlato => dineroDisponible >= unPlato.precio()}
	method platosAgradables(unosPlatos) = self.platosQuePuedePagar(unosPlatos).filter{unPlato => self.leGusta(unPlato)}
	method platoElegido(unaParrilla) = self.platosAgradables(unaParrilla.platos()).max{unPlato => unPlato.precio()}
	method precioPlatoElegido(unaParrilla) = self.platoElegido(unaParrilla).precio()


	method leGusta(unPlato) = tipo.condicionParaGustar(unPlato)
	method darseUnGustoEn(unaParrilla) {
		if (self.tieneDineroSuficiente(unaParrilla.platos())){
			self.gastarDinero(self.precioPlatoElegido(unaParrilla))
			unaParrilla.cobrar(self.precioPlatoElegido(unaParrilla))
			unaParrilla.agregarCliente(self)
		}
		else {
			throw new NoTieneSuficienteDinero(message = "No tienes dinero suficiente para comer aqui")
		}	
	}
	method problemasGastricos() {
		self.modificarTipo(celiaco)
	}
	method problemasEconomicos() {
		if (tipo.esDeTipo(paladarFino))
		self.modificarTipo(todoTerreno)
	}
}
object celiaco {
	method condicionParaGustar(unPlato) = unPlato.esAptaCeliacos()
	
}

object paladarFino {
	method condicionParaGustar(unPlato) = unPlato.esEspecial() or unPlato.valoracion() > 100 

	method esDeTipo(unTipo) = unTipo == self
}

object todoTerreno {
	method condicionParaGustar(unPlato) = true
}
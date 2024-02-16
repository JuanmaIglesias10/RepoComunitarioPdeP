import Caracteristica.*
import Fiesta.*

class Disfraz {
	const nombre
	const fechaDeConfeccion
    const nivelDeGracia
    const fechaDeCompra
	var caracteristicas = []

    method nivelDeGracia() = nivelDeGracia
    method fechaDeCompra() = fechaDeCompra
    method fechaDeConfeccion() = fechaDeConfeccion
    method nombre() = nombre

	method puntaje(unInvitado, unaFiesta) = caracteristicas.sum{unaCaracteristica => unaCaracteristica.puntaje(self, unInvitado, unaFiesta)}
}

const espiderman = new Disfraz(nombre = "espiderman", fechaDeConfeccion = 2, nivelDeGracia = 3, fechaDeCompra = 4, caracteristicas = [Gracioso]) // no se puede una clase
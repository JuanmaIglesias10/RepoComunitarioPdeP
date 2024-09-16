import Invitado.*

class Fiesta{
	var lugar
	const fechaDeFiesta
	var invitados = {}

    method fechaDeFiesta() = fechaDeFiesta

    method esUnBodrio() = invitados.all{unInvitado => not unInvitado.seConforma()}

    method mejorDisfraz() = invitados.max{unInvitado => unInvitado.disfraz().puntaje(unInvitado,self)}.disfraz()

	method puedenIntercambiar(unInvitado, otroInvitado) = self.ambosEstanEnLafiesta(unInvitado, otroInvitado) && self.algunoEstaDisconforme(unInvitado, otroInvitado) && self.quedanConformesConElCambio(unInvitado, otroInvitado) 
	
    method estaEnLaFiesta(unInvitado) = invitados.contains(unInvitado)

	method ambosEstanEnLafiesta(unInvitado, otroInvitado) = self.estaEnLaFiesta(unInvitado) && self.estaEnLaFiesta(otroInvitado)
	
	method algunoEstaDisconforme(unInvitado, otroInvitado) = unInvitado.estaDisconforme() || otroInvitado.estaDisconforme()

	method quedanConformesConElCambio(unInvitado, otroInvitado) {
        self.intercambiarDisfraces(unInvitado, otroInvitado)
        return not self.algunoEstaDisconforme(unInvitado, otroInvitado)
    }
    
    method intercambiarDisfraces(unInvitado, otroInvitado) {
    	unInvitado.cambiarDeDisfraz(otroInvitado.disfraz())
    	otroInvitado.cambiarDeDisfraz(unInvitado.disfraz())
    }

    method agregarInvitado(unInvitado) {
        if (unInvitado.disfraz() == null && self.estaEnLaFiesta(unInvitado)) invitados.add(unInvitado)
    }
}

const fiestaInolvidable = new Fiesta(lugar = "Bulogne", fechaDeFiesta = 99, invitados = [pepe])
import Disfraz.*
import Invitado.*
import Fiesta.*

class Caracteristica {
    method puntaje(unDisfraz, unInvitado, unaFiesta)
}

class Gracioso inherits Caracteristica {
    override method puntaje(unDisfraz, unInvitado, unaFiesta) {
        if(unInvitado.edad() > 50) return unDisfraz.nivelDeGracia() * 3
        else return unDisfraz.nivelDeGracia()
    }	
}

class Tobara inherits Caracteristica {
    override method puntaje(unDisfraz,unInvitado, unaFiesta) {
        if(unDisfraz.fechaDeCompra() <= unaFiesta.fechaDeFiesta() - 2) return 5
        else return 3
    }
}

class Careta inherits Caracteristica {
    const nombre
    const valor
    override method puntaje(unDisfraz,unInvitado, unaFiesta) = unInvitado.valor()
}
	
class Sexies inherits Caracteristica {
    override method puntaje(unDisfraz,unInvitado, unaFiesta) {
        if(unInvitado.esSexy()) return 15
        else return 2
    }
}


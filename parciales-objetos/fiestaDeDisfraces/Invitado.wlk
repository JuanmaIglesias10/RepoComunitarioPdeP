import Disfraz.*

class Invitado {
	var disfraz
	var edad
    var personalidad
    const exigencia

	method edad() = edad
    method disfraz() = disfraz
	
	method cambiarDeDisfraz(unDisfraz) {
		disfraz = unDisfraz
	}
    
    method esSexy() = personalidad.haceSexy(self)

    method seConforma() = exigencia.seConforma(self.disfraz())

	method estaDisconforme() = not self.seConforma()
}

object alegre {
    method haceSexy(unInvitado) = false
}

object taciturno {
    method haceSexy(unInvitado) = unInvitado.edad() < 30
}

/*object cambiante {
    method haceSexy(unInvitado) = 
}
*/

class Exigencia {
    method seConforma(unDisfraz) = unDisfraz.puntaje() > 10
}

class Caprichoso inherits Exigencia {
    override method seConforma(unDisfraz) = super(unDisfraz) && unDisfraz.nombre().size().even()
}

class Pretencioso inherits Exigencia {
    override method seConforma(unDisfraz) = super(unDisfraz) && unDisfraz.fechaDeConfeccion() < 30
}

class Numerologo inherits Exigencia {
    var unPuntaje
    override method seConforma(unDisfraz) = super(unDisfraz) && unDisfraz.puntaje() == unPuntaje
}

const pepe = new Invitado(disfraz = espiderman, edad = 90, personalidad = alegre, exigencia = exigenciaCaprichosa)

const exigenciaCaprichosa = new Caprichoso()





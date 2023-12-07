import Platos.*

class Cocinero {
    var especialidad 
    method catar(unPlato) = especialidad.calificar(unPlato) 
    method cambiarDeEspecialidad(nuevaEspecialidad) {
        especialidad = nuevaEspecialidad
    }
    method cocinar() = especialidad.crear()
}

class Pastelero {
    const nivelDeDulzor
    method calificar(unPlato) = 5 * unPlato.cantidadDeAzucar() / nivelDeDulzor

    method crear() =  new Postre(cantidadDeColores = nivelDeDulzor / 50, autor = self)
}

class Chef {
    const cantDeCalorias

    method cantDeCalorias() = cantDeCalorias
    method notaMinima(unPlato) = 0

    method calificar(unPlato) {
        if (self.aprobadoPorChef(unPlato)) {return 10}
        else {return self.notaMinima(unPlato)}
    }

    method aprobadoPorChef(unPlato) {
        return unPlato.esBonito() && unPlato.calorias() <= cantDeCalorias
    }

    method crear() = new Principal(cantidadDeAzucar = cantDeCalorias , esBonito = true,autor = self)
}

class Souschef inherits Chef {
    
    override method notaMinima(unPlato) = (unPlato.calorias() / 100).min(6)

    override method crear() = new Entrada(autor = self)
}
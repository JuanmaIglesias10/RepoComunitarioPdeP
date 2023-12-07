class Plato {
    const autor
    
    
    method autor() = autor
    method esBonito()
    method cantidadDeAzucar()
    method calorias() {
        return 100 + self.cantidadDeAzucar() * 3
    }
}

class Entrada inherits Plato {
    override method cantidadDeAzucar() = 0
    override method esBonito() = true
}

class Principal inherits Plato {
    var cantidadDeAzucar
    var esBonito

    override method cantidadDeAzucar() = cantidadDeAzucar
    override method esBonito() = esBonito    

}

class Postre inherits Plato {
    var cantidadDeColores
    override method cantidadDeAzucar() = 120
    override method esBonito() = cantidadDeColores > 3
}
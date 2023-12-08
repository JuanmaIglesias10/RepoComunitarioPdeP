import tiposDePanes.*

class Plato {
	
	method baseDePrecio() = self.valoracion() * 300 
	
	method peso()
	method esAptoCeliaco()
	method valoracion()
	method esEspecial() = self.peso() > 250 
	method precio() {
		if (self.esAptoCeliaco()) {
			return self.baseDePrecio() + 1200
		}
		else {
			return self.baseDePrecio() 
		}
	} 
}

class Provoleta inherits Plato {
	const estaEmpanado
	
	override method esAptoCeliaco() = not estaEmpanado
	override method esEspecial() = super() and estaEmpanado
	override method valoracion() {
		if (self.esEspecial()){return 120}
		else {return 80}
	}
}

class BurgaSimple inherits Plato {
	var tipoDePan
	const pesoDeMedallon
	const cantMedallones = 1
	
	override method esAptoCeliaco() = tipoDePan.esAptoCeliaco()
	override method peso() = tipoDePan.peso() * cantMedallones + pesoDeMedallon
	override method valoracion() = self.peso() / 10	
}

class BurgaDoble inherits BurgaSimple(cantMedallones = 2 ){
	override method esEspecial() = self.peso() > 500
}

class CorteDeCarne inherits Plato {
	const corteElegido
	const puntoDeCoccion
	const peso
	
	override method esEspecial() = super() and puntoDeCoccion == "a punto"
	override method esAptoCeliaco() = true
	override method valoracion() = 100
	}

class Lugar {
	const nombre
	
	method esDivertido() = nombre.size() % 2 == 0
	method esTranquilo()
	method tieneNombreRaro() = nombre.size() > 10
}

class Ciudad inherits Lugar {
	var cantHabitantes
	var atraccionesTuristicas = []
	const promedioDeDecibeles
	
	method condicionParaSerDivertido() = atraccionesTuristicas.size() > 3 and cantHabitantes > 100000
	override method esTranquilo() = promedioDeDecibeles < 20 
	
	override method esDivertido() = super() and self.condicionParaSerDivertido()
	
}

class Pueblo inherits Lugar {
	const extension
	const fechaDeFundacion
	const ubicacion
	
	method esDelLitorial() {
		const litoral = ["Entre Rios","Corrientes","Misiones"]
		return litoral.contains(ubicacion)
	}

	override method esTranquilo() = ubicacion == "La Pampa"
	
	override method esDivertido() = fechaDeFundacion < 1800 or self.esDelLitorial() 
}

class Balneario inherits Lugar {
	const metrosDePlayaPromedio
	const elMarEsPeligroso
	const tienePeatonal

	override method esTranquilo() = not tienePeatonal

	override method esDivertido() = metrosDePlayaPromedio > 300 and elMarEsPeligroso
}
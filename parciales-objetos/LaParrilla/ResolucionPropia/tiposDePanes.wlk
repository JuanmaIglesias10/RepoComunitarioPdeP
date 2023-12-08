object panIndustrial {
	method peso() = 60
	method esAptoCeliaco() = false
}

object panCasero {

	method peso() = 100
	method esAptoCeliaco() = false
}

object panDeMaiz {
	method peso() = 30
	method esAptoCeliaco() = true
}

/* OTRA MANERA MAS CORRECTA
 * class Pan{
	var property peso
	var property aptoCeliacos = false
}

const panIndustrial = new Pan(peso = 60)
const panCasero = new Pan(peso = 100)
const panMaiz = new Pan(peso = 30, aptoCeliacos = true)
 * 
 */
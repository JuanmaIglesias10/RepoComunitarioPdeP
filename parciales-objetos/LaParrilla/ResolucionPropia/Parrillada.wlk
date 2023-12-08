import Plato.*
import tiposDePanes.*

class Parrillada inherits Plato {
	const platos = []
	
	override method peso() = platos.sum{unPlato => unPlato.peso()}
	override method esEspecial() = super() and platos.size() >= 3
	override method esAptoCeliaco() = platos.all{unPlato => unPlato.esAptaCeliacos()}
	override method valoracion() = platos.max{unPlato => unPlato.valoracion()}
	
}

import Plato.*
import tiposDePanes.*

class Parrillada {
	const platos = []
	
	method peso() = platos.sum{unPlato => unPlato.peso()}
	method esEspecial() = self.peso() > 250 and platos.size() >= 3
	method esAptaCeliacos() = platos.all{unPlato => unPlato.esAptaCeliacos()}
	method valoracion() = platos.max{unPlato => unPlato.valoracion()}
	
}

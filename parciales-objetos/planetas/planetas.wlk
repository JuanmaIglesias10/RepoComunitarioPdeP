import personas.*

class Planeta {
	var habitantes = #{}
	var cantidadDeMuseos
	var longitudDeMurallas
	
	method delegacionDiplomatica() = habitantes.filter{unaPersona => unaPersona.esDestacado()}
		
	method esCulto() = cantidadDeMuseos >= 2 && self.sonTodosGenios()
	
	method sonTodosGenios() = habitantes.all{unHabitante => unHabitante.inteligencia() >= 10}
	
	method potenciaReal() = habitantes.sum{unHabitante => unHabitante.potencia()}
	
	method construirMurallas(unaCantidad) {
		longitudDeMurallas += unaCantidad
	}
	method fundarMuseo() {
		cantidadDeMuseos ++
	}
	
	method potenciaAparente() {
		return self.potenciaDelMasPotente() * habitantes.size()
	}
	
	method potenciaDelMasPotente() {
		return habitantes.max{unHabitante => unHabitante.potencia()}.potencia()
	}
	
	method necesitaReforzarse() = self.potenciaAparente() >= self.potenciaReal() * 2
	
	method recibirTributo() {
		habitantes.forEach{persona => persona.darTributo(self)}
	}
}


const juanma = new Persona(edad = 21)
const facu = new Atleta(edad = 21)

const marte = new Planeta(habitantes = #{juanma, facu}, cantidadDeMuseos = 2, longitudDeMurallas = 2)

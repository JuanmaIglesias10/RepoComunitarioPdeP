import Persona.*
import Lugares.*

class Tour {
	const fechaSalida
	const cantidadPersonasRequeridas
	const ciudadesARecorrer = []
	const montoPorPersona
	var personasConfirmadas = #{}	
	
	method cantidadPersonasConfirmadas() = personasConfirmadas.size()
	
	method puedePagar(unaPersona) = unaPersona.puedePagar(montoPorPersona)
	method tieneLugaresAdecuadosPara(unaPersona) = ciudadesARecorrer.all{unLugar => unaPersona.puedeIrDeVacaciones(unLugar)}
	method puedeHacerElTour(unaPersona) = self.puedePagar(unaPersona) and self.tieneLugaresAdecuadosPara(unaPersona)
	
	method estaPendienteDeConfirmacion() = self.cantidadPersonasConfirmadas() < cantidadPersonasRequeridas 
	method saleEsteAnio(unAnio) = fechaSalida == unAnio
	method recaudacion() = self.cantidadPersonasConfirmadas()  * montoPorPersona

	method bajar(unaPersona) {
		personasConfirmadas.remove(unaPersona)
	}
	
	method agregar(unaPersona) {
		if(self.puedeHacerElTour(unaPersona) and self.estaPendienteDeConfirmacion()){
			personasConfirmadas.add(unaPersona)
		}
	}
	method seConfirmaElTour() = personasConfirmadas.size() == cantidadPersonasRequeridas 
}

import Lugares.*

class Persona {
	var preferencias = []
	const presupuestoMaximo

	method presupuestoMaximo() = presupuestoMaximo
	method puedePagar(unaCantidad) = presupuestoMaximo >= unaCantidad
	
	method puedeIrDeVacaciones(unLugar) = preferencias.any{preferencia => preferencia.criterioParaIr(unLugar)}
	method cambiarPreferencia(nuevaPreferencia) {
		preferencias = [nuevaPreferencia]
	}
	method agregar(nuevaPreferencia) {
		preferencias.add(nuevaPreferencia)
	}
}

object tranquilidad {
	method criterioParaIr(unLugar) = unLugar.esTranquilo()
}

object diversion {
	method criterioParaIr(unLugar) = unLugar.esDivertido()
}

object raro {
	method criterioParaIr(unLugar) = unLugar.tieneNombreRaro()
}
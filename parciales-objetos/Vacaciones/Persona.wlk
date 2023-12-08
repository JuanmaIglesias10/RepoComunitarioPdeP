class Persona {
	var preferencias = []
	
	
	method irDeVacaciones(unLugar) = preferencias.criterioParaIr(unLugar)
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

object variosCriterios {
	method criterioParaIr(unLugar) = 
}
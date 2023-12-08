object parrillaDeMiguelito {
	const platos = []
	var clientes = #{}
	var ingresos 
	
	method platos() = platos
	method cobrar(unaCantidad){
		ingresos += unaCantidad
	}	

	method agregarCliente(unCliente) {
		clientes.add(unCliente)
	}
	
	method promocion(unaCantidad) {
		clientes.forEach{unCliente => unCliente.aumentarDinero(unaCantidad)}
	}
}

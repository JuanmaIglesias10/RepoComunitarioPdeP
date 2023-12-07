object parrillaDeMiguelito {
	const platos = []
	var clientes = #{}
	
	method platos() = platos
	
	method agregarCliente(unCliente) {
		clientes.add(unCliente)
	}
	
	method promocion(unaCantidad) {
		clientes.forEach{unCliente => unCliente.aumentarDinero(unaCantidad)}
	}
}

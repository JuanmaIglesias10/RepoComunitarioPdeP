import usuario.*

object portal {
	var usuarios = #{}
	
	method recategorizacionGeneral() {
		usuarios.forEach{unUsuario => unUsuario.recategorizarse()}
	}
	method cantidadDePostInteresantes(unUsuario) = unUsuario.cantidadDePostInteresantes()
}
import posts.*

class Usuario {
	var posts = []
	var categoria
	
	method puntaje() = posts.sum{unPost => unPost.valor()}
	method crearPost() = categoria.crearPost()
	method comentar(unPost, unComentario) {
		if(unPost.estaAbierto()) {
			unPost.comentarios().add(unComentario)
		}
	}
	method calificar(unPost, unPuntaje) = unPost.calificaciones().add(unPuntaje)
	method tieneMasPuntosQue(unPuntaje) = self.puntaje() > unPuntaje
	method tienePostMuyValorado() = posts.any{unPost => unPost.valor() > 500}
	method recategorizarse() {
		categoria = categoria.recategorizar(self)
	}
	method cantidadDePostInteresantes() = posts.filter{unPost => unPost.esInteresante()}.size()
}


object novato {
	
	method crearPost() = new Post ()
	method recategorizar(unUsuario) {
		if(unUsuario.tieneMasPuntosQue(100)) {
			return intermedio
		}
		else return self
	}
}

object intermedio {
	method crearPost() = new Post ()
	method recategorizar(unUsuario) {
		if(unUsuario.tieneMasPuntosQue(1000) && unUsuario.tienePostMuyValorado()) {
			return experto
		}
		else return self
	}
}

object experto {
	method crearPost() = new PostPremium ()
	method recategorizar(unUsuario) = self
}

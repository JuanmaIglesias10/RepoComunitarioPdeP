class Post {
	var calificaciones = []
	var comentarios = []
	var estaAbierto = true
	
	method valor() {
		return comentarios.size() + calificaciones.sum()
	}
	method comentarios() = comentarios
	method calificaciones() = calificaciones
	method esInteresante() = self.tiene20extensos() && self.valor() >= 300
	method tiene20extensos() = comentarios.filter{unComentario => unComentario.size() > 240}.size() >= 20
}

class PostPremium inherits Post {
	override method valor() = super() + calificaciones.sum()
	override method esInteresante() = self.valor() >= 300 && comentarios.all{unComentario => unComentario.size() > 240}
}
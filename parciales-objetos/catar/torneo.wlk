import Cocineros.*
import Platos.*

class Torneo {
    const catadores = #{}    
    var platosParticipantes = #{}
    
    method agregarParticipante(unParticipante) {
        platosParticipantes.add(unParticipante.cocinar())
    }

    method puntuacionDeUnPlato(unPlato) {
        return catadores.sum{unCatador => unCatador.catar(unPlato)}
    }

    method hayParticipantes() = not platosParticipantes.isEmpty()

    method ordenarPlatos() {
        return platosParticipantes.sortedBy{unPlato,otroPlato => self.puntuacionDeUnPlato(unPlato) > self.puntuacionDeUnPlato(otroPlato)}
    }
    
    method platoGanador() {
        if (self.hayParticipantes()) {
            self.ordenarPlatos().first().autor()
        }
    }
}
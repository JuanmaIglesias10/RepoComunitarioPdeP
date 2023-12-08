import Tour.*

class Reporte {
	const tours = []
	
	method pendientesDeConfirmacion() = tours.filter{unTour => unTour.estaPendienteDeConfirmacion()}
	method toursQueSalenEsteAnio() = tours.filter{unTour => unTour.saleEsteAnio(2023)}
	method recaudacionTotal2023() = self.toursQueSalenEsteAnio().sum{unTour => unTour.recaudacion()}
}

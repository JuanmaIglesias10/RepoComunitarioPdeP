import Text.Show.Functions()

data Personaje = UnPersonaje {
    nombre :: String,
    dinero :: Int,
    felicidad :: Int
} deriving (Show,Eq)

modificarDinero :: (Int -> Int) -> Personaje -> Personaje
modificarDinero unaFuncion unPersonaje = unPersonaje {dinero = unaFuncion . dinero $ unPersonaje}

modificarFelicidad :: (Int -> Int) -> Personaje -> Personaje
modificarFelicidad unaFuncion unPersonaje = unPersonaje {felicidad = unaFuncion . felicidad $ unPersonaje}

restarDinero :: Int -> Personaje -> Personaje
restarDinero unaCantidad unPersonaje = modificarDinero (subtract unaCantidad) unPersonaje

aumentarFelicidad :: Int -> Personaje -> Personaje
aumentarFelicidad unaCantidad unPersonaje = modificarFelicidad (+ unaCantidad) unPersonaje

restarFelicidad :: Int -> Personaje -> Personaje
restarFelicidad unaCantidad unPersonaje = modificarFelicidad (max 0 . (subtract unaCantidad)) unPersonaje

type Actividad = Personaje -> Personaje

--PUNTO 1

irALaEscuela :: Actividad
irALaEscuela unPersonaje
    | esLisa unPersonaje = aumentarFelicidad 20 unPersonaje
    | otherwise = modificarFelicidad (subtract 20) unPersonaje

esLisa :: Personaje -> Bool
esLisa unPersonaje = nombre unPersonaje == "Lisa"

comerUnasDonas :: Int -> Actividad
comerUnasDonas unaCantidad unPersonaje = restarDinero 10 . aumentarFelicidad (10 * unaCantidad) $ unPersonaje

irATrabajar :: String -> Actividad
irATrabajar unTrabajo unPersonaje = modificarDinero (+ length unTrabajo) unPersonaje

irATrabajarComoDirector :: Actividad
irATrabajarComoDirector unPersonaje = irATrabajar "Escuela Elemental" . irALaEscuela $ unPersonaje

--INVENTADO

comprarUnAutoDeLujo :: Int -> Actividad
comprarUnAutoDeLujo unPrecio unPersonaje = modificarFelicidad (+ 1000) . restarDinero unPrecio $ unPersonaje

homero :: Personaje
homero = UnPersonaje "Homero" 1000 100

skinner :: Personaje
skinner = UnPersonaje "Skinner" 1500 20

lisa :: Personaje
lisa = UnPersonaje "Lisa" 100 150

{- INVOCACIONES
    > comerUnasDonas 12 homero
    > UnPersonaje {nombre = "Homero", dinero = 990, felicidad = 220}

    > irATrabajarComoDirector skinner
    > UnPersonaje {nombre = "Skinner", dinero = 1517, felicidad = 0}

    > comprarUnAutoDeLujo 100000 . irALaEscuela $ lisa
    > UnPersonaje {nombre = "Lisa", dinero = -99900, felicidad = 1170}
-}

--PUNTO 2


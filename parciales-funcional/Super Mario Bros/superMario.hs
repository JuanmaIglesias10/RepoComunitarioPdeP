import Data.List (isInfixOf)
import Text.Show.Functions()
import Data.Char (isUpper)
data Plomero = UnPlomero {
    nombre :: String,
    cajaDeHerramientas :: [Herramienta],
    historialDeReparaciones :: [Reparacion],
    dinero :: Float
} deriving Show

data Herramienta = UnaHerramienta {
    denominacion :: String,
    precio :: Float,
    materialDelMango :: String
} deriving (Show,Eq)

data Reparacion = UnaReparacion {
    descripcion :: String,
    requerimiento :: Requerimiento
} deriving Show

type Requerimiento = Plomero -> Bool

modificarPrecio :: (Float -> Float) -> Herramienta -> Herramienta
modificarPrecio unaFuncion unaHerramienta = unaHerramienta {precio = unaFuncion . precio $ unaHerramienta}

modificarDinero :: (Float -> Float) -> Plomero -> Plomero
modificarDinero unaFuncion unPlomero = unPlomero {dinero = unaFuncion . dinero $ unPlomero}

modificarCajaDeHerramientas :: ([Herramienta] -> [Herramienta]) -> Plomero -> Plomero
modificarCajaDeHerramientas unaFuncion unPlomero = unPlomero {cajaDeHerramientas = unaFuncion . cajaDeHerramientas $ unPlomero}

--PUNTO 1
mario :: Plomero
mario = UnPlomero "Mario" [llaveInglesa, martillo] [] 1200 

llaveInglesa :: Herramienta
llaveInglesa = UnaHerramienta "llave inglesa" 200 "hierro"

llaveFrancesa :: Herramienta
llaveFrancesa = UnaHerramienta "llave francesa" 0 "hierro"

martillo :: Herramienta
martillo = UnaHerramienta "Martillo" 20 "Madera"

wario :: Plomero
wario = UnPlomero "Wario" infinitasLlavesFrancesasConInflacion [] 0.05

infinitasLlavesFrancesasConInflacion :: [Herramienta]
infinitasLlavesFrancesasConInflacion = iterate (modificarPrecio (+1)) llaveFrancesa

--PUNTO 2

tiene :: Herramienta -> Plomero -> Bool
tiene unaHerramienta unPlomero = elem unaHerramienta (cajaDeHerramientas unPlomero)

esMalvado :: Plomero -> Bool
esMalvado unPlomero = isInfixOf "Wa" (nombre unPlomero)

puedeComprar :: Herramienta -> Plomero -> Bool
puedeComprar unaHerramienta unPlomero = dinero unPlomero >= precio unaHerramienta

--PUNTO 3

esBuena :: Herramienta -> Bool
esBuena unaHerramienta = mangoDeHierroYCaro unaHerramienta || esMartilloCheto unaHerramienta  

mangoDeHierroYCaro :: Herramienta -> Bool
mangoDeHierroYCaro unaHerramienta = tieneMangoDe "Hierro" unaHerramienta && saleMasDe 10000 unaHerramienta

tieneMangoDe :: String -> Herramienta -> Bool
tieneMangoDe unMango unaHerramienta = materialDelMango unaHerramienta == unMango

saleMasDe :: Float -> Herramienta -> Bool
saleMasDe unPrecio unaHerramienta = precio unaHerramienta > unPrecio

esMartilloCheto :: Herramienta -> Bool
esMartilloCheto unaHerramienta = denominacion unaHerramienta == "martillo" && tieneMangoDeMaderaOGoma unaHerramienta

tieneMangoDeMaderaOGoma :: Herramienta -> Bool
tieneMangoDeMaderaOGoma unaHerramienta = tieneMangoDe "madera" unaHerramienta || tieneMangoDe "goma" unaHerramienta

-- PUNTO 4

comprar :: Herramienta -> Plomero -> Plomero
comprar unaHerramienta unPlomero 
    | puedeComprar unaHerramienta unPlomero = modificarDinero(subtract (precio unaHerramienta)) . modificarCajaDeHerramientas (unaHerramienta :) $ unPlomero
    | otherwise = unPlomero


--PUNTO 5
filtracionDeAgua :: Reparacion
filtracionDeAgua = UnaReparacion "se escapa agua de un canio" (tieneHerramienta llaveInglesa)

tieneHerramienta :: Herramienta -> Requerimiento
tieneHerramienta unaHerramienta unPlomero = elem unaHerramienta (cajaDeHerramientas unPlomero)

esDificil :: Reparacion -> Bool
esDificil unaReparacion = descripcionComplicada unaReparacion && (esGritando unaReparacion)

descripcionComplicada :: Reparacion -> Bool
descripcionComplicada unaReparacion = 100 < largoDeLaDescripcion unaReparacion

largoDeLaDescripcion :: Reparacion -> Int
largoDeLaDescripcion unaReparacion = length (descripcion unaReparacion)

esGritando :: Reparacion -> Bool
esGritando unaReparacion = all isUpper (descripcion unaReparacion)

presupuesto :: Reparacion -> Float
presupuesto unaReparacion = fromIntegral(3 * largoDeLaDescripcion unaReparacion)

--PUNTO 6

puedeHacerReparacion :: Reparacion -> Plomero -> Bool
puedeHacerReparacion unaReparacion unPlomero = (cumpleRequerimiento unaReparacion unPlomero) || esMaloConMartillo unPlomero

cumpleRequerimiento :: Reparacion -> Plomero -> Bool
cumpleRequerimiento unaReparacion unPlomero = requerimiento unaReparacion unPlomero

esMaloConMartillo :: Plomero -> Bool
esMaloConMartillo unPlomero = esMalvado unPlomero && tieneHerramienta martillo unPlomero

hacerReparacion :: Reparacion -> Plomero -> Plomero
hacerReparacion unaReparacion unPlomero
    | puedeHacerReparacion unaReparacion unPlomero = (extraSegunSituacion unaReparacion) . (hacerYCobrar unaReparacion) $ unPlomero
    | otherwise = modificarDinero (+100) unPlomero

hacerYCobrar :: Reparacion -> Plomero -> Plomero
hacerYCobrar unaReparacion unPlomero = modificarDinero (+ presupuesto unaReparacion) unPlomero

extraSegunSituacion :: Reparacion -> Plomero -> Plomero
extraSegunSituacion unaReparacion unPlomero
    | not . esMalvado $ unPlomero = hacerSegunDificultad unPlomero unaReparacion
    | otherwise = modificarCajaDeHerramientas (UnaHerramienta "destornillador" 0 "plastico":) unPlomero

hacerSegunDificultad :: Plomero -> Reparacion -> Plomero
hacerSegunDificultad unPlomero unaReparacion
    | esDificil unaReparacion = modificarCajaDeHerramientas(filter (not . esBuena)) unPlomero
    | otherwise               = modificarCajaDeHerramientas tail unPlomero

--PUNTO 7

jornadaDeTrabajo :: [Reparacion] -> Plomero -> Plomero
jornadaDeTrabajo unasReparaciones unPlomero  = foldr hacerReparacion unPlomero unasReparaciones

--PUNTO 8

type Criterio = Plomero -> Float

elMasAlgoSegunCriterio :: Criterio -> [Plomero] -> [Reparacion] -> Plomero
elMasAlgoSegunCriterio unCriterio unosPlomeros unasReparaciones = foldl1 (elMasAlgoEntre2 unCriterio) (map (jornadaDeTrabajo unasReparaciones) unosPlomeros)

elMasAlgoEntre2 :: Criterio -> Plomero -> Plomero -> Plomero 
elMasAlgoEntre2 unCriterio unPlomero otroPlomero 
    | unCriterio unPlomero > unCriterio otroPlomero = unPlomero
    | otherwise = otroPlomero

cantidadDeReparaciones :: Criterio
cantidadDeReparaciones unPlomero = fromIntegral (length . historialDeReparaciones $ unPlomero)

adinerado :: Criterio 
adinerado unPlomero =  dinero unPlomero

inversor :: Criterio
inversor unPlomero = sum . map precio . cajaDeHerramientas $ unPlomero

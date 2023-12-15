import Text.Show.Functions()
import Control.Concurrent.STM (check)
import Data.Time.Format.ISO8601 (durationDaysFormat)

type Poder = Nave -> Nave
data Nave = UnaNave {
    nombre :: String,
    durabilidad :: Int,
    escudo :: Int,
    ataque :: Int,
    poder :: Poder
} deriving Show

--ACCESORS
modificarAtaque :: (Int -> Int) -> Nave -> Nave
modificarAtaque unaFuncion unaNave = unaNave {ataque = unaFuncion . ataque $ unaNave}

modificarDurabilidad :: (Int -> Int) -> Nave -> Nave
modificarDurabilidad unaFuncion unaNave = unaNave {durabilidad = unaFuncion . durabilidad $ unaNave}

modificarEscudo :: (Int -> Int) -> Nave -> Nave
modificarEscudo unaFuncion unaNave = unaNave {escudo = unaFuncion . escudo $ unaNave}

restarDurabilidad :: Int -> Nave -> Nave
restarDurabilidad unaCantidad unaNave = modificarDurabilidad (subtract unaCantidad) unaNave

--NAVES
tieFighter :: Nave
tieFighter = UnaNave "TIE Fighter" 200 100 50 movimientoTurbo

xWing :: Nave
xWing = UnaNave "X Wing" 300 150 100 reparacionDeEmergencia

naveDarthVader :: Nave
naveDarthVader = UnaNave "Nave de Darth Vader" 500 300 200 movimientoSuperTurbo

millenniumFalcon :: Nave
millenniumFalcon = UnaNave "Millennium Falcon" 1000 500 50 reparacionYEscudos

laHaskellNeta :: Nave
laHaskellNeta = UnaNave "La maldita haskellNeta full maleducada" 1000000 50000 999 poderDeLosDioses

-- PODERES
movimientoTurbo :: Poder
movimientoTurbo unaNave = modificarAtaque (+25) unaNave

reparacionDeEmergencia :: Poder
reparacionDeEmergencia unaNave = modificarDurabilidad (+50) . modificarAtaque (subtract 30) $ unaNave

movimientoSuperTurbo :: Poder
movimientoSuperTurbo unaNave = modificarDurabilidad (subtract 45) . turboXveces 3 $ unaNave

turboXveces :: Int -> Nave -> Nave
turboXveces unaCantidad unaNave = foldr ($) unaNave (replicate unaCantidad movimientoTurbo)

reparacionYEscudos :: Poder
reparacionYEscudos unaNave = modificarEscudo (+100) . reparacionDeEmergencia $ unaNave

poderDeLosDioses :: Poder
poderDeLosDioses unaNave = reparacionYEscudos . movimientoSuperTurbo $ unaNave

--2
durabilidadTotal :: [Nave] -> Int
durabilidadTotal unasNaves = sum . map (durabilidad) $ unasNaves

--3

comoQuedoUnaNaveDespuesDeSerAtacada :: Nave -> Nave -> Nave
comoQuedoUnaNaveDespuesDeSerAtacada naveAtacante naveAtacada = actualizarNaveAtacada (activarPoder naveAtacada) (activarPoder naveAtacante)

actualizarNaveAtacada :: Nave -> Nave -> Nave
actualizarNaveAtacada naveAtacada naveAtacante
    | ataque naveAtacante > escudo naveAtacada = modificarDurabilidad (subtract (calcularNivelDeDano naveAtacante naveAtacada)) naveAtacada
    | otherwise = naveAtacada

calcularNivelDeDano :: Nave -> Nave -> Int
calcularNivelDeDano naveAtacante naveAtacada = ataque naveAtacante - escudo naveAtacada

activarPoder :: Nave -> Nave 
activarPoder unaNave = poder unaNave unaNave



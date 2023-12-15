import Text.Show.Functions()

data Serie = UnaSerie {
    titulo :: String,
    participantes :: [Actor],
    presupuesto :: Int,
    cantidadTemporadas :: Int,
    ratingPromedio :: Int,
    estaCancelada :: Bool
} deriving Show

data Actor = UnActor {
    nombre :: String,
    sueldoPretendido :: Int,
    restricciones :: [String]
} deriving Show

modificarParticipantes :: ([Actor] -> [Actor]) -> Serie -> Serie
modificarParticipantes unaFuncion unaSerie = unaSerie {participantes = unaFuncion . participantes $ unaSerie}

modificarTemporadas :: (Int -> Int) -> Serie -> Serie
modificarTemporadas unaFuncion unaSerie = unaSerie{cantidadTemporadas = unaFuncion . cantidadTemporadas $ unaSerie}

modificarCancelacion :: (Bool -> Bool) -> Serie -> Serie
modificarCancelacion unaFuncion unaSerie = unaSerie{estaCancelada = unaFuncion . estaCancelada $ unaSerie}



--PUNTO 1

estaEnRojo :: Serie -> Bool
estaEnRojo unaSerie = (> presupuesto unaSerie) . sum . map sueldoPretendido $ participantes unaSerie

esProblematica :: Serie -> Bool
esProblematica unaSerie =  (>3) . length . actoresConMasDeNRestricciones 2  $ participantes unaSerie

actoresConMasDeNRestricciones :: Int -> [Actor] -> [Actor]
actoresConMasDeNRestricciones unaCantidad unosActores = filter ((>= unaCantidad) . length . restricciones) unosActores 

--PUNTO 2

johnnyDeep :: Actor
johnnyDeep = UnActor "Johnny Deep" 20000000 []

helenaBonham :: Actor
helenaBonham = UnActor "Helena Bonham" 15000000 []

type Productor = Serie -> Serie

conFavoritismos :: [Actor] -> Productor
conFavoritismos actoresFavoritos unaSerie =  modificarParticipantes ((++ actoresFavoritos) . drop 2)  unaSerie

timBurton :: Productor
timBurton unaSerie = conFavoritismos [johnnyDeep , helenaBonham] unaSerie

gatoPardeitor :: Productor
gatoPardeitor = id

estireitor :: Productor
estireitor unaSerie = modificarTemporadas (*2) unaSerie

desespereitor :: Productor 
desespereitor unaSerie = gatoPardeitor . estireitor $ unaSerie

canceleitor :: Int -> Productor
canceleitor unaCantidad unaSerie 
    | estaEnRojo unaSerie || ratingPromedio unaSerie > unaCantidad = seCancela unaSerie 
    | otherwise = unaSerie

seCancela :: Serie -> Serie
seCancela unaSerie = modificarCancelacion (const True) unaSerie

--PUNTO 3
bienestar :: Serie -> Int
bienestar unaSerie
    | estaCancelada unaSerie == True = 0
    | otherwise = calcularBienestar unaSerie

calcularBienestar :: Serie -> Int
calcularBienestar unaSerie
    | estaCancelada unaSerie = 0
    | otherwise = bienestarSegunTemporadas unaSerie + bienestarSegunActores unaSerie

bienestarSegunActores :: Serie -> Int
bienestarSegunActores unaSerie 
    | tieneMenosDe10Actores unaSerie = 3
    | otherwise = subtract 10 (cantidadDeActoresConRestricciones (participantes unaSerie)) 

tieneMenosDe10Actores :: Serie -> Bool
tieneMenosDe10Actores unaSerie = (<10) . length . participantes $ unaSerie

cantidadDeActoresConRestricciones :: [Actor] -> Int
cantidadDeActoresConRestricciones unosActores = length . actoresConMasDeNRestricciones 1  $ unosActores

bienestarSegunTemporadas :: Serie -> Int
bienestarSegunTemporadas unaSerie
    | cantidadTemporadas unaSerie > 4 = 5
    | otherwise = (10 - cantidadTemporadas unaSerie) * 2

--PUNTO 4

seriesModificadasConProductorMasEfectivo :: [Serie] -> [Productor] -> [Serie]
seriesModificadasConProductorMasEfectivo unasSeries unosProductores = map (productorMasEfectivoParaUnaSerie unosProductores) unasSeries

productorMasEfectivoEntre2 :: Serie -> Productor -> Productor -> Productor
productorMasEfectivoEntre2  unaSerie unProductor otroProductor
    | bienestar (unProductor unaSerie) > bienestar (otroProductor unaSerie) = unProductor
    | otherwise = otroProductor

productorMasEfectivoParaUnaSerie :: [Productor] -> Serie -> Serie
productorMasEfectivoParaUnaSerie unosProductores unaSerie = foldl1 (productorMasEfectivoEntre2 unaSerie) unosProductores $ unaSerie
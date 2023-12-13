import Text.Show.Functions()

data Alfajor = UnAlfajor {
    nombre :: String,
    capasDeRelleno :: [Capa],
    peso :: Int,
    dulzorInnato :: Int
} deriving (Show)

data Capa = UnaCapa {
    gusto :: String,
    precio :: Int
} deriving (Show,Eq)

dulceDeLeche = UnaCapa "Dulce De Leche" 12
mousse = UnaCapa "Mousse" 15
fruta = UnaCapa "Fruta" 10

modificarNombre :: (String -> String) -> Alfajor -> Alfajor
modificarNombre unaFuncion unAlfajor = unAlfajor {nombre = unaFuncion . nombre $ unAlfajor}

modificarPeso :: (Int -> Int) -> Alfajor -> Alfajor
modificarPeso unaFuncion unAlfajor = unAlfajor {peso = unaFuncion . peso $ unAlfajor}

modificarDulzor :: (Int -> Int) -> Alfajor -> Alfajor
modificarDulzor unaFuncion unAlfajor = unAlfajor {dulzorInnato = unaFuncion . dulzorInnato $ unAlfajor}

modificarCapa :: ([Capa] -> [Capa]) -> Alfajor -> Alfajor
modificarCapa unaFuncion unAlfajor = unAlfajor {capasDeRelleno = unaFuncion . capasDeRelleno $ unAlfajor}

-- PUNTO 1A

jorgito :: Alfajor
jorgito = UnAlfajor "Jorgito" [dulceDeLeche] 80 8

havanna :: Alfajor
havanna = UnAlfajor "Havanna" [mousse,mousse] 60 12

capitanDelEspacio :: Alfajor
capitanDelEspacio = UnAlfajor "Capitan Del Espacio" [dulceDeLeche] 40 12

-- 1B

coeficienteDeDulzor :: Alfajor -> Float
coeficienteDeDulzor unAlfajor = fromIntegral (dulzorInnato unAlfajor) / fromIntegral (peso unAlfajor)

precioDeUnAlfajor :: Alfajor -> Int
precioDeUnAlfajor unAlfajor = peso unAlfajor * 2 + precioDeLosRellenos unAlfajor

precioDeLosRellenos :: Alfajor -> Int
precioDeLosRellenos unAlfajor = sum . map precio $ capasDeRelleno unAlfajor

esPotable :: Alfajor -> Bool
esPotable unAlfajor = tieneUnaCapa unAlfajor && todasSusCapasSonIguales unAlfajor && coeficienteDeDulzor unAlfajor >= 0.1

tieneUnaCapa :: Alfajor -> Bool
tieneUnaCapa unAlfajor = not . null  . capasDeRelleno $ unAlfajor 

todasSusCapasSonIguales :: Alfajor -> Bool
todasSusCapasSonIguales unAlfajor = all (== head (capasDeRelleno unAlfajor)) (capasDeRelleno unAlfajor)

-- PARTE 2

abaratar :: Alfajor -> Alfajor
abaratar unAlfajor = modificarPeso(subtract 10) . modificarDulzor (subtract 7) $ unAlfajor

renombrar :: String -> Alfajor -> Alfajor
renombrar unNombre unAlfajor = modificarNombre (const unNombre) unAlfajor

agregarUnaCapa :: Capa -> Alfajor -> Alfajor
agregarUnaCapa unaCapa unAlfajor = modificarCapa (unaCapa :) unAlfajor

hacerPremium :: Alfajor -> Alfajor
hacerPremium unAlfajor 
    | esPotable unAlfajor = renombrar (nombre unAlfajor ++ "premium") . agregarUnaCapa (head . capasDeRelleno $ unAlfajor) $ unAlfajor
    | otherwise           = unAlfajor
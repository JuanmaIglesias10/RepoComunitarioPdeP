import Text.Show.Functions()
import Data.List (isInfixOf)

data Alfajor = UnAlfajor {
    nombre         :: String,
    capasDeRelleno :: [Capa],
    peso           :: Int,
    dulzorInnato   :: Int
} deriving (Show)

data Capa = UnaCapa {
    gusto  :: String,
    precio :: Int
} deriving (Show,Eq)

data Cliente = UnCliente {
    nombreCliente :: String,
    criterios          :: [Criterio],
    dineroDisponible   :: Int,
    alfajoresComprados :: [Alfajor]
} deriving (Show)

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

type Modificacion = Alfajor -> Alfajor

abaratar :: Modificacion
abaratar unAlfajor = modificarPeso(subtract 10) . modificarDulzor (subtract 7) $ unAlfajor

renombrar :: String -> Modificacion
renombrar unNombre unAlfajor = modificarNombre (const unNombre) unAlfajor

agregarUnaCapa :: Capa -> Modificacion
agregarUnaCapa unaCapa unAlfajor = modificarCapa (unaCapa :) unAlfajor

hacerPremium :: Modificacion
hacerPremium unAlfajor 
    | esPotable unAlfajor = renombrar (nombre unAlfajor ++ "premium") . agregarUnaCapa (head . capasDeRelleno $ unAlfajor) $ unAlfajor
    | otherwise           = unAlfajor

hacerPremiumDeGrado :: Int -> Modificacion
hacerPremiumDeGrado unGrado unAlfajor = foldr ($) unAlfajor (gradosPremium unGrado)

gradosPremium :: Int -> [Modificacion]
gradosPremium unGrado = replicate unGrado hacerPremium

-- PUNTO 3
type Criterio = Alfajor -> Bool

--CLIENTES--
emi :: Cliente
emi = UnCliente "Emi" [contieneEnSuNombre "Capitan Del Espacio"] 120 []

tomi :: Cliente
tomi = UnCliente "Tomi" [esDulcero , esPretencioso] 100 []

dante :: Cliente
dante = UnCliente "Dante" [esAnti dulceDeLeche , esExtranio] 200 []

juan :: Cliente
juan  = UnCliente "Juan" [esDulcero , esPretencioso , contieneEnSuNombre "Jorgito" , esAnti mousse] 500 []
--CLIENTES--

contieneEnSuNombre :: String -> Criterio
contieneEnSuNombre unNombre unAlfajor = isInfixOf unNombre (nombre unAlfajor)

esPretencioso :: Criterio
esPretencioso unAlfajor = contieneEnSuNombre "premium" unAlfajor

esExtranio :: Criterio
esExtranio unAlfajor = not . esPotable $ unAlfajor

esDulcero :: Criterio
esDulcero unAlfajor = coeficienteDeDulzor unAlfajor >= 0.15

esAnti :: Capa -> Criterio
esAnti unaCapa unAlfajor  = not . elem unaCapa . capasDeRelleno $ unAlfajor

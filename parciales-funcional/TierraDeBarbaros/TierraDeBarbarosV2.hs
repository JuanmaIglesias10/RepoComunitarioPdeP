import Text.Show.Functions()
import Data.Char (isUpper, toUpper)

data Barbaro = UnBarbaro {
    nombre :: String,
    fuerza :: Int,
    habilidades :: [String],
    objetos :: [Objeto]
} deriving Show

type Objeto = Barbaro -> Barbaro

--accessors--
modificarNombre :: (String -> String) -> Barbaro -> Barbaro
modificarNombre f unBarbaro = unBarbaro {nombre = f . nombre $ unBarbaro}

modificarFuerza :: (Int -> Int) -> Barbaro -> Barbaro
modificarFuerza f unBarbaro = unBarbaro {fuerza = f . fuerza $ unBarbaro}

modificarHabilidades :: ([String] -> [String]) -> Barbaro -> Barbaro
modificarHabilidades f unBarbaro = unBarbaro {habilidades = f . habilidades $ unBarbaro}

modificarObjetos :: ([Objeto] -> [Objeto]) -> Barbaro -> Barbaro
modificarObjetos f unBarbaro = unBarbaro {objetos = f . objetos $ unBarbaro}
--accessors--

--PUNTO 1--

espada :: Int -> Objeto
espada unPeso unBarbaro = modificarFuerza (+ 2 * unPeso) unBarbaro

amuletosMisticos :: String -> Objeto
amuletosMisticos unaHabilidad unBarbaro = modificarHabilidades (++ [unaHabilidad]) unBarbaro

varitasDefectuosas :: Objeto 
varitasDefectuosas unBarbaro = modificarHabilidades (const ["Hacer magia"] ) unBarbaro

ardilla :: Objeto
ardilla = id

cuerda :: Objeto -> Objeto -> Objeto
cuerda unObjeto otroObjeto unBarbaro= unObjeto . otroObjeto $ unBarbaro 

--PUNTO 2--

megafono :: Objeto
megafono unBarbaro = modificarHabilidades (concatenarYMayus) unBarbaro

concatenarYMayus :: [String] -> [String]
concatenarYMayus unasHabilidades = [map toUpper . concat $ unasHabilidades]

megafonoBarbarico :: Objeto
megafonoBarbarico unBarbaro = cuerda megafono ardilla unBarbaro

--PUNTO 3-- 
type Aventura = [Evento]
type Evento = Barbaro -> Bool

invasionDeSuciosDuendes :: Evento
invasionDeSuciosDuendes unBarbaro = elem "Escribir Poesia Atroz" (habilidades unBarbaro)

cremalleraDelTiempo :: Evento
cremalleraDelTiempo unBarbaro = nombre unBarbaro == "Faffy" || nombre unBarbaro == "Astro"

type Prueba = Barbaro -> Bool

ritualDeFechorias :: Evento 
ritualDeFechorias unBarbaro = saqueo unBarbaro || gritoDeGuerra unBarbaro || caligrafia unBarbaro 

pruebasDeFechorias :: [Prueba]
pruebasDeFechorias = [saqueo,gritoDeGuerra,caligrafia]

saqueo :: Prueba
saqueo unBarbaro = elem "Robar" (habilidades unBarbaro) && ((> 80) . fuerza) unBarbaro 

gritoDeGuerra :: Prueba
gritoDeGuerra unBarbaro = poderDeGritoDeGuerra unBarbaro > 4 * cantidadDeObjetos unBarbaro

poderDeGritoDeGuerra :: Barbaro -> Int
poderDeGritoDeGuerra unBarbaro = length . concat $ habilidades unBarbaro

cantidadDeObjetos :: Barbaro -> Int
cantidadDeObjetos unBarbaro = length . objetos $ unBarbaro

caligrafia :: Prueba
caligrafia unBarbaro = all empiezaConMayuscula (habilidades unBarbaro) && all contieneMasDe3Vocales (habilidades unBarbaro)

caligrafia' :: Prueba
caligrafia' unBarbaro = all empiezaConMayusYContieneMasDe3Vocales (habilidades unBarbaro)

empiezaConMayusYContieneMasDe3Vocales :: String -> Bool
empiezaConMayusYContieneMasDe3Vocales unaPalabra = empiezaConMayuscula unaPalabra && contieneMasDe3Vocales unaPalabra

empiezaConMayuscula :: String -> Bool
empiezaConMayuscula unaPalabra = isUpper . head $ unaPalabra

contieneMasDe3Vocales :: String -> Bool
contieneMasDe3Vocales unaPalabra = (>3) . length . filter esVocal $ unaPalabra 

esVocal :: Char -> Bool
esVocal unaLetra =  elem unaLetra "aeiouAEIOU"

descendientes :: Barbaro -> [Barbaro]
descendientes unBarbaro = tail (iterate (barbaro . aplicarTodosSusObjetos) unBarbaro)

barbaro :: Barbaro -> Barbaro
barbaro unBarbaro = UnBarbaro (nombre unBarbaro ++ "*") (fuerza unBarbaro) (habilidades unBarbaro) (objetos unBarbaro)

dave = UnBarbaro "Dave" 100 ["tejer","escribirPoesia"] [ardilla, varitasDefectuosas]

aplicarTodosSusObjetos :: Barbaro -> Barbaro
aplicarTodosSusObjetos unBarbaro = foldr ($) unBarbaro (objetos unBarbaro)



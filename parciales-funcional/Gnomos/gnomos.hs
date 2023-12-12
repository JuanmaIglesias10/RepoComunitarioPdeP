data Material = UnMaterial {
    nombre  :: String,
    calidad :: Int
} deriving (Show,Eq)

data Edificio = UnEdificio {
    tipoEdificio :: String,
    materiales   :: [Material]
} deriving (Show,Eq)

data Aldea = UnaAldea {
    poblacion             :: Int,
    materialesDisponibles :: [Material],
    edificio              :: [Edificio]
} deriving (Show,Eq)

type Tarea = Aldea -> Aldea

modificarPoblacion :: (Int -> Int) -> Aldea -> Aldea
modificarPoblacion unaFuncion unaAldea = unaAldea {poblacion = unaFuncion . poblacion $ unaAldea}

modificarCalidad :: (Int -> Int) -> Material -> Material
modificarCalidad unaFuncion unMaterial = unMaterial {calidad = unaFuncion . calidad $ unMaterial}

modificarMateriales :: ([Material] -> [Material]) -> Aldea -> Aldea
modificarMateriales unaFuncion unaAldea = unaAldea {materialesDisponibles = unaFuncion . materialesDisponibles $ unaAldea}


-- PUNTO 1
esValioso :: Material -> Bool
esValioso unMaterial = (>20) . calidad $ unMaterial

unidadesDisponibles :: String -> Aldea -> Int
unidadesDisponibles unNombre unaAldea = length (filter ((== unNombre) . nombre) (materialesDisponibles unaAldea))

valorTotal :: Aldea -> Int
valorTotal unaAldea = sum (calidadesDeMateriales unaAldea)

calidadesDeMateriales :: Aldea -> [Int]
calidadesDeMateriales unaAldea = map calidad (materialesDisponibles unaAldea)

-- PUNTO 2

tenerGnomito :: Tarea
tenerGnomito unaAldea = modificarPoblacion (+1) unaAldea

lustrarMaderas :: Tarea
lustrarMaderas unaAldea = modificarMateriales (map mejorarSiEsMadera) unaAldea 

mejorarSiEsMadera :: Material -> Material
mejorarSiEsMadera unMaterial 
    | esMadera unMaterial = modificarCalidad (+5) unMaterial
    | otherwise = unMaterial     

esMadera :: Material -> Bool
esMadera unMaterial = take 6 (nombre unMaterial) == "madera"  

--Con composicion

empiezaConMadera' :: Material -> Bool
empiezaConMadera' unMaterial = (=="madera") . take 6 . nombre $ unMaterial 

recolectar :: Material -> Int -> Tarea
recolectar unMaterial unaCantidad unaAldea = modificarMateriales (++ materialesPorAgregar unMaterial unaCantidad) unaAldea

materialesPorAgregar :: Material -> Int -> [Material]
materialesPorAgregar unMaterial unaCantidad = replicate unaCantidad unMaterial

realizarLasQueCumplan :: [Tarea] -> (Aldea -> Bool) -> Aldea -> Aldea
realizarLasQueCumplan unasTareas unCriterio unaAldea = foldr ($) unaAldea (tareasValidas unasTareas unCriterio unaAldea)

tareasValidas :: [Tarea] -> (Aldea -> Bool) -> Aldea -> [Tarea]
tareasValidas unasTareas unCriterio unaAldea = filter (unCriterio . ($ unaAldea) ) unasTareas

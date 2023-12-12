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

-- PUNTO 1
esValioso :: Material -> Bool
esValioso unMaterial = (>20) . calidad $ unMaterial

unidadesDisponibles :: String -> Aldea -> Int
unidadesDisponibles unNombre unaAldea = length (filter ((== unNombre) . nombre) (materialesDisponibles unaAldea))
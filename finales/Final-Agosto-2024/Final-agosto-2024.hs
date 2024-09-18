data Destino = UnDestino {
    nombre :: [Char],
    precio :: Float,
    atractivos :: [String]
}

tieneBoliches :: Destino -> Bool
tieneBoliches destino  = ((elem "boliches"). atractivos) destino

barato :: Destino -> Bool
barato destino = precio destino < 50

alguien :: [Destino -> Bool]
alguien = [tieneBoliches, barato]


tieneAtractivo :: Destino -> Bool
tieneAtractivo unDestino = not . null . atractivos $ unDestino 



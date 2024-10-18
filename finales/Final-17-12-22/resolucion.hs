--PARTE A
data Producto = Prod {
    nombre :: String,
    precio :: Int
}

queEmpiceConA :: Producto -> Bool
queEmpiceConA = (== 'a') . head . nombre
    
barato :: Producto -> Bool
barato = (<50) . precio

--1)
        --restriccionesDeCompra :: [Producto -> Bool]
--2)
queEmpieceCon :: Char -> Producto -> Bool
queEmpieceCon unaLetrovich = (== unaLetrovich ) . head . nombre


restriccionesDeCompra = [queEmpieceCon 'a', barato]

cumpleTodasLasRestricciones :: [Producto] -> [Producto -> Bool] -> [Producto]
cumpleTodasLasRestricciones unosProductos unasRestricciones = filter (\ producto -> all ($ producto) unasRestricciones) unosProductos

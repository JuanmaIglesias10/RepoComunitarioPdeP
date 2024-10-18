
funcion :: Ord a => a -> t -> [t -> a] -> [a]
funcion x y lista = (filter (> x) . map (\ f -> f y)) lista



lista = map (5 *) [1..]
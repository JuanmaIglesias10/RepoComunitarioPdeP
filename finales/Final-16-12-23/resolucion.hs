seTomanUnCoctelConEstasBebidas :: [Bebida] -> [Persona] -> [Persona]
seTomanUnCoctelConEstasBebidas bebidas personas = map (tomar (foldl1 mezclar bebidas) ) personas

type Ingrediente = String
type Bebida = String

data Combo = UnCombo {
    hamburguesa :: [Ingrediente],
    bebida :: Bebida
}



{-1)
a- esta mal, deberia ser Combo -> Ingrediente -> Combo.
Si quiero modificar el combo, despues de hacerlo tengo que seguir teniendo un combo

b- no, habria que usar composicion y aplicacion parcial. Porque no hay efecto en funcional

c- si, para poder hacer aplicacion parcial
-}

-- 2)

agregarIngrediente :: Ingrediente -> Combo -> Combo
agregarIngrediente unIngrediente unCombo = unCombo {hamburguesa = unIngrediente : hamburguesa unCombo} 

cambiarBebida :: Bebida -> Combo -> Combo
cambiarBebida unaBebida combo = combo {bebida = unaBebida}

agregarIngredienteYCambiarBebida :: Ingrediente -> Bebida -> Combo -> Combo
agregarIngredienteYCambiarBebida unIngrediente unaBebida unCombo = agregarIngrediente unIngrediente . cambiarBebida unaBebida $ unCombo

-- 3)

comboBasico :: Combo
comboBasico = UnCombo{hamburguesa = ["carne", "pan", "queso"] , bebida = "coca"}

aplicarModificaciones :: [Combo -> Combo] -> Combo
aplicarModificaciones unasModificaciones = foldl1 (.) unasModificaciones comboBasico
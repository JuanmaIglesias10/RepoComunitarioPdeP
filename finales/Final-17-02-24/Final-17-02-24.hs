import Text.Show.Functions()

habilidades :: Persona -> [Habilidad]

sirve :: Problema -> Habilidad -> Bool

{-Definir una funcion que  dado un problema y una lista de personas
permita saber que personas tienen alguna habilidad que sirva para el
problema recibido -}

podrianAyudar :: Problema -> [Persona] -> [Persona]
podrianAyudar unProblema personas = filter (any (sirve problema) . habilidades) personas

podrianAyudarr :: Problema -> [Persona] -> [Persona]
podrianAyudarr unProblema personas = filter . any (sirve problema) . habilidades $ personas

{-----------------------------------------------------------------------------------------------}

tiene(Persona, Cosa)
vale(Cosa, Valor)
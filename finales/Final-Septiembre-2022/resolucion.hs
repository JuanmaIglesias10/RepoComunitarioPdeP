import Text.Show.Functions()
amoxicilina = cura "infeccion"
bicarbonato = cura "picazon"
sugestion = []

cura sintoma = filter (/= sintoma)
malMovimiento = ["dolor agudo","hinchazon"]
varicela = repeat "picazon"

mejorMedicamentoPara sintomas = head . filter (idealPara sintomas)
idealPara sintomas medicamento = medicamento sintomas == []
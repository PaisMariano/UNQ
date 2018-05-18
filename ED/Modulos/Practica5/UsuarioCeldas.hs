import Celdas
import Map1

{- Inv. Rep.:
- Existe una clave para cada color existente
- El valor asociado a un color es un numero positivo
-}

nroBolitasMayorA :: Color -> Int -> Celda -> Bool
nroBolitasMayorA col i cel = i > nroBolitasMayorA col cel 


ponerN :: Int -> Color -> Celda -> Celda
ponerN i col cel = if i == 0
						then celdaVacia
						else ponerN (i-1) col (poner col cel)


hayBolitasDeCadaColor :: Celda -> Bool
hayBolitasDeCadaColor cel = hayBolitas "Verde" cel && hayBolitas "Rojo" cel && hayBolitas "Azul" cel && hayBolitas "Negro" cel


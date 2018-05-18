import Celda 

nroBolitasMayorA :: Color -> Int -> Celda -> Bool
--Devuelve True si hay mas de "n"bolitas de ese color
nroBolitasMayorA c n celda = (nroBolitas c celda) > n


ponerN :: Int -> Color -> Celda -> Celda
--Agrega "n"bolitas de ese color a la celda
ponerN 0 c celda = celda
ponerN n c celda = poner c (ponerN (n-1) c celda)

	
colores :: [Color]
colores = [Azul, Negro, Rojo, Verde]

hayBolitasDeCadaColor :: Celda -> Bool
--Indica si existe al menos una bolita de cada color posible
--Indicar los ordenes de complejidad en peor caso de cada funcion de la interfaz y del usuario.
hayBolitasDeCadaColor celda = hayTodosLosColores colores celda

hayTodosLosColores :: [Color] -> Celda -> Bool
hayTodosLosColores [] celda = True
hayTodosLosColores (c : cs) celda = hayBolitas c celda && hayTodosLosColores cs celda 
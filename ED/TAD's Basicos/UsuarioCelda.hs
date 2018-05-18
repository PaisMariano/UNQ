import Celda3
import Color
import Practica1

ponerN :: Int -> Color -> Celda -> Celda
ponerN 0 c celda = celda
ponerN n c celda = 
	poner c (ponerN (n-1) c celda)

hayBolitas :: Color -> Celda -> Bool
hayBolitas c celda = 
	nroBolitas c celda > 0

colores :: [Color]
colores = [Azul, Rojo, Verde, Negro]

hayDeCadaColor :: Celda -> Bool
hayDeCadaColor c = hayDeTodos colores c

hayDeTodos :: [Color] -> Celda -> Bool
hayDeTodos [] c = True
hayDeTodos (x:xs) c = hayBolitas x c && hayDeTodos xs c

-- Ejercicio: suma todas las bolitas de todas las celdas
-- sumatoriaCeldas :: Tree Celda -> Int

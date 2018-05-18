module Celda3(Celda, celdaVacia, poner, sacar, nroBolitas) where 

import Color

data Celda = MkC [(Color, Int)] deriving Show

-- Invariante de representacion
-- Todos los colores estan en la lista una única vez
-- y las cantidades no pueden ser negativas

colores :: [Color]
colores = [Azul, Verde, Negro, Rojo]

celdaVacia :: Celda
celdaVacia = MkC (poner0 colores)

poner0 :: [Color] -> [(Color, Int)]
poner0 [] = []
poner0 (c:cs) = (c, 0) : poner0 cs

nroBolitas :: Color -> Celda -> Int
nroBolitas c (MkC xs) = cantBolitas c xs

cantBolitas :: Color -> [(Color, Int)] -> Int
cantBolitas c [] = error "la lista esta vacia"
cantBolitas c ((c2, n):xs) = 
	if c == c2
		then n
		else cantBolitas c xs

poner :: Color -> Celda -> Celda
poner c (MkC xs) = MkC (ponerBolita c xs)

ponerBolita :: Color -> [(Color, Int)] -> [(Color, Int)]
ponerBolita c [] = []
ponerBolita c ((c2, n):xs) =
	if c == c2
		then (c2, n+1) : xs
		else (c2, n) : ponerBolita c xs

-- Prec. nroBolitas c > 0
sacar :: Color -> Celda -> Celda
sacar c (MkC xs) = MkC (sacarBolita c xs)

sacarBolita :: Color -> [(Color, Int)] -> [(Color, Int)]
sacarBolita c [] = []
sacarBolita c ((c2, n):xs) =
	if c == c2
		then if n == 0
			    then error "no hay bolitas de ese color"
			    else (c2, n-1) : xs
		else (c2, n) : sacarBolita c xs
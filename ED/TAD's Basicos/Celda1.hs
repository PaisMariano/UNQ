module Celda1(Celda, celdaVacia, poner, sacar, nroBolitas) where 

import Color

data Celda = MkC [Color] deriving Show

-- Invariantes de Representacion
-- NO HAY

celdaVacia :: Celda
celdaVacia = MkC []

nroBolitas :: Color -> Celda -> Int
nroBolitas c (MkC xs) = 
	apariciones c xs

apariciones :: Color -> [Color] -> Int
apariciones c [] = 0
apariciones c (x:xs) = 
	if c == x
		then 1 + apariciones c xs
		else apariciones c xs

poner :: Color -> Celda -> Celda
poner c (MkC xs) = MkC (c:xs)

-- NOOO (sacar la lista y hacer subtarea)
-- sacar c (MkC []) =
-- sacar c (MkC (x:xs)) = 
--	... sacar c (MkC xs)

-- Prec. nroBolitas c > 0
sacar :: Color -> Celda -> Celda
sacar c (MkC xs) = 
	if nroBolitas c (MkC xs) > 0
	   then MkC (sacarColor c xs)
	   else error "no hay bolitas de ese color"

-- Prec.: la lista no esta vacia
sacarColor :: Color -> [Color] -> [Color]
sacarColor c [] = error "la lista esta vacia"
sacarColor c (x:xs) = 
	if c == x
		then xs
		else x : sacarColor c xs
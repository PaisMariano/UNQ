module ImplementacionConjunto2(Conjunto, vacioC, agregarC, perteneceC, cantidadC, borrarC, interseccionS, unionC, listaC, conjuntoPar, conjuntoImpar, conjuntoFibbonacci, arbolNumeros) where

import Listas
import Auxiliares

data Conjunto a = MkC2 [a] deriving(Show)--Tipo de representacion: [a]

--Invariante de representacion:
--La lista no tiene elementos repetidos.


--O(1)
vacioC :: Conjunto a
--Crea un conjunto vacío.
vacioC = MkC2 []


--O(1)
agregarC :: Eq a => a -> Conjunto a -> Conjunto a
--Dados un elemento y un conjunto, agrega el elemento al conjunto.
agregarC x (MkC2 xs) = if pertenece x xs
								then MkC2 xs
								else MkC2 (x : xs)


--O(n)
perteneceC :: Eq a => a -> Conjunto a -> Bool
--Dados un elemento y un conjunto indica si el elemento pertenece al conjunto.
perteneceC x (MkC2 xs) = pertenece x xs 


--O(n)
cantidadC :: Eq a => Conjunto a -> Int
--Devuelve la cantidad de elementos distintos de un conjunto
cantidadC (MkC2 xs) = longitud xs


--O(n)
borrarC :: Eq a => a -> Conjunto a -> Conjunto a
--Devuelve la cantidad de elementos distintos de un conjunto
--Precondicion: El elemento debe estar estar en el conjunto
borrarC x (MkC2 xs) = if pertenece x xs
									then MkC2 (sacar x xs)
									else error "El elemento no pertenece al conjunto."


--O(n)
sacar :: Eq a => a -> [a] -> [a]
sacar x [] = error "El elemento no esta en la lista"
sacar x (y : ys) = if x == y
							then ys
							else x : sacar x ys 


--O(n^2)
interseccionS :: Eq a => Conjunto a -> Conjunto a -> Conjunto a
--Dado dos conjuntos, retorna otros conjunto con los elementos que pertenecen a ambos.
interseccionS (MkC2 xs) (MkC2 ys) = MkC2 (elementosEnComun2 xs ys)

--O(n^2)
elementosEnComun2 :: Eq a=> [a] -> [a] -> [a]
elementosEnComun2 [] ys = []
elementosEnComun2 (x : xs) ys = if pertenece x ys
											then x : elementosEnComun2 xs ys
											else elementosEnComun2 xs ys


--O(n^2)
unionC :: Eq a => Conjunto a -> Conjunto a -> Conjunto a
--Dados dos conjuntos devuelve un conjunto con todos los elementos de ambos conjuntos.
unionC (MkC2 xs) (MkC2 ys) = MkC2 (agregarSinoEsta xs ys)

--O(n^2)
agregarSinoEsta :: Eq a => [a] -> [a] -> [a]
agregarSinoEsta [] ys = ys
agregarSinoEsta (x : xs) ys = if pertenece x ys
										then agregarSinoEsta xs ys
										else x : agregarSinoEsta xs ys

--O(1)
listaC :: Eq a => Conjunto a -> [a]
--Dado un conjunto devuelve una lista con todos los elementos distintos del conjunto.
listaC (MkC2 xs) = xs


conjuntoPar :: Conjunto Int
conjuntoPar = MkC2 [0, 2, 4, 8, 16, 32, 64, 128]

conjuntoImpar :: Conjunto Int
conjuntoImpar = MkC2 [1, 3, 6, 7, 9, 11, 13, 15]

conjuntoFibbonacci :: Conjunto Int
conjuntoFibbonacci = MkC2 [0 ,1, 2, 3, 5, 8, 13, 21]

arbolNumeros :: Tree (Conjunto Int)
arbolNumeros = NodeT conjuntoPar (NodeT conjuntoImpar EmptyT EmptyT) (NodeT conjuntoFibbonacci EmptyT (NodeT conjuntoPar EmptyT EmptyT))
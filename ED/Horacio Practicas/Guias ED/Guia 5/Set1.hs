module Set1(Set, emptyS, isEmptyS, addS, belongS, sizeS, deleteS, interseccionS, unionS, setToList, conjuntoPar, conjuntoImpar, conjuntoFibbonacci, arbolNumeros) where

import Listas
import Auxiliares

data Set a = MkC2 [a] deriving(Eq, Show)--Tipo de representacion: [a]

--Invariante de representacion:
--La lista no tiene elementos repetidos.


--O(1)
emptyS :: Set a
--Crea un conjunto vacío.
emptyS = MkC2 []


--O(1)
isEmptyS :: Set a -> Bool
isEmptyS (MkC2 xs) = null xs

--O(n)
addS :: Eq a => a -> Set a -> Set a
--Dados un elemento y un conjunto, agrega el elemento al conjunto.
addS x (MkC2 xs) = if pertenece x xs
								then MkC2 xs
								else MkC2 (x : xs)


--O(n)
belongS :: Eq a => a -> Set a -> Bool
--Dados un elemento y un conjunto indica si el elemento pertenece al conjunto.
belongS x (MkC2 xs) = pertenece x xs 


--O(n)
sizeS :: Eq a => Set a -> Int
--Devuelve la cantidad de elementos distintos de un conjunto
sizeS (MkC2 xs) = longitud xs


--O(n)
deleteS :: Eq a => a -> Set a -> Set a
--Devuelve la cantidad de elementos distintos de un conjunto
--Precondicion: El elemento debe estar estar en el conjunto
deleteS x (MkC2 xs) = if pertenece x xs
									then MkC2 (sacar x xs)
									else error "El elemento no pertenece al conjunto."


--O(n)
sacar :: Eq a => a -> [a] -> [a]
sacar x [] = error "El elemento no esta en la lista"
sacar x (y : ys) = if x == y
							then ys
							else x : sacar x ys 


--O(n^2)
interseccionS :: Eq a => Set a -> Set a -> Set a
--Dado dos conjuntos, retorna otros conjunto con los elementos que pertenecen a ambos.
interseccionS (MkC2 xs) (MkC2 ys) = MkC2 (elementosEnComun2 xs ys)

--O(n^2)
elementosEnComun2 :: Eq a=> [a] -> [a] -> [a]
elementosEnComun2 [] ys = []
elementosEnComun2 (x : xs) ys = if pertenece x ys
											then x : elementosEnComun2 xs ys
											else elementosEnComun2 xs ys


--O(n^2)
unionS :: Eq a => Set a -> Set a -> Set a
--Dados dos conjuntos devuelve un conjunto con todos los elementos de ambos conjuntos.
unionS (MkC2 xs) (MkC2 ys) = MkC2 (agregarSinoEsta xs ys)

--O(n^2)
agregarSinoEsta :: Eq a => [a] -> [a] -> [a]
agregarSinoEsta [] ys = ys
agregarSinoEsta (x : xs) ys = if pertenece x ys
										then agregarSinoEsta xs ys
										else x : agregarSinoEsta xs ys

--O(1)
setToList :: Eq a => Set a -> [a]
--Dado un conjunto devuelve una lista con todos los elementos distintos del conjunto.
setToList (MkC2 xs) = xs


conjuntoPar :: Set Int
conjuntoPar = MkC2 [0, 2, 4, 8, 16, 32, 64, 128]

conjuntoImpar :: Set Int
conjuntoImpar = MkC2 [1, 3, 6, 7, 9, 11, 13, 15]

conjuntoFibbonacci :: Set Int
conjuntoFibbonacci = MkC2 [0 ,1, 2, 3, 5, 8, 13, 21]

arbolNumeros :: Tree (Set Int)
arbolNumeros = NodeT conjuntoPar (NodeT conjuntoImpar EmptyT EmptyT) (NodeT conjuntoFibbonacci EmptyT (NodeT conjuntoPar EmptyT EmptyT))
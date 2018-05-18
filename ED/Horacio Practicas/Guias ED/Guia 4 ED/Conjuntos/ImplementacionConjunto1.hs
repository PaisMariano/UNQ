module ImplementacionConjunto1(Conjunto, vacioC, agregarC, perteneceC, cantidadC, borrarC, interseccionS, unionC, listaC, conjuntoPar, conjuntoImpar, conjuntoFibbonacci, arbolNumeros)where

import Listas
import Auxiliares

data Conjunto a = MkC [a] deriving(Show)--Tipo de Representacion: [a]

--Invariante de representacion:
--No hay.


--O(1)
vacioC :: Conjunto a
--Crea un conjunto vacío.
vacioC = MkC []


--O(1)
agregarC :: Eq a => a -> Conjunto a -> Conjunto a
--Dados un elemento y un conjunto, agrega el elemento al conjunto.
agregarC x (MkC xs) = MkC (x : xs) 


--O(n)
perteneceC :: Eq a => a -> Conjunto a -> Bool
--Dados un elemento y un conjunto indica si el elemento pertenece al conjunto.
perteneceC x (MkC xs) = pertenece x xs


--O(n^2)?
cantidadC :: Eq a => Conjunto a -> Int
--Devuelve la cantidad de elementos distintos de un conjunto
cantidadC (MkC xs) = longitud(sinRepetidos xs)


--O(n)
borrarC :: Eq a => a -> Conjunto a -> Conjunto a
--Dado un elemento y un conjunto, elimina dicho elemento del conjunto dado.
--Precondicion: El elemento debe estar en el conjunto, sino tira error
borrarC x (MkC xs) =  MkC (filtrarSiEsta x xs)


--O(n^2)
filtrarSiEsta :: Eq a => a -> [a] -> [a]
filtrarSiEsta x [] = []
filtrarSiEsta x ys = if pertenece x ys
							then filtrarElemento x ys
							else error "El elemento no esta en la estructura." 


--O(n^2)
interseccionS :: Eq a => Conjunto a -> Conjunto a -> Conjunto a
interseccionS (MkC xs) (MkC ys) = MkC (elementosEnComun xs ys)


--O(n)
unionC :: Eq a => Conjunto a -> Conjunto a -> Conjunto a
--Dados dos conjuntos devuelve un conjunto con todos los elementos de ambos conjuntos.
unionC (MkC xs) (MkC ys) = MkC (xs ++ ys)


--O(n^2)
listaC :: Eq a => Conjunto a -> [a]
--Dado un conjunto devuelve una lista con todos los elementos distintos del conjunto.
listaC (MkC xs) = sinRepetidos xs


conjuntoPar :: Conjunto Int 
conjuntoPar = MkC [0, 2, 4, 8, 16, 32, 64, 128]

conjuntoImpar :: Conjunto Int
conjuntoImpar = MkC [1, 3, 5, 7, 9, 11, 13, 15]

conjuntoFibbonacci :: Conjunto Int
conjuntoFibbonacci = MkC [0 ,1, 1, 2, 3, 5, 8, 13]

arbolNumeros :: Tree (Conjunto Int)
arbolNumeros = NodeT conjuntoPar (NodeT conjuntoImpar EmptyT EmptyT) (NodeT conjuntoFibbonacci EmptyT (NodeT conjuntoPar EmptyT EmptyT))
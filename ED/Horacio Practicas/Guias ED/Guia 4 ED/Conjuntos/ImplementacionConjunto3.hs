module ImplementacionConjunto3(Conjunto, vacioC, agregarC, perteneceC, cantidadC, borrarC, unionC, listaC, conjuntoPar, conjuntoImpar, conjuntoFibbonacci, arbolNumeros) where

import Listas
import Auxiliares

data Conjunto a = MkC3 [a] CantDeElementos deriving(Show)--Tipo de representacion: [a]
type CantDeElementos = Int

--Invariante de representacion:
--La lista no tiene elementos repetidos.
--La cantDeElementos >= 0 y coincide con la longitud de la lista.


--O(1)
vacioC :: Conjunto a
--Crea un conjunto vacío.
vacioC = MkC3 [] 0

--O(n)
agregarC :: Eq a => a -> Conjunto a -> Conjunto a
--Dados un elemento y un conjunto, agrega el elemento al conjunto.
agregarC x (MkC3 xs n) = if pertenece x xs
								then MkC3 xs n
								else MkC3 (x : xs) (sumarUno n)

--O(1)
sumarUno :: Int -> Int
sumarUno x = x + 1


--O(n)
perteneceC :: Eq a => a -> Conjunto a -> Bool 
--Dados un elemento y un conjunto indica si el elemento pertenece al conjunto.
perteneceC x (MkC3 xs _) = pertenece x xs 


--O(1)
cantidadC :: Eq a => Conjunto a -> Int
--Devuelve la cantidad de elementos distintos de un conjunto
cantidadC (MkC3 xs n) = n

--O(n)
borrarC :: Eq a => a -> Conjunto a -> Conjunto a
--Devuelve la cantidad de elementos distintos de un conjunto
--Precondicion: El elemento debe estar estar en el conjunto. N no puede < 0
borrarC x (MkC3 xs n) = if pertenece x xs
									then MkC3 (sacar x xs) (restarUno n)
									else error "El elemento no pertenece al conjunto."

--O(1)
restarUno :: Int -> Int
restarUno x = x - 1


--Suponiendo que == es O(1), O(n). En el peor de los casos se recorre toda la lista. 
sacar :: Eq a => a -> [a] -> [a]
sacar x [] = error "El elemento no esta en la lista"
sacar x (y : ys) = if x == y
							then ys
							else x : sacar x ys


--(n^2)
intersectionS :: Eq a=> Conjunto a -> Conjunto a -> Conjunto a
--Dado dos conjuntos retorna otro, con los elementos en comun pertenecientes a ambos.
intersectionS (MkC3 xs _) (MkC3 ys _) = MkC3 (elementosEnComun xs ys) ( longitud (elementosEnComun xs ys))

 
--(n^2)
unionC :: Eq a => Conjunto a -> Conjunto a -> Conjunto a
--Dados dos conjuntos devuelve un conjunto con todos los elementos de ambos conjuntos.
unionC (MkC3 xs _) (MkC3 ys _) = MkC3 (agregarSinoEsta xs ys) (longitud(agregarSinoEsta xs ys))


--(n^2)
agregarSinoEsta :: Eq a => [a] -> [a] -> [a]
agregarSinoEsta [] ys = ys
agregarSinoEsta (x : xs) ys = if pertenece x ys
										then agregarSinoEsta xs ys
										else x : agregarSinoEsta xs ys


--O(1)
listaC :: Eq a => Conjunto a -> [a]
--Dado un conjunto devuelve una lista con todos los elementos distintos del conjunto.
listaC (MkC3 xs _) = xs

conjuntoPar :: Conjunto Int
conjuntoPar = MkC3 [0, 2, 4, 8, 16, 32, 64, 128] 8

conjuntoImpar :: Conjunto Int
conjuntoImpar = MkC3 [1, 3, 5, 7, 9, 11, 13, 15] 8

conjuntoFibbonacci :: Conjunto Int
conjuntoFibbonacci = MkC3 [0 ,1, 2, 3, 5, 8, 13, 21] 8

arbolNumeros :: Tree (Conjunto Int)
arbolNumeros = NodeT conjuntoPar (NodeT conjuntoImpar EmptyT EmptyT) (NodeT conjuntoFibbonacci EmptyT (NodeT conjuntoPar EmptyT EmptyT))
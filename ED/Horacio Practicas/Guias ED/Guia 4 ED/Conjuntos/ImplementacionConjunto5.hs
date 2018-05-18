
module ImplementacionConjunto5(Conjunto, vacioC, agregarC, perteneceC, cantidadC, borrarC, unionC, listaC, conjuntoPar, conjuntoImpar, conjuntoFibbonacci, arbolNumeros) where

import Listas
import Auxiliares

data Conjunto a = MkC5 [a] CantDeElementos (Maximo a) deriving(Show)--Tipo de representacion: [a]
type CantDeElementos = Int
type Maximo a = Maybe a


--Invariante de representacion:
--La lista no tiene elementos repetidos.
--La cantDeElementos >= 0 y coincide con la longitud de la lista.
--Maximo es un Maybe con el mayor elemento de la lista. En caso de que esta sea vacia, maximo = nothing 


--O(1)
vacioC :: Conjunto a
--Crea un conjunto vacío.
vacioC = MkC5 [] 0 Nothing


--O(n)
agregarC :: Ord a => a -> Conjunto a -> Conjunto a
--Dados un elemento y un conjunto, agrega el elemento al conjunto.
agregarC x (MkC5 xs n m) = if pertenece x xs
								then MkC5 xs n m
								else MkC5 (x : xs) (sumarUno n) (maxM x m)

--O(1)
maxM :: Ord a => a -> Maybe a -> Maybe a 
maxM x Nothing = Just x
maxM x (Just y) = Just (max x y)

--O(1)
sumarUno :: Int -> Int
sumarUno x = x + 1

--O(n)
perteneceC :: Eq a => a -> Conjunto a -> Bool 
--Dados un elemento y un conjunto indica si el elemento pertenece al conjunto.
perteneceC x (MkC5 xs _ _) = pertenece x xs 


--O(1)
cantidadC :: Eq a => Conjunto a -> Int
--Devuelve la cantidad de elementos distintos de un conjunto
cantidadC (MkC5 xs n _) = n


--O(n)
borrarC :: Ord a => a -> Conjunto a -> Conjunto a
--Devuelve la cantidad de elementos distintos de un conjunto
--Precondicion: El elemento debe estar estar en el conjunto. N no puede < 0
borrarC x (MkC5 xs n m) = if pertenece x xs && n > 0
									then MkC5 (sacar x xs) (restarUno n) (recalcularMax (sacar x xs))
									else error "El elemento no pertenece al conjunto."

--(n)
recalcularMax :: Ord a => [a] -> Maybe a
recalcularMax [] = Nothing
recalcularMax [x] = Just x
recalcularMax (x : xs) = Just (max x (maximum xs))

--O(1)
restarUno :: Int -> Int
restarUno x = x - 1

--O(n)
sacar :: Eq a => a -> [a] -> [a]
sacar x [] = error "El elemento no esta en la lista"
sacar x (y : ys) = if x == y
							then ys
							else x : sacar x ys 


--O(n^2)
intersectionS :: Ord a=> Conjunto a -> Conjunto a -> Conjunto a
--Dado dos conjuntos retorna otro, con los elementos en comun pertenecientes a ambos.
intersectionS (MkC5 xs _ _) (MkC5 ys _ _) = MkC5 (elementosEnComun xs ys) ( longitud (elementosEnComun xs ys)) (recalcularMax (elementosEnComun xs ys)) 


--O(n^2)
unionC :: Ord a => Conjunto a -> Conjunto a -> Conjunto a
--Dados dos conjuntos devuelve un conjunto con todos los elementos de ambos conjuntos.
unionC (MkC5 xs _ _) (MkC5 ys _ _) = MkC5 (agregarSinoEsta xs ys) (longitud(agregarSinoEsta xs ys)) (recalcularMax (agregarSinoEsta xs ys))

--O(n^2)
agregarSinoEsta :: Eq a => [a] -> [a] -> [a]
agregarSinoEsta [] ys = ys
agregarSinoEsta (x : xs) ys = if pertenece x ys
										then agregarSinoEsta xs ys
										else x : agregarSinoEsta xs ys


--O(1)
maximoC :: Ord a => Conjunto a -> a
--Devuelve el máximo elemento en un conjunto
maximoC (MkC5 xs n m) = if isNothing m
								then error "El conjunto no posee un elemento maximo"
								else fromJust m

--O(1)
isNothing :: Maybe a -> Bool
isNothing Nothing = True
isNothing _ = False

--O(1)
fromJust :: Maybe a -> a
fromJust (Just x) = x

--O(n)
elMaximo :: Ord a => [a] -> a
elMaximo [x] = x
elMaximo (x : xs) = max x (elMaximo xs) 
 
--O(1)
listaC :: Eq a => Conjunto a -> [a]
--Dado un conjunto devuelve una lista con todos los elementos distintos del conjunto.
listaC (MkC5 xs _ _) = xs

conjuntoPar :: Conjunto Int
conjuntoPar = MkC5 [0, 2, 4, 8, 16, 32, 64, 128] 8 (Just 128)

conjuntoImpar :: Conjunto Int
conjuntoImpar = MkC5 [1, 3, 5, 7, 9, 11, 13, 15] 8 (Just 15)

conjuntoFibbonacci :: Conjunto Int
conjuntoFibbonacci = MkC5 [0 ,1, 2, 3, 5, 8, 13, 21] 8 (Just 21)

arbolNumeros :: Tree (Conjunto Int)
arbolNumeros = NodeT conjuntoPar (NodeT conjuntoImpar EmptyT EmptyT) (NodeT conjuntoFibbonacci EmptyT (NodeT conjuntoPar EmptyT EmptyT))



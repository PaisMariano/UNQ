---------------------------------------------------------------------------------------------------------
------------------------------------------------ Conjuntos ----------------------------------------------
---------------------------------------------------------------------------------------------------------

--Conjuntos: Cuarta implementacion, con maximo constante.

module Conjunto4(Set, emptyS, addS, belongS, sizeS, removeS, unionS, setTolist, conjuntoPar, conjuntoImpar, conjuntoFibbonacci, arbolDeConjuntos) where

import Listas
import Auxiliares
import MaybeModulo

data Set a = MkSet [a] Elementos (Maybe a)   deriving Show --Tipo de representacion: Listas de a.

type Elementos = Int 

--Invariante de representacion: 
--La lista no tiene repetidos
-- 	Elementos >= 0 y coincide con el largo de la lista.
--  Si la lista esta vacia el Maybe debe ser Nothing y sino el Maybe es Just (el maximo de la lista).
 


emptyS :: Set a 
emptyS = MkSet [] 0 Nothing


addS :: Eq a => a -> Set a -> Set a
--Precondicion: El elemento a agregar no debe pertenecer al conjunto.
addS x (MkSet xs n m) = if (pertenece x xs)
								--then error "El elemento ya esta presente en el conjunto." --Si agrego este error nunca puede usarse la estructura para pasar de un conjunto a una lista.
								then MkSet xs n m
								else MkSet (x : xs) (sumarUno n) (recalcularMaximo (x : xs)) 

sumarUno :: Int -> Int
sumarUno x = x + 1


belongS :: Eq a => a -> Set a -> Bool
belongS x (MkSet xs _ _) = pertenece x xs


sizeS :: Set a -> Int
sizeS (MkSet xs n _) = n


removeS :: Eq a => a -> Set a -> Set a
--Precondicion: El elemento debe estar en el conjunto.
-- n no puede ser 0
removeS x (MkSet xs n m) = if(pertenece x xs || n <= 0)
								then MkSet (filtrarElemento x xs) (restarUno n) (recalcularMaximo (filtrarElemento x xs))
								--else MkSet xs n?
								else error "El elemento no pertenece al conjunto." 

restarUno :: Int -> Int 
restarUno x = x - 1

unionS :: Eq a => Set a -> Set a -> Set a
unionS (MkSet xs _ _ ) (MkSet ys _ _) = MkSet (sinRepetidos(xs ++ ys)) (longitud (sinRepetidos (xs ++ ys))) (recalcularMaximo (xs ++ ys))

setTolist :: Eq a => Set a -> [a]
setTolist (MkSet xs _ _) = xs 

maximoC :: Ord a => Set a -> a
maximoC (MkSet xs _ m ) = 	if(isNothing m)
									then error "El conjunto no contiene ningun elemento maximo."
									else fromJust m

---------------------------------------------------------------------------------------------------------
----------------------------------------------- Auxiliares ----------------------------------------------
---------------------------------------------------------------------------------------------------------

conjuntoPar :: Set Int
conjuntoPar = MkSet [2,4,8,16,32,64] 6

conjuntoImpar :: Set Int
conjuntoImpar = MkSet [1,3,5,7,9,11] 6

conjuntoFibbonacci :: Set Int
conjuntoFibbonacci = MkSet [0,1,1,2,3,5,8,13,21,34] 10

arbolDeConjuntos :: Tree (Set Int)
arbolDeConjuntos = NodeT (conjuntoPar) (NodeT conjuntoImpar EmptyT EmptyT) EmptyT


---------------------------------------------------------------------------------------------------------
------------------------------------------------ Conjuntos ----------------------------------------------
---------------------------------------------------------------------------------------------------------

--Conjuntos : Seunda implementacion.

module Conjunto2(Set, emptyS, addS, belongS, sizeS, removeS, unionS, setTolist, conjuntoPar, conjuntoImpar, conjuntoFibbonacci, arbolDeConjuntos) where

import Listas
import Auxiliares

data Set a = MkSet [a] CantElementos deriving(Show) --Tipo de representacion: Listas de a.
type CantElementos = Int

--Invariante de representacion: 
-- La lista no tiene repetidos
-- CantElementos >= 0


emptyS :: Set a 
emptyS = MkSet [] 0


addS :: Eq a => a -> Set a -> Set a
--Precondicion: El elemento a agregar no debe pertenecer al conjunto.
addS x (MkSet xs n) = if (pertenece x xs)
								--then error "El elemento ya esta presente en el conjunto." --Si agrego este error nunca puede usarse la estructura para pasar de un conjunto a una lista.
								then MkSet xs n
								else MkSet (x : xs) (sumarUno n) 

sumarUno :: Int -> Int
sumarUno x = x + 1


belongS :: Eq a => a -> Set a -> Bool
belongS x (MkSet xs _) = pertenece x xs


sizeS :: Set a -> Int
sizeS (MkSet xs n) = n


removeS :: Eq a => a -> Set a -> Set a
--Precondicion: El elemento debe estar en el conjunto.
-- n no puede ser 0
removeS x (MkSet xs n) = if(pertenece x xs || n <= 0)
								then MkSet (filtrarElemento x xs) (restarUno n)
								--else MkSet xs n?
								else error "El elemento no pertenece al conjunto." 

restarUno :: Int -> Int 
restarUno x = x - 1

unionS :: Eq a => Set a -> Set a -> Set a
unionS (MkSet xs _ ) (MkSet ys _) = MkSet (sinRepetidos(xs ++ ys)) (longitud (sinRepetidos (xs ++ ys)))

setTolist :: Eq a => Set a -> [a]
setTolist (MkSet xs _) = xs 


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


---------------------------------------------------------------------------------------------------------
---------------------------------------------- Conjuntos ------------------------------------------------
---------------------------------------------------------------------------------------------------------

--Conjuntos primera implementacion.

module Conjunto1(Set, emptyS, addS, belongS, sizeS, removeS, unionS, setTolist, conjuntoPar, conjuntoImpar, conjuntoFibbonacci, arbolDeConjuntos) where

import Listas
import Auxiliares

data Set a = MkSet [a] deriving (Eq, Show)


--Ver pretty printing:
--instance Show Conjunto where	
--	show (MkSet xs) = 
--					"#{ " ++ xs ++ " }"


--Invariable de Representacion:
-- No hay.


--A:
emptyS :: Set a
emptyS = MkSet []


--B:
--Precondicion: El elemento no debe estar en el conjunto.
addS :: Eq a => a -> Set a -> Set a
addS x (MkSet xs) = MkSet (x : xs)


--C:
belongS :: Eq a => a -> Set a -> Bool
belongS x (MkSet xs) = pertenece x xs


--D:
sizeS :: Eq a => Set a -> Int
sizeS (MkSet xs) =  longitud xs


--E:
--Precondicion: El elemento debe estar entre los elementos del Conjunto.
removeS :: Eq a => a -> Set a -> Set a
removeS x (MkSet ys) = if (not (pertenece x ys))
									then error "El elemento que desea borrar no esta entre los elementos del conjunto."
									else MkSet (filtrarElemento x ys)

--F:
unionS :: Eq a => Set a -> Set a -> Set a
unionS (MkSet xs) (MkSet ys) = MkSet (xs ++ ys)


--G:
setTolist :: Eq a => Set a -> [a]
setTolist (MkSet xs) = sinRepetidos xs

---------------------------------------------------------------------------------------------------------
----------------------------------------------- Auxiliares ----------------------------------------------
---------------------------------------------------------------------------------------------------------


conjuntoPar :: Set Int
conjuntoPar = MkSet [2,2,8,16,32,64]

conjuntoImpar :: Set Int
conjuntoImpar = MkSet [1,3,7,9]

conjuntoFibbonacci :: Set Int
conjuntoFibbonacci = MkSet [0,1,1,2,3,5,8,13,21,34]

arbolDeConjuntos :: Tree (Set Int)
arbolDeConjuntos = NodeT (conjuntoPar) (NodeT conjuntoPar EmptyT EmptyT) EmptyT
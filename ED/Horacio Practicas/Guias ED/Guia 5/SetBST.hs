module SetBST(Set, emptyS, isEmptyS, belongS, sizeS, removeS, addS)where

import BST
import Auxiliares 

data Set a = MkS (Tree a) --Tipo de representacion: Tree a

--Invariante de representacion:	
--El (Tree a) cumple la propiedad BST.
--El (Tree a) cumple las propiedades AVL. (Uso NodeT para poder probarlo, sientase libre de leer "balancear", "armarAVL" o alguna otra hippeada para tipos blandos.)
--CantElementos coincide con la cantidad de elementos del conjunto. CantElementos >= 0

--A:
--O(1)
emptyS :: Set a
emptyS = MkS EmptyT


--B:
--O(1)
isEmptyS :: Set a -> Bool
isEmptyS (MkS treeBST) = isEmptyT treeBST 


--C:
--O(log(n)), siendo n la profundidad del arbol. 
belongS :: Ord a => a -> Set a -> Bool
belongS x (MkS treeBST) = perteneceBST x treeBST


--D:
--O(n), siendo n la cantidad de elementos del arbol.
sizeS :: Ord a => Set a -> Int
sizeS (MkS treeBST) = cantElementos treeBST


--E:
--O(log(n))
removeS :: Ord a => a -> Set a -> Set a 
--El elemento debe pertenecer al conjunto.
removeS x (MkS treeBST) = if perteneceBST x treeBST	
										then MkS (deleteBST x treeBST)
										else error "El elemento debe pertenecer al conjunto para poder borrarlo."


--F:
--O(n)
--unionS :: Ord a => Set a -> Set a -> Set a
--unionS (MkS treeBST1 n) (treeBST2 m) = MkS (hermanar treeBST1 treeBST2) (n+m) --Esto ultimo no es correcto. 

--(log(n)) siendo n la profundidad del arbol t2
hermanar :: Ord a => Tree a -> Tree a -> Tree a
--Los arboles cumplen la propiedad BST y no contienen elementos repetidos.
hermanar t1 EmptyT = t1
hermanar EmptyT t2 = t2
hermanar t1 t2 = if isEmptyT t2
						then t1 
						else 
							if not (perteneceBST (minBST t2) t1)
												then insertBST (minBST t2) (hermanar t1 (deleteMinBST t2))
												else hermanar t1 (deleteMinBST t2)

--G:
--O(log(n)), siendo n la profundidad del arbol.
addS :: Ord a => a -> Set a -> Set a
addS x (MkS treeBST) = MkS (insertar x treeBST) --(sumarSiCorresponde x treeBST n)

--O(log(n))
insertar :: Ord a => a -> Tree a -> Tree a
insertar x t = if perteneceBST x t
						then t
						else insertBST x t

--O(1)
--Ya no cacheo la cantidad de elementos del conjunto en un entero alado del arbol, sino las operaciones mas basicas me salen muy caras. Deberia incluir ago en el tipo de representacion al respecto?
sumarSiCorresponde :: Ord a => a -> Tree a -> Int -> Int
sumarSiCorresponde x tree n = if perteneceBST x tree
										then n
										else sumarUno n


--H:
--O(log(n))
intersectionS :: Ord a => Set a -> Set a -> Set a
intersectionS (MkS treeBST1) (MkS treeBST2) = MkS (nodosEnComun treeBST1 treeBST2)

--O(log(n))
nodosEnComun :: Ord a => Tree a -> Tree a -> Tree a
nodosEnComun t1 EmptyT = EmptyT
nodosEnComun EmptyT t2 = EmptyT
nodosEnComun EmptyT EmptyT = EmptyT
nodosEnComun t1   t2 = if  perteneceBST (minBST t2) t1
							then insertBST (minBST t2) (nodosEnComun t1 (deleteMinBST t2))
							else nodosEnComun t1 (deleteMinBST t2)     


--I:
--O(Log(n))? o O(n)
setToList :: Ord a =>  Set a -> [a]
setToList (MkS treeBST) = hacerLista treeBST

--O(Log(n)), siendo n la cantidad de elementos del arbol o O(n)?
hacerLista :: Ord a => Tree a -> [a]
hacerLista t = if isEmptyT t
						then [] 
						else (minBST t) : hacerLista (deleteMinBST t) 
module ArbolesBST () where

data Arbol = MkA emptyT

insertBST :: Ord a => a -> Tree a -> Tree a
insertBST e emptyT          = NodeT e EmptyT emptyT
insertBST e (NodeT x t1 t2) = if e == x 
								then NodeT e t1 t2 
								else if e < x 
										then NodeT e (insertBST e t1) t2
										else NodeT e t1 (insertBST e t2)

deleteBST :: Ord a => a -> Tree a -> Tree a
deleteBST e EmptyT          = EmptyT
deleteBST e (NodeT x t1 t2) = if e == x
								then casoIgual t1 t2
								else if e < x 
									then NodeT e (deleteBST e t1) t2
									else NodeT e t1 (deleteBST e t2) 

casoIgual :: Tree a -> Tree a -> Tree a
casoIgual EmptyT t2 = t2
casoIgual t1 t2     = rearmarBST (separarMax t1) t2

separarMax :: Tree a -> (a, Tree a) 
separarMax (NodeT x t1 EmptyT) = (x, t1)
separarMax (NodeT x t1 t2)     = let (m, t2') = separarMax t2
								 in (m, NodeT x t1 t2')
								 
separarMin :: Tree a -> (a, Tree a) 
separarMin (NodeT x EmptyT t2) = (x, t2)
separarMin (NodeT x t1 t2)     = let (m, t1') = separarMin t1
								 in (m, NodeT x t1' t2)

rearmarBST :: (a, Tree a) -> Tree a -> Tree a
rearmarBST (x, ti) td = NodeT x ti td

--Dado un BST borra un elemento en el ´arbol.


perteneceBST :: Ord a => a -> Tree a -> Bool
perteneceBST e (emptyT)       = False
perteneceBST e (NodeT x t1 t2 = e == x || (perteneceBST e t1) || (perteneceBST e t2)

--Dado un BST dice si el elemento pertenece o no al ´arbol.


splitMinBST :: Ord a => Tree a -> (a, Tree a)
--splitMinBST (NodeT x EmptyT EmptyT)= (x, EmptyT) No hace falta porque cuando t2 es emptyT usa el caso de abajo (EmptyT t2) dando (x, EmptyT)
splitMinBST (NodeT x EmptyT t2)    = (x, t2)
splitMinBST (NodeT x t1 t2)     = let (m, t1') = splitMinBST t1
								  in (m, balancear m t1' t2) 


--Dado un BST devuelve un par con el m´ınimo elemento y el ´arbol sin el mismo.



splitMaxBST :: Ord a => Tree a -> (a, Tree a)
splitMaxBST (NodeT x t1 EmptyT)    = (x, t1)
splitMaxBST (NodeT x t1 t2)     = let (m, t2') = splitMaxBST t2
								  in (m, balancear m t1 t2') 
--Dado un BST devuelve un par con el m´aximo elemento y el ´arbol sin el mismo.

elMaximoMenorA :: Ord a => a -> Tree a -> Maybe a
elMaximoMenorA e t     = buscarMax e t e

buscarMax :: Ord a -> a -> Tree a -> a -> Maybe a
buscarMax e (NodeT x t1 EmptyT) m = Just x
buscarMax e (NodeT x t1 t2) m     = if e <= x 
										then if x < (maximoT2 x t2)
												then buscarMax e t2 (min x m)  
												else Just x
										else buscarMax e t2 (min x m)

maximoT2 :: Ord a -> a -> Tree a -> a
maximoT2 e EmptyT                  = e
maximoT2 e (NodeT x EmptyT EmptyT) = x
maximoT2 e (NodeT x t1 t2)         = max x (max (maximoT2 x t1) (maximoT2 x t2))
											
											
											
--Dado un BST y un elemento, devuelve el m´aximo elemento que sea menor al elemento dado.
elMinimoMayorA :: Ord a => a -> Tree a -> Maybe a
--Dado un BST y un elemento, devuelve el m´ınimo elemento que sea mayor al elemento dado.
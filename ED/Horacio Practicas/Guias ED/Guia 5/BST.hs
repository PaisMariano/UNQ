module BST(insertBST, deleteBST, perteneceBST, splitMinBST, splitMaxBST, minBST, maxBST, deleteMinBST, deleteMaxBST, arbolBST) where

import Auxiliares 

--Invariantes de representacion:
--Todos los subarboles son BST
-- Todos los elementos del arbol izquierdo son menores a la raiz, mientras que todos los elementos del arbol derecho son mayores a la misma.
-- No hay elementos repetidos en el arbol.


--A:
insertBST :: Ord a => a -> Tree a -> Tree a
--Dado un BST inserta un elemento en el arbol.
insertBST x EmptyT = NodeT x EmptyT EmptyT
insertBST x (NodeT y ri rd) = if x == y
										then NodeT y ri rd
										else 
											if x < y
													then NodeT y (insertBST x ri) rd
													else NodeT y ri (insertBST x rd)


--B:
deleteBST :: Ord a => a -> Tree a -> Tree a
--Dado un BST borra un elemento en el  arbol.
deleteBST x EmptyT = error "El elemento no se encuentra en el arbol"
deleteBST x (NodeT y ri rd) = if x == y
									then casoIgual ri rd
									else
										if x < y
											then NodeT y (deleteBST x ri) rd
											else NodeT y ri (deleteBST x rd)

casoIgual :: Tree a -> Tree a -> Tree a
casoIgual EmptyT arbol2 = arbol2
casoIgual arbol1 arbol2 = rearmarBST (separarMaxBST arbol1) arbol2

rearmarBST :: (a, Tree a) -> Tree a -> Tree a
rearmarBST (x, ri) rd = NodeT x ri rd

separarMaxBST :: Tree a -> (a, Tree a)
separarMaxBST (NodeT x ri EmptyT) = (x, ri)
separarMaxBST (NodeT x ri rd) =   
								let (min, arbol) = separarMaxBST rd
								in (min, NodeT x ri arbol)


--C:
perteneceBST :: Ord a => a -> Tree a -> Bool
--Dado un BST dice si el elemento pertenece o no al arbol.
perteneceBST x EmptyT = False
perteneceBST x (NodeT x' ri rd) = x == x' || if x < x'
												then perteneceBST x ri
												else perteneceBST x rd


--D: 
splitMinBST :: Ord a => Tree a -> (a, Tree a)
--Dado un BST devuelve un par con el minimo elemento y el arbol sin el mismo.
splitMinBST t = (minT t, sacarMinT t)

minT :: Tree a -> a
minT EmptyT = error "El arbol no posee un elemento minimo."
minT (NodeT x ri rd) = if isEmptyT ri
							then x
							else minT ri

sacarMinT :: Tree a -> Tree a
sacarMinT EmptyT = EmptyT
sacarMinT (NodeT x ri rd) = if isEmptyT ri
									then rd
									else NodeT x (sacarMinT ri) rd


--E:
splitMaxBST :: Ord a => Tree a -> (a, Tree a)
--Dado un BST devuelve un par con el maximo elemento y el arbol sin el mismo.
splitMaxBST t = (maxT t, sacarMaxT t)

maxT :: Tree a -> a
maxT EmptyT = error "El arbol no posee un elemento minimo."
maxT (NodeT x ri rd) = if isEmptyT rd
							then x
							else maxT rd

sacarMaxT :: Tree a -> Tree a
sacarMaxT EmptyT = EmptyT
sacarMaxT (NodeT x ri rd) = if isEmptyT rd
									then ri
									else NodeT x ri (sacarMaxT rd) 


minBST :: Ord a => Tree a -> a --Parcial en EmptyT
--Dado un BST devuelve el minimo elemento.
minBST EmptyT = error "El arbol debe contener al menos un elemento."
minBST (NodeT x ri _) = if isEmptyT ri
								then x
								else minBST ri


maxBST :: Ord a => Tree a -> a --Parcial en EmptyT
--Dado un BST devuelve el maximo elemento.
maxBST EmptyT = error "El arbol debe contener al menos un elemento."
maxBST (NodeT x _ rd) = if isEmptyT rd
								then x
								else maxBST rd


deleteMinBST :: Ord a => Tree a -> Tree a --Parcial en EmptyT (Equivalente a sacarMinT)
--Dado un BST devuelve el arbol sin el minimo elemento.
deleteMinBST t = deleteBST (minBST t) t 


deleteMaxBST :: Ord a => Tree a -> Tree a --Parcial en EmptyT (Equivalente a sacarMinT)
--Dado un BST devuelve el arbol sin el minimo elemento.
deleteMaxBST t = deleteBST (maxBST t) t


splitMinBST' :: Ord a => Tree a -> (a, Tree a)
--Dado un BST devuelve un par con el minimo elemento y el arbol sin el mismo.
splitMinBST' t = (minBST t, deleteMinBST t)


splitMaxBST' :: Ord a => Tree a -> (a, Tree a)
--Dado un BST devuelve un par con el maximo elemento y el arbol sin el mismo.
splitMaxBST' t = (maxBST t, deleteMaxBST t)


elMaximoMenorA :: Ord a => a -> Tree a -> Maybe a
--Dado un BST y un elemento, devuelve el maximo elemento que sea menor o igual al elemento dado.
elMaximoMenorA x EmptyT = Nothing
elMaximoMenorA x (NodeT y ri rd) = if x == y
										then Just y
										else
											if x < y
												then elMaximoMenorA x ri
												else maxM y (elMaximoMenorA x rd)

maxM :: Ord a => a -> Maybe a -> Maybe a
maxM x Nothing = Just x
maxM x (Just x') = Just (max x x')


elMinimoMayorA :: Ord a => a -> Tree a -> Maybe a
--Dado un BST y un elemento, devuelve el maximo elemento que sea menor o igual al elemento dado.
elMinimoMayorA x EmptyT = Nothing
elMinimoMayorA x (NodeT y ri rd) = if x == y
										then Just y
										else
											if x < y
												then elMinimoMayorA x rd
												else minM y (elMinimoMayorA x ri)

minM :: Ord a => a -> Maybe a -> Maybe a
minM x Nothing = Just x
minM x (Just x') = Just (min x x') 


--Arbol BST:
--
--			   6
--		     /   \
--		    4     8 
--		   / \   / \
--		  2	  5 7   9
--	     / \         \  
--	    0   3        10
--     / \             \ 
--   -1   1			   16				
--	 /				   / \ 
-- -2                 14 18


arbolBST :: Tree Int
arbolBST = NodeT 6 (NodeT 4 (NodeT 2 (NodeT 0 (NodeT (-1) (NodeT (-2) EmptyT EmptyT) EmptyT) (NodeT 1 EmptyT EmptyT)) (NodeT 3 EmptyT EmptyT)) (NodeT 5 EmptyT EmptyT)) (NodeT 8 (NodeT 7 EmptyT EmptyT) (NodeT 9 EmptyT (NodeT 10 EmptyT (NodeT 16 (NodeT 14 EmptyT EmptyT) (NodeT 18 EmptyT EmptyT)))))
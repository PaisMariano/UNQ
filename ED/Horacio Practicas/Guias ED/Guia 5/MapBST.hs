module MapBST (emptyM, isEmptyM, assocM, lookUpM, deleteM)where

import BST
import Auxiliares

data Map k v = MM (CantElementos, Tree (k, v)) --Tipo de representacion: Tree (Int, k, v)
type CantElementos = Int

--Invariante de representacion:
-- El arbol (k, v) cumple la propiedad BST.
-- El arbol (k, v) cumple la propiedad AVL.
-- El arbol no posee elementos repetidos.
-- No hay claves repetidas.
-- CantElementos coinside con la cantidad de elementos del arbol.
-- CantElementos >= 0

--A:
--O(1)
emptyM :: Map k v
emptyM = MM (0, EmptyT)


--B:
--O(1)
isEmptyM :: Map k v -> Bool
isEmptyM (MM (n, treeBST)) = n == 0


--C:
--O(log(n))
assocM :: Ord k => Map k v -> k -> v -> Map k v 
assocM (MM (n, treeBST)) k v = MM (calcularElementos n k treeBST, insert' k v treeBST)

--O(log(n))
calcularElementos :: Ord k => Int -> k -> Tree (k,v) -> Int
calcularElementos n k tree = if pertenece' k tree
										then n
										else sumarUno n

--O(log(n)
pertenece' :: Ord k => k -> Tree (k, v) -> Bool
pertenece' k EmptyT = False
pertenece' k (NodeT (k', _) ri rd) = k == k' || if k < k' 
												then pertenece' k ri 
												else pertenece' k rd    
--O(log(n)
insert' :: Ord k => k -> v -> Tree (k, v) -> Tree (k, v) -- Precondicion: El arbol debe ser BST y no contener elementos k repetidos.
insert' k v EmptyT = NodeT (hacerPar k v) EmptyT EmptyT
insert' k v (NodeT (k',v') ri rd) = if k == k'
											then NodeT (k', v) ri rd
											else 
												if k < k'
													then NodeT (k', v') (insert' k v ri) rd
													else NodeT (k', v') ri (insert' k v rd)


--D:
--O(log(n))
lookUpM :: Ord k => Map k v -> k -> Maybe v
lookUpM  (MM (n, treeBST)) x = lookUp x treeBST

--O(log(n))
lookUp :: Ord k => k -> Tree (k, v) -> Maybe v
lookUp k tree = case tree of
					EmptyT -> Nothing
					NodeT (k', v') ri rd -> if k == k'
													then Just v'
													else
														if k < k'
															then lookUp k ri
															else lookUp k rd

--E:
--O(log(n))?
deleteM :: Ord k => Map k v -> k -> Map k v
deleteM (MM (n, treeBST)) k = if n == 0
									then error "El Map debe contener al menos un elemento."
									else MM (determinarSiResto k n treeBST , delete' k treeBST)

--O(log(n))
determinarSiResto :: Ord k => k -> Int -> Tree (k, v) -> Int
determinarSiResto k n tree = if pertenece' k tree && n > 0
											then restarUno n --O(1)
											else n --O(1)

--O(log(n))
delete' :: Ord k => k -> Tree (k, v) -> Tree (k, v)
delete' k EmptyT = EmptyT
delete' k (NodeT (k',v') ri rd) = if k == k'
									then casoIgual' ri rd
									else
										if k < k'
											then NodeT (k',v') (delete' k ri) rd
											else NodeT (k',v') ri (delete' k rd)

--O(log(n))?
casoIgual' :: Ord k => Tree (k, v) -> Tree (k,v) -> Tree (k,v)
casoIgual' EmptyT arbol2 = arbol2
casoIgual' arbol1 arbol2 = rearmar' (separarMax' arbol1) arbol2

--O(1)
rearmar' :: ( (k,v), Tree (k, v)) -> Tree (k,v) -> Tree (k,v)
rearmar' ((k',v'), ri) rd = NodeT (k',v') ri rd

--O(log(n))?
separarMax' :: Ord k => Tree (k,v) -> ((k,v), Tree (k,v))
separarMax' (NodeT (k',v') ri EmptyT) = ((k',v'), ri)
separarMax' (NodeT (k',v') ri rd) =   
								let (max, arbol) = separarMax' rd
								in (max, NodeT (k',v') ri arbol)

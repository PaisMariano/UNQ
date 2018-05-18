module Map4(Map, emptyM, assocM, deleteM, lookUpM, domM)where

import Listas

data Map k v = MkM2 [(k, v)] deriving(Eq, Show)--Tipo de representacion: [(k, v)]



--Invariante de representacion:
--No hay claves repetidas.
--La lista esta ordenada de menor a mayor en relacion a las claves.


--O(1)
emptyM :: Map k v
emptyM = MkM2 []


--O(n)
assocM :: Ord k => Map k v -> k -> v -> Map k v
assocM (MkM2 kvs) k v = MkM2 (agregar (k, v) kvs)


--O(n)
agregar :: Ord k => (k, v) -> [(k, v)] -> [(k, v)]
--agregar (k,v) [] = ...
--agregar (k,v) kvs
agregar (k, v) [] = [(k,v)]
agregar (k,v) ((k',v') : kvs) = if k == k'
									then (k, v) : kvs
									else
										if(k > k') 
											then (k', v') : agregar (k, v) kvs
											else (k, v) : (k',v') : kvs

--O(n)
lookUpM :: Ord k => Map k v -> k -> Maybe v
lookUpM (MkM2 kvs) k = lookUp k kvs

--O(n)
lookUp :: Ord k => k -> [(k, v)] -> Maybe v
--lookUp k [] = ...
--lookUp k ((k', v) : kvs) = ... lookUp k kvs
lookUp k [] = Nothing
lookUp k ((k',v') : kvs) = if k == k'
							then Just v'
							else 
								if k > k'
									then lookUp k kvs
									else Nothing


--O(n)
deleteM :: Ord k => Map k v -> k -> Map k v
deleteM (MkM2 kvs) k = MkM2 (borrar k kvs)

--O(n)
borrar :: Ord k => k -> [(k, v)] -> [(k, v)]
borrar k [] = []
borrar k ((k',v') : kvs) = if k == k'
								then kvs
								else 
									if k >  k'
										then (k',v') : borrar k kvs
										else error "El elemento no se encuentra."


--O(n)
domM :: Map k v -> [k]
domM (MkM2 kvs) = lasClavesDe kvs

--O(n)
lasClavesDe :: [(k,v)] -> [k]
--lasClavesDe [] = ...
--lasClavesDe ((k, v) : kvs ) = ... lasClavesDe kvs
lasClavesDe [] = []
lasClavesDe ((k', v') : kvs) = k' : lasClavesDe kvs
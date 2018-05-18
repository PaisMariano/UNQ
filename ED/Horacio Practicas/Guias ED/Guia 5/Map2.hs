module Map2(Map, emptyM, assocM, deleteM, lookUpM, domM)where

import Listas

data Map k v = MkM2 [(k, v)] deriving(Eq, Show)--Tipo de representacion: [(k, v)]



--Invariante de representacion:
--No hay claves repetidas.


--O(1)
emptyM :: Map k v
emptyM = MkM2 []


--O(n)
assocM :: Eq k => Map k v -> k -> v -> Map k v
assocM (MkM2 kvs) k v = MkM2 (agregar (k, v) kvs)


--O(n)
agregar :: Eq k => (k, v) -> [(k, v)] -> [(k, v)]
--agregar (k,v) [] = ...
--agregar (k,v) kvs
agregar (k, v) [] = [(k,v)]
agregar (k,v) ((k',v') : kvs) = if k == k'
									then (k, v) : kvs
									else (k', v') : agregar (k, v) kvs



--O(n)
lookUpM :: Eq k => Map k v -> k -> Maybe v
lookUpM (MkM2 kvs) k = lookUp k kvs

--O(n)
lookUp :: Eq k => k -> [(k, v)] -> Maybe v
--lookUp k [] = ...
--lookUp k ((k', v) : kvs) = ... lookUp k kvs
lookUp k [] = Nothing
lookUp k (p : ps) = if k == fst p
							then Just (snd p)
							else lookUp k ps


--O(n)
deleteM :: Eq k => Map k v -> k -> Map k v
deleteM (MkM2 kvs) k = MkM2 (borrar k kvs)

--O(n)
borrar :: Eq k => k -> [(k, v)] -> [(k, v)]
borrar k [] = []
borrar k (p : ps) = if k == fst p
						then ps
						else p : borrar k ps


--O(n)
domM :: Map k v -> [k]
domM (MkM2 kvs) = lasClavesDe kvs

--O(n)
lasClavesDe :: [(k,v)] -> [k]
--lasClavesDe [] = ...
--lasClavesDe ((k, v) : kvs ) = ... lasClavesDe kvs
lasClavesDe [] = []
lasClavesDe ((k', v') : kvs) = k' : lasClavesDe kvs
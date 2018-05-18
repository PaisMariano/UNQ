module Map1 (Map, emptyM, assocM, deleteM, lookUpM, domM)where

import Listas 

data Map k v = MkM [(k, v)] deriving(Eq, Show)--Tipo de representacion: [(k, v)]



--Invariante de representacion:
--No hay.


--O(1)
emptyM :: Map k v
emptyM = MkM []


--O(1)
assocM :: Eq k => Map k v -> k -> v -> Map k v
assocM (MkM kvs) k v = MkM (agregar (k, v) kvs)


--O(1)
agregar :: (k, v) -> [(k, v)] -> [(k, v)]
agregar (k, v) kvs = (k,v) : kvs


--O(m) Siendo m la cantidad de claves
lookUpM :: Eq k => Map k v -> k -> Maybe v
lookUpM (MkM kvs) k = lookUp k kvs

--O(n) Siendo n el tamaño de la lista
lookUp :: Eq k=> k -> [(k, v)] -> Maybe v
--lookUp k [] = ...
--lookUp k ((k', v) : kvs) = ... lookUp k kvs
lookUp k [] = Nothing
lookUp k ( (k', v) : kvs) = if k == k'
							then Just v
							else lookUp k kvs


--O(m) Siendo n la cantidad de claves
deleteM :: Eq k => Map k v -> k -> Map k v
deleteM (MkM kvs) k = MkM (borrar k kvs)

borrar :: Eq k => k -> [(k, v)] -> [(k, v)]
borrar k [] = []
borrar k (p : ps) = if k == fst p
							then borrar k ps
							else p : borrar k ps

--O(m,n) Siendo n el tamaño de la lista y m la cantidad de claves.
domM :: Eq k => Map k v -> [k]
domM (MkM kvs) = sinRepetidos (lasClavesDe kvs)

--O(n)
lasClavesDe :: [(k,v)] -> [k]
--lasClavesDe [] = ...
--lasClavesDe ((k, v) : kvs ) = ... lasClavesDe kvs
lasClavesDe [] = []
lasClavesDe ((k, v) : kvs) = k : lasClavesDe kvs
module Map2 (Map, emptyM, assocM, lookupM, deleteM, domM) where

import Conjunto2

-- VERSION SIN REPETIDOS

data Map k v = M [(k,v)] deriving (Eq, Show)

emptyM :: Map k v
emptyM = M []

assocM :: Eq k => Map k v -> k -> v -> Map k v
assocM (M kvs) k v = M (agregar(k, v) kvs)

lookupM :: Eq k => Map k v -> k -> Maybe v
lookupM (M kvs) k = buscar k kvs

deleteM :: Eq k => Map k v -> k -> Map k v
deleteM (M kvs) k = M (borrar k kvs)

domM :: Eq k => Map k v -> Set k
domM (M kvs) = construirSetDeClaves kvs


--Auxiliares

agregar :: Eq k => (k, v) -> [(k, v)] -> [(k, v)]
agregar (k, v) [] = [(k, v)]
agregar (k, v) ((k', v'):kvs') = if k == k' 
									then agregar (k, v) kvs'
									else (k', v') : agregar (k, v) kvs'

buscar :: Eq k => k -> [(k, v)] -> Maybe v
buscar k [] 		  = Nothing
buscar k ((k', v'):kvs') = if k == k' 
							then Just v'
							else buscar k kvs'
							
borrar :: Eq k => k -> [(k, v)] -> [(k, v)]
borrar k [] = []
borrar k ((k', v'):kvs') = if k == k'
								then borrar k kvs'
								else (k', v') : kvs'

construirSetDeClaves :: Eq k => [(k, v)]-> Set k
construirSetDeClaves kvs = listToSet (listaPrimerElem kvs)

listaPrimerElem :: [(k, v)] -> [k]
listaPrimerElem []           = []
listaPrimerElem ((k, v):kvs) = k : listaPrimerElem kvs

listToSet :: Eq k => [k] -> Set k
listToSet []     = emptyS 
listToSet (k:ks) = unionS (singleton k) (listToSet ks)
									
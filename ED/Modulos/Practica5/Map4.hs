module Map4 (Map, emptyM, assocM, deleteM, lookupM, domM) where

import Conjunto2

-- VERSION SIN REPETIDOS CON ORDENAMIENTO

--Una lista con los k de los pares ordenados de menor a mayor


data Map k v = M [(k,v)] deriving (Eq, Show)

--O(1)
--Es constante porque siempre demora lo mismo en ejecutarse.
emptyM :: Map k v
emptyM = M []

--Precond: la lista recibida tiene que estar ordenada.
--O(n^2)
--Es cuadratica, porque la funcion ordenar, recorre la lista de borrar en el peor de los casos, por cada elemento la lista que usa ordenar.
--Por cada ordenar, recorre toda la lista buscando el elemento a borrar y luego lo agrega.
assocM :: (Eq k, Ord k, Ord v) => Map k v -> k -> v -> Map k v
assocM (M kvs) k v = M (ordenar(agregar(k, v) kvs))

--O(n)
--Es lineal porque recorre la lista kvs.
lookupM :: Eq k => Map k v -> k -> Maybe v
lookupM (M kvs) k = buscarM k kvs

--O(n)
--Es lineal porque borrarM recorre la lista que se le pasa como parametro.
deleteM :: Eq k => Map k v -> k -> Map k v
deleteM (M kvs) k = M (borrarM k kvs)

--O(n)
--es lineal porque las listas se recorren individualmente.
domM :: Eq k => Map k v -> Set k
domM (M kvs) = construirSetDeClaves kvs


--Auxiliares

agregar :: Eq k => (k, v) -> [(k, v)] -> [(k, v)]
agregar (k, v) [] = [(k, v)]
agregar (k, v) ((k', v'):kvs') = if k == k'
									then agregar (k, v) kvs'
									else (k', v') : agregar (k, v) kvs' 

ordenar :: (Eq k, Ord k, Ord v) => [(k, v)] -> [(k, v)]
ordenar []            = []
ordenar kvs = let m = minM kvs 
			  in m : ordenar (borrarM (fst(m)) kvs)

minM :: (Ord k, Ord v) => [(k, v)] -> (k, v)
minM [(k, v)]      = (k, v)
minM ((k, v): kvs) = min (k, v) (minM kvs)
						 
						

buscarM :: Eq k => k -> [(k, v)] -> Maybe v
buscarM k [] 		  = Nothing
buscarM k ((k', v'):kvs') = if k == k' 
							then Just v'
							else buscarM k kvs'
							
borrarM :: Eq k => k -> [(k, v)] -> [(k, v)]
borrarM k [] = []
borrarM k ((k', v'):kvs') = if k == k'
								then borrarM k kvs'
								else (k', v') : borrarM k kvs'

construirSetDeClaves :: Eq k => [(k, v)]-> Set k
construirSetDeClaves kvs = (listToSet (listaPrimerElem kvs))

ordenarLista :: Ord a => [a] -> [a]
ordenarLista []       = []
ordenarLista xs       = let m = (minL xs)
						in m : ordenarLista(borrarL m xs)

minL :: Ord a => [a] -> a
minL [x]   = x
minL (x:xs)= min x (minL xs)

borrarL :: Eq a => a -> [a] -> [a]
borrarL e []     = []
borrarL e (x:xs) = if e == x
						then borrarL e xs
						else x : borrarL e xs

listaPrimerElem :: [(k, v)] -> [k]
listaPrimerElem []           = []
listaPrimerElem ((k, v):kvs) = k : listaPrimerElem kvs

listToSet :: Eq k => [k] -> Set k
listToSet []     = emptyS 
listToSet (k:ks) = unionS (singleton k) (listToSet ks)
									
module Map3 (Map, emptyM, assocM, lookupM, deleteM) where

import Conjunto2

-- VERSION SIN REPETIDOS CON DOS LISTAS

data Map k v = M [k] [v] deriving (Eq, Show)

emptyM :: Map k v
emptyM = M [] []

assocM :: Eq k => Map k v -> k -> v -> Map k v
assocM (M ks vs) k v = let m = (agregar ks vs k v)
						 in M (fst(m)) (snd(m))

lookupM :: Eq k => Map k v -> k -> Maybe v
lookupM (M [k] [v]) k' = buscar [k] [v] k'

deleteM :: (Eq k, Eq v) => Map k v -> k -> Map k v
deleteM (M ks vs) k = M (borrar (posicion k ks) ks) (borrar (posicion k ks) vs)

domM :: Eq k => Map k v -> Set k
domM (M ks vs) = construirSetDeClaves ks

--Auxiliares

agregar :: Eq k => [k] -> [v] -> k -> v -> ([k], [v])
agregar [] [] k' v' = ([k'],[v']) 
agregar ks vs k' v' = if pertenece k' ks
								then (ks, vs)
								else (k':ks, v':vs)
								
pertenece :: Eq a => a -> [a] -> Bool
pertenece e []     = True
pertenece e (x:xs) = e == x && (pertenece e xs)

buscar :: Eq k => [k] -> [v] -> k -> Maybe v
buscar [] [] k'         = Nothing
buscar (k:ks) (v:vs) k' = if k == k' 
							then Just v
							else buscar ks vs k'
							
borrar :: Eq k => Int -> [k] -> [k]
borrar i []     = []
borrar i (k:ks) = if i == 0
					then borrar (i-1) ks
					else k : borrar (i-1) ks
					
posicion :: Eq k => k -> [k] -> Int
posicion k [] = 0
posicion k (k':ks) = if k == k'
						then 0
						else 1 + posicion k ks
			

construirSetDeClaves :: Eq k => [k] -> Set k
construirSetDeClaves ks = listToSet ks

listToSet :: Eq k => [k] -> Set k
listToSet []     = emptyS 
listToSet (k:ks) = unionS (singleton k) (listToSet ks)
									
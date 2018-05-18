module Multiset (Multiset, emptyMSet) where

import Map1
import Conjunto2

data Multiset = MkMS (Map k v) deriving Show

emptyMSet :: MultiSet a
emptyMSet = MkMS emptyM

addMS :: Ord k => k -> MultiSet k -> MultiSet k
addMS e (MkMS m) = MkMS (aparicionesM e m) k m)

aparicionesM :: k -> Map k v -> Int
aparicionesM e m = apariciones e (listToSet(domM m))

agregar :: Eq k => Int -> k -> Map k v -> Map k v
agregar i e m = if isEmptyM m
					then 
					else assocM  

 

Dados un elemento y un multiconjunto, agrega una ocurrencia de ese elemento al multiconjunto.
ocurrencesMS :: Ord a => a -> MultiSet a -> Int
Dados un elemento y un multiconjunto indica la cantidad de apariciones de ese elemento en
el multiconjunto.
unionMS :: Ord a => MultiSet a -> MultiSet a -> MultiSet a
Dados dos multiconjuntos devuelve un multiconjunto con todos los elementos de ambos
multiconjuntos.
intersectionMS :: Ord a => MultiSet a -> MultiSet a -> MultiSet a
Dados dos multiconjuntos devuelve el multiconjunto de elementos que ambos multiconjuntos
tienen en com´un.
multiSetToList :: MultiSet a -> [(Int,a)]
Dado un multiconjunto devuelve una lista con todos los elementos del conjunto y su cantidad
de ocurrencias.

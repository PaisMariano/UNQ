module Multiset(Multiset, emptyMSet, addMS, ocurrencesMS, unionMS, multiSetToList)where

import Map1
										   --K --V							
data Multiset a = MkMS (Map a Ocurrencia) --Tipo de representacion: Map elem ocurrencia. 
type Ocurrencia = Int

--Invariante de representacion:
-- La ocurrencia de un elemento debe ser >= 1
-- 


--A_
emptyMSet :: Multiset a
--Crea un multiconjunto vacio.
emptyMSet = MkMS (emptyM)


--B:
addMS :: Ord a => a -> Multiset a -> Multiset a
--Dados un elemento y un multiconjunto, agrega una ocurrencia de ese elemento al multiconjunto.
addMS x (MkMS map) = MkMS (agregar x map) 

agregar :: Ord a => a -> Map a Int -> Map a Int
agregar x map = assocM map x (laOcurrencia x map + 1)

laOcurrencia :: Eq a => a -> Map a Int -> Int
laOcurrencia x map = case lookUpM map x of
								Nothing -> 0 --Si Nothing, entoncess no estaba
								Just x -> x


--C:
ocurrencesMS :: Ord a => a -> Multiset a -> Int
--Dados un elemento y un multiconjunto indica la cantidad de apariciones de ese elemento en
--el multiconjunto.
ocurrencesMS x (MkMS map) = laOcurrencia x map


--D: Rehacer
unionMS :: Ord a => Multiset a -> Multiset a -> Multiset a
--Dados dos multiconjuntos devuelve un multiconjunto con todos los elementos de ambos
--multiconjuntos.
unionMS (MkMS map1) (MkMS map2) = MkMS (unionM  map1 map2)

unionM :: Ord a =>  Map a Int -> Map a Int  -> Map a Int 
unionM map1 map2 = hacerNuevoMs (domM map1) (domM map2) map1 map2

hacerNuevoMs :: Ord a => [k] -> [k] -> Map a Int  -> Map a Int  -> Map a Int
hacerNuevoMs [] [] map1 map2 = emptyM
--hacerNuevoMs [] (y : ys) map1 map2  = assocM (hacerNuevoMs [] ys map1 map2) y ((laOcurrencia y map2) + (laOcurrencia y map1))
--hacerNuevoMs (x : xs)  [] map1 map2  = assocM (hacerNuevoMs xs [] map1 map2) x ((laOcurrencia x map2) + (laOcurrencia x map1))
--hacerNuevoMs (x : xs)  (y : ys) map1 map2 = assocM (hacerNuevoMs xs xs map1 map2)  

--E:
--intersectionMS :: Ord a => Multiset a -> Multiset a -> Multiset a
--Dados dos multiconjuntos devuelve el multiconjunto de elementos que ambos multiconjuntos
--tienen en comun.


--F:
multiSetToList :: Ord a => Multiset a -> [(Int, a)]
--Dado un multiconjunto devuelve una lista con todos los elementos del conjunto y su cantidad
--de ocurrencias.
multiSetToList (MkMS map) =  hacerLista (todasLasOcurrencias (domM map) map) (domM map)

hacerLista :: Ord a => [Int] -> [a] -> [(Int, a)] --Las listas deben tener la misma longitud.
hacerLista [] [] = []
hacerLista (x : xs) (y : ys) = (x, y) : hacerLista xs ys

todasLasOcurrencias :: Ord a => [a] -> Map a Int -> [Int]
todasLasOcurrencias  [] map = []
todasLasOcurrencias (x : xs) map = laOcurrencia x map : todasLasOcurrencias xs map 









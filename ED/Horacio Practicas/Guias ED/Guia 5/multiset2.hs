module Multiset2(MultiSet, emptyMSet, addMS, ocurrencesMS, unionMS, intersectionMS, multiSetToList)where

import Map4
import Listas
										   --K --V							
data MultiSet a = MkMS (Map a Ocurrencia) deriving (Show) --Tipo de representacion: Map elem ocurrencia. 
type Ocurrencia = Int

--Invariante de representacion:
-- La ocurrencia de un elemento debe ser >= 1
 


--A_
emptyMSet :: MultiSet a
--Crea un multiconjunto vacio.
emptyMSet = MkMS (emptyM)


--B:
addMS :: Ord a => a -> MultiSet a -> MultiSet a
--Dados un elemento y un multiconjunto, agrega una ocurrencia de ese elemento al multiconjunto.
addMS x (MkMS map) = MkMS (agregar x map)

agregar :: Ord a => a -> Map a Int -> Map a Int
agregar x map = let ocurrencia = case lookUpM map x of
										Nothing -> 0
										Just x -> x 
			in assocM map x (ocurrencia + 1)


--C:
ocurrencesMS :: Ord a => a -> MultiSet a -> Int
--Dados un elemento y un multiconjunto indica la cantidad de apariciones de ese elemento en
--el multiconjunto.
ocurrencesMS x (MkMS map) = laOcurrencia x map

laOcurrencia :: Ord a=> a -> Map a Int -> Int
laOcurrencia x map = case lookUpM map x of 
								Nothing -> 0
								Just x -> x


--D:
unionMS :: Ord a => MultiSet a -> MultiSet a -> MultiSet a
unionMS (MkMS map1) (MkMS map2) = MkMS (hacerUnMap map1 map2 (domM map2))

hacerUnMap :: Ord a => Map a Int -> Map a Int -> [a] -> Map a Int
hacerUnMap map1 map2 [] = map1
hacerUnMap map1 map2 (x : xs) = 
	let o1 = laOcurrencia x map1
		in
		let o2 = laOcurrencia x map2
			in 
			let map = hacerUnMap map1 map2 xs
				in assocM map x (o1 + o2)

--E:
intersectionMS :: Ord a => MultiSet a -> MultiSet a -> MultiSet a
intersectionMS (MkMS map1) (MkMS map2) =  MkMS (hacerUnMap map1 map2 (sinRepetidos(elementosEnComun(domM map1) (domM map2))))

hacerUnMap' :: Ord a => Map a Int -> Map a Int -> [a] -> Map a Int
hacerUnMap' map1 map2 [] = map1
hacerUnMap' map1 map2 (x : xs) =
	let map = hacerUnMap' map1 map2 xs 
		in
			let o = laOcurrencia x map
				in assocM map x o



--F:
multiSetToList ::Ord a => MultiSet a -> [(Int, a)]
multiSetToList (MkMS map) = hacerLista (domM map) map

hacerLista :: Ord a => [a] -> Map a Int -> [(Int, a)]
hacerLista [] map = []
hacerLista (a : as) map  = hacerPar (laOcurrencia a map) a : hacerLista as map

hacerPar :: Int -> a -> (Int, a)
hacerPar n a = (n, a)


ocurrencias :: [Char] -> MultiSet Char 
--Dado un string cuenta las ocurrencias de cada caracter utilizando un Map.
ocurrencias [] = emptyMSet
ocurrencias (c : cs) = addMS c (ocurrencias cs) 


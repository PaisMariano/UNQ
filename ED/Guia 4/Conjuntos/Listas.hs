module Listas (pertenece, sonLoMismo, sinRepetidos, longitud, filtrarElemento, contarNoRepetidos, elementosEnComun, promedio, apariciones)where

pertenece :: Eq a => a -> [a] -> Bool
--Dado un elemento y una lista, retorna si dicho elemento pertenece a la lista pasada por parametro.
pertenece x [] = False
pertenece x (y: ys) = sonLoMismo x y || pertenece x ys

sonLoMismo :: Eq a => a -> a -> Bool
--Dado x e y, retorna si ambos son iguales. 
sonLoMismo x y = x == y


sinRepetidos :: Eq a => [a] -> [a]
--Dado una lista, retorna la misma lista pero sin elementos repetidos.
--sinRepetidos [] = ...
--sinRepetidos (x : xs) = ... sinRepetidos ...
sinRepetidos [] = []
sinRepetidos (x : xs) = if pertenece x xs
								then sinRepetidos xs
								else x : sinRepetidos xs

longitud :: [a] -> Int
--Dada una lista, retorna la cantidad de elementos.
--longitud [] = ...
--longitud (x : xs) = ... longitud ...
longitud [] = 0
longitud (x : xs) = 1 + longitud xs

filtrarElemento :: Eq a => a -> [a] -> [a]
--Dado un elemento x y una lista, retorna la lista que se obtiene de filtrar todas las apariciones de ese elemento.
--filtrarElemento x [] = ...
--filtrarElemento x (x : xs) = ... filtrarElemento ...
filtrarElemento x [] = []
filtrarElemento x (y : ys) = if (sonLoMismo x y)
									then filtrarElemento x ys
									else y : filtrarElemento x ys

contarNoRepetidos :: Eq a => [a] -> Int
--Dada una lista, retorna la cantidad de elements no repetidos que contiene.
contarNoRepetidos [] = 0
contarNoRepetidos (x : xs) = if(pertenece x xs)
									then contarNoRepetidos xs
									else 1 + contarNoRepetidos xs

elementosEnComun :: Eq a => [a] -> [a] -> [a]
--Dado dos listas del mismo tipo, retorna una lista con los elementos en comun.
elementosEnComun [] _ = []
elementosEnComun (x : xs) ys = if (pertenece x xs)
										then x : elementosEnComun xs ys
										else elementosEnComun xs ys

promedio :: [Int] -> Int
promedio xs = sumatoria xs `div` longitud xs 

apariciones :: Eq a => a -> [a] -> Int
--apariciones z [] = ...
--apariciones z (x : xs) = ... apaciciones ...
apariciones z [] = 0
apariciones z (x : xs) = if (sonLoMismo z x)
			then 1 + apariciones z xs
			else apariciones z xs

sumatoria :: [Int] -> Int
sumatoria [] = 0
sumatoria (n : ns) = n + sumatoria ns



module Practica1(
	Tree(..), 
	sumatoria, 
	sinRepetidos) where

data Tree a =
	EmptyT |
	NodeT a (Tree a)
	        (Tree a) deriving Show

sumatoria :: [Int] -> Int
sumatoria [] = 0
sumatoria (x:xs) = 
	x + sumatoria xs

sinRepetidos :: Eq a => [a] -> [a]
sinRepetidos [] = []
sinRepetidos (x:xs) = 
	if pertenece x xs
		then sinRepetidos xs
		else x : sinRepetidos xs

pertenece :: Eq a => a -> [a] -> Bool
pertenece n [] = False
pertenece n (x:xs) = 
	n == x || pertenece n xs

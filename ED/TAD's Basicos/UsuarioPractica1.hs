import Practica1

sumatorias :: [[Int]] -> Int
sumatorias [] = 0
sumatorias (x:xs) =
	sumatoria x +
	sumatorias xs 

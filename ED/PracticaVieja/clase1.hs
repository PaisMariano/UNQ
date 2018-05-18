--Auxiliares

len :: [a] -> Int
len [] = 0
len (x:xs) = 1 + len xs


-- PRACTICA 1
-- 1)
sucesor :: Int -> Int
sucesor x = x+1

sumar :: Int -> Int -> Int
sumar x y = x+y

maximo :: Int -> Int -> Int
maximo x y =
	if x > y 
		then x
		else y

-- 2)
negar :: Bool -> Bool
negar False = True
negar True = False

andLogico :: Bool -> Bool -> Bool 
andLogico True True = True
andLogico True False = False
andLogico False True = False
andLogico False False = False

orLogico :: Bool -> Bool -> Bool
orLogico True True = True
orLogico True False = True
orLogico False True = True
orLogico False False = False

primera :: (Int,Int) -> Int
primera (x,y) = x

segunda :: (Int,Int) -> Int
segunda (x,y) = y

sumarPar :: (Int,Int) -> Int
sumarPar (w,x) = w+x

maxDelPar :: (Int,Int) -> Int
maxDelPar (x,y) = maximo x y    --PATTERN MATCHING

--3)
loMismo :: a -> a
loMismo x = x

siempreSiete :: a -> Int 
siempreSiete x = 7

duplicar :: a -> (a,a)
duplicar x = (x,x)

singleton :: a -> [a]
singleton x = x:[]

--4)
isEmpty :: [a] -> Bool
isEmpty [] = True
isEmpty (x:xs) = False

head' :: [a] -> a
head' (x:xs) = x

tail' :: [a] -> [a]
tail' (x:xs) = xs

--2.1)
sumatoria :: [Int] -> Int
sumatoria [] = 0
sumatoria (x:xs) = x + sumatoria(xs)

longitud :: [a] -> Int
longitud [] = 0
longitud (x:xs) = 1 + longitud(xs)

--promedio :: [Int] -> Int
--promedio [] = 0
--promedio (x:xs) = (x + sumatoria xs) / (1 + len xs)

mapSucesor :: [Int] -> [Int]
mapSucesor [] = []
mapSucesor (x:xs) = sucesor x : mapSucesor xs

mapSumaPar :: [(Int, Int)] -> [Int]
mapSumaPar [] = []
mapSumaPar (x:xs) = sumarPar x : mapSumaPar xs

mapMaxDelPar :: [(Int,Int)] -> [Int]
mapMaxDelPar [] = []
mapMaxDelPar (x:xs) = maxDelPar x : mapMaxDelPar xs


todoVerdad :: [Bool] -> Bool
todoVerdad [] = True
todoVerdad (x:xs) = x && todoVerdad(xs)


algunaVerdad ::[Bool] -> Bool
algunaVerdad [] = False
algunaVerdad (x:xs) = x || algunaVerdad(xs)


pertenece :: Eq a => a -> [a] -> Bool
pertenece a [] = False
pertenece a (x:xs) =
		if x == a
			then True
			else pertenece a (xs)

			
apariciones :: Eq a => a -> [a] -> Int
apariciones a [] = 0
apariciones a (x:xs) = 
		if x == a 
			then 1 + apariciones a xs  
			else apariciones a xs

filtrarMenoresA :: Int -> [Int] -> [Int]
filtrarMenoresA a [] = []
filtrarMenoresA a (x:xs) =
		if x < a 
			then x : filtrarMenoresA a xs
			else filtrarMenoresA a xs
			
filtrarElemento :: Eq a => a -> [a] -> [a]
filtrarElemento a [] = []
filtrarElemento a (x:xs) =
		if x == a
			then filtrarElemento a xs
			else x : filtrarElemento a xs
			
mapLongitudes :: [[a]] -> [Int]
mapLongitudes [] = []
mapLongitudes (x:xs) = length x : mapLongitudes xs

longitudMayorA :: Int -> [[a]] -> [[a]]
longitudMayorA a [] = []
longitudMayorA a (x:xs) = 
		if a < length x
			then x : longitudMayorA a xs
			else longitudMayorA a xs
			
intercalar :: a -> [a] -> [a]
intercalar a [b] = [b]
intercalar a [] = []
intercalar a (x:xs) = x : a : intercalar a xs

snoc :: [a] -> a -> [a]
snoc [] a = [a]
snoc (x:xs) a = x : snoc xs a

append :: [a] -> [a] -> [a]
append [] a = a
append (x:xs) a = x : append xs a

aplanar :: [[a]] -> [a]
--aplanar [] = 
--aplanar (x:xs) =           aplanar xs
aplanar [] = []
aplanar (x:xs) = x ++ aplanar xs

reversa :: [a] -> [a]
--reversa [] = 
--reversa (x:xs) =           reversa xs
reversa [] = []
reversa (xs) = last xs : reversa (init(xs))

zipMaximos :: [Int] -> [Int] -> [Int]
zipMaximos [] [] = [] 
zipMaximos xs [] = xs 
zipMaximos [] ys = ys
zipMaximos (x:xs) (y:ys) = 
			if x >= y
				then x : zipMaximos xs ys
				else y : zipMaximos xs ys

zipSort :: [Int] -> [Int] -> [(Int, Int)]
-- zipSort [] = 
-- zipSort (x:xs) =           zipSort xs
zipSort [] [] = []
zipSort (x:xs) (y:ys) = 
			if x < y 
				then (x, y) : zipSort xs ys
				else (y, x) : zipSort xs ys

--2.2

factorial :: Int -> Int
-- factorial 0 = 
-- factorial x =            factorial xs
factorial 0 = 1
factorial x = x * factorial (x - 1)
			
cuentaRegresiva :: Int -> [Int]
-- cuentaRegresiva 0 = 
-- cuentaRegresiva x =       cuentaRegresiva xs
cuentaRegresiva 0 = []
cuentaRegresiva x = x : cuentaRegresiva (x - 1)

contarHasta :: Int -> [Int]
-- ContarHasta 0 = 
-- ContarHasta x =			 contarHasta x
contarHasta 0 = []
contarHasta x = x : contarHasta (x - 1)










		


			


























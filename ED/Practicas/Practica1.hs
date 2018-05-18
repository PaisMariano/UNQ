--1)
--a)

sucesor :: Int -> Int
sucesor x = x + 1

--b)
sumar :: Int -> Int -> Int
sumar x y  = x + y

--c)
maximo :: Int -> Int -> Int
maximo x y = if x > y
	     then x
	     else y

--2)
--a)

negar :: Bool -> Bool
negar True = False
negar False = True

--b) 
andLogico :: Bool -> Bool -> Bool
andLogico True True = True
andLogico x y  	    = False

--c)
orLogico :: Bool -> Bool -> Bool
orLogico False False = False
orLogico x y         = True

--d)
primera :: (Int,Int) -> Int
primera (x, y) = x

--e)
segunda :: (Int,Int) -> Int
segunda (x, y) = y

--f)
sumaPar :: (Int, Int) -> Int
sumaPar (x, y) = x + y

--g) 
maxDelPar :: (Int, Int) -> Int
maxDelPar (x, y) = maximo x y

--3)
--a)

loMismo :: a -> a
loMismo x = x

--b)
siempreSiete :: a -> Int
siempreSiete x = 7

--c)
duplicar :: a -> (a, a)
duplicar x = (x, x)

--d)
singleton :: a -> [a]
singleton x = [x]

--4)
--a)

isEmpty :: [a] -> Bool
isEmpty [] = True
isEmpty xs = False

--b)
head' :: [a] -> a
head' []   = error "La lista es vacia."
head' (x:xs) = x

--c) 
tail' :: [a] -> [a]
tail' []   = error "La lista es vacia."
tail' (x:xs) = xs 


--2. RECURSION 
--2.1

--1)

sumatoria :: [Int] -> Int
sumatoria []     = 0 
sumatoria (x:xs) = x + sumatoria xs

--2)
longitud :: [a] -> Int
longitud [] = 0
longitud (x:xs) = 1 + longitud xs

--3)
mapSucesor :: [Int] -> [Int]
mapSucesor []     = []
mapSucesor (x:xs) = x + 1 : mapSucesor xs

--4)
mapSumaPar :: [(Int, Int)] -> [Int]
mapSumaPar []     = []  
mapSumaPar (x:xs) = primera x + segunda x : mapSumaPar xs

--5)
mapMaxDelPar :: [(Int, Int)] -> [Int]
mapMaxDelPar []     = []
mapMaxDelPar (x:xs) = maximo (primera x) (segunda x) : (mapMaxDelPar xs)

--6) FANCY
--todoVerdad :: [Bool] -> Bool
--todoVerdad []     = True
--todoVerdad (x:xs) = andLogico x (todoVerdad xs)

--6) ALT
todoVerdad :: [Bool] -> Bool
todoVerdad []     = True
todoVerdad (x:xs) = x && todoVerdad xs

--7)
algunaVerdad :: [Bool] -> Bool
algunaVerdad []     = False
algunaVerdad (x:xs)   = x || algunaVerdad xs

--8)
pertenece :: Eq a => a -> [a] -> Bool
pertenece y []     = False 
pertenece y (x:xs) = if esIgual x y
			then True
			else pertenece y xs

intSonIguales :: Eq a => a -> a -> Int
intSonIguales y x = if y == x 
			then 1
			else 0
						
sonIguales :: Eq a => a -> a -> Bool
sonIguales y x = y == x
						
--9)
apariciones :: Eq a => a -> [a] -> Int
apariciones y []     = 0
apariciones y (x:xs) = intSonIguales y x + apariciones y xs


							
--10)
filtrarMenoresA :: Int -> [Int] -> [Int]
filtrarMenoresA y []     = []
filtrarMenoresA y (x:xs) = if y > x 
				then x : filtrarMenoresA y xs
				else filtrarMenoresA y xs

--11) 
filtrarElemento :: Eq a => a -> [a] -> [a]
filtrarElemento y []     = []
filtrarElemento y (x:xs) = if sonIguales y x 
				then filtrarElemento y xs
				else x : filtrarElemento y xs

								
--12)
mapLongitudes :: [[a]] -> [Int]
mapLongitudes []     = []
mapLongitudes (x:xs) = longitud x : mapLongitudes xs

--13)
longitudMayorA :: Int -> [[a]] -> [[a]]
longitudMayorA i []     = []
longitudMayorA i (x:xs) = if i > longitud x
				then longitudMayorA i xs 
				else x : longitudMayorA i xs
								
--14)
intercalar :: a -> [a] -> [a]
intercalar y []     = []
intercalar y (x:xs) = if (longitud xs >= 1)
			then x : y : intercalar y xs
			else x : intercalar y xs

--FEO PERO MAS BARATO
--intercalar :: a -> [a] -> [a]
--intercalar y [x]    = x : []
--intercalar y (x:xs) = x : y : intercalar y xs

--15)
snoc :: [a] -> a -> [a]
snoc [] y    = y : [] 
snoc (x:xs) y  = x : snoc xs y

--16)
--Version HMM
--append :: [a] -> [a] -> [a]
--append ys []     = ys
--append ys (x:xs) = append (snoc ys x) xs

--Version ++
append :: [a] -> [a] -> [a]
append ys []     = ys
append ys (x:xs) = append (ys ++ [x]) xs

aplanar :: [[a]] -> [a]
aplanar []      = []
aplanar (x:xs) = x ++ aplanar xs 

reversa :: [a] -> [a]
reversa [] = []
reversa (x:xs) = reversa xs ++ [x]

esMayor :: Ord a => a -> a -> Bool
esMayor y x = y > x

esMenorVal :: Ord a => a -> a -> a
esMenorVal y x = if y < x
				then y
				else x

esMayorVal :: Ord a => a -> a -> a
esMayorVal y x = if y > x
				then y
				else x

zipMaximos :: [Int] -> [Int] -> [Int]
zipMaximos [] xs         = xs 
zipMaximos ys []         = ys
zipMaximos (y:ys) (x:xs) = if esMayor y x
				then y : zipMaximos ys xs
				else x : zipMaximos ys xs


zipSort :: [Int] -> [Int] -> [(Int, Int)]
zipSort [] []         = []
zipSort (x:xs) (y:ys) = if esMayor y x
				then (y, x) : zipSort xs ys
				else (x, y) : zipSort xs ys

--Seria asi para hacerlo recursivo							
--promedio :: [Fractional Int] -> Fractional Int
--promedio []     = 0
--promedio (x:xs) = fromIntegral (x + promedio xs) / fromIntegral (1 + promedio xs)
	
minimum' :: Ord a => [a] -> a
minimum' []  = error "No deber llegar a ser vacia nunca."
minimum' [x] = x
minimum' (x:xs) = esMenorVal x (minimum' xs)

--2.2 Recursion sobre numeros 
--1)
factorial :: Int -> Int
factorial 0 = 1
factorial x = x * factorial (x - 1)

--2)
cuentaRegresiva :: Int -> [Int]
cuentaRegresiva 0 = []
cuentaRegresiva x = x : cuentaRegresiva (x - 1)

--3)
contarHasta :: Int -> [Int]
contarHasta 0 = []
contarHasta x = contarHasta (x - 1) ++ [x]

--4)
replicarN :: Int -> a -> [a]
replicarN 0 e = []
replicarN x e = e : replicarN (x - 1) e

--5)
-- Precondicion el segundo valor debe ser mayor al primero y positivo.

desdeHasta :: Int -> Int -> [Int]
desdeHasta 0 0 = []
desdeHasta x y = if (y - x) >= 0
			then x : desdeHasta (x + 1) y
			else desdeHasta 0 0 
--6)
--Version mas visible.
takeN :: Int -> [a] -> [a]
takeN e []     = []
takeN e (x:xs) = if e > 0
			then x : takeN (e - 1) xs
			else takeN (e - 1) xs
{-					
--Version no miyagui
takeN :: Int -> [a] -> [a]
takeN e []     = []
takeN 0 xs     = xs
takeN e (x:xs) = x : takeN (e - 1) xs

--Version hardcodeo el final :S
takeN :: Int -> [a] -> [a]
takeN e []     = []
takeN e (x:xs) = if e > 0
					then x : takeN (e - 1) xs
					else takeN e [] 
					
-}					

--7)

dropN :: Int -> [a] -> [a]
dropN e []     = []
dropN 0 xs     = xs
dropN e (x:xs) = dropN (e - 1) xs

--8)

splitN :: Int -> [a] -> ([a], [a])
splitN e xs = (takeN e xs, dropN e xs)

--PREGUNTAR
{-
Dados un número n y una lista xs, devuelve un par 
donde la primera componente es la lista
que resulta de aplicar takeN a xs, y la segunda 
componente el resultado de aplicar dropN
a xs. ¿Conviene utilizar recursión?

-}

--Anexo ejercicios adicionales

--1)
maximum' :: Ord a => [a] -> a
maximum' []  = error "No deber llegar a ser vacia nunca."
maximum' [x] = x
maximum' (x:xs) = esMayorVal x (maximum' xs)

--2)
splitMin :: Ord a => [a] -> (a, [a])
splitMin xs = let m = minimum' xs
			   in (m , filtrarElemento m xs)

--3)			  
ordenar :: Ord a => [a] -> [a]
ordenar []     = []
ordenar (x:xs) = if (x < minimum' xs)
			then x : ordenar xs
			else ordenar (xs ++ [x])

--4)
interseccion :: Eq a => [a] -> [a] -> [a]
interseccion [] ys         = []
interseccion (x:xs) ys = if pertenece x ys
				then x : interseccion xs ys
				else interseccion xs ys
esIgual :: Eq a => a -> a -> Bool
esIgual x y = x == y
--5)
diferencia :: Eq a => [a] -> [a] -> [a]
diferencia [] ys         = ys
diferencia xs []         = xs
diferencia (x:xs) (y:ys) =  if esIgual x y 
				then diferencia xs ys
				else x : y : diferencia xs ys




particionPorSigno :: [Int] -> ([Int], [Int])
particionPorSigno xs = (ppsNegativo xs , ppsPositivo xs)  

ppsNegativo :: [Int] -> [Int]
ppsNegativo []     = [] 
ppsNegativo (x:xs) = if x < 0 
			then x : ppsNegativo xs
			else ppsNegativo xs

ppsPositivo :: [Int] -> [Int]
ppsPositivo []     = [] 
ppsPositivo (x:xs) = if x >= 0 
			then x : ppsPositivo xs
			else ppsPositivo xs 

particionPorParidad :: [Int] -> ([Int], [Int])
particionPorParidad xs = (pppp xs, pppi xs)

pppp :: [Int] -> [Int]
pppp []     = [] 
pppp (x:xs) = if esPar x
		then x : pppp xs 
		else pppp xs

pppi :: [Int] -> [Int]
pppi []     = []
pppi (x:xs) = if esPar x 
		then pppi xs
		else x : pppi xs

esPar :: Int -> Bool
esPar n = mod n 2 == 0



subtails :: [a] -> [[a]]
subtails [] = [[]]
subtails (x:xs) = (x:xs) : subtails xs



agrupar :: Eq a => [a] -> [[a]]
agrupar []     = []
agrupar [x]    = [[x]]
agrupar xs = hacerLista (repetidos xs) (head xs) : agrupar (tailN (repetidos xs) xs)

hacerLista :: Int -> a -> [a]
hacerLista 0 x = []
hacerLista n x = [x] ++ hacerLista (n-1) x

repetidos :: Eq a => [a] -> Int
repetidos []       = error "No deberia llegar a lista vacia"
repetidos [x]      = 1
repetidos (x:y:xs) = if esIgual x y
			then 1 + repetidos (y : xs)
			else 1

tailN :: Int -> [a] -> [a]
tailN 0 xs     = xs   
tailN n []     = [] 
tailN n (x:xs) = tailN (n-1) xs


esPrefijo :: Eq a => [a] -> [a] -> Bool
esPrefijo [] ys         = True
esPrefijo (x:xs) (y:ys) = if esIgual x y 
				then esPrefijo xs ys 
				else False
				

esSufijo :: Eq a => [a] -> [a] -> Bool
esSufijo [] []         = True 
esSufijo (x:xs) (y:ys) = if longitud xs < longitud ys
				then esSufijo (x:xs) ys 
				else esPrefijo (x:xs) (y:ys)










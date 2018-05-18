---------------------------------------------------------------------------------------
-----------------------------------  Conceptos Basicos --------------------------------
---------------------------------------------------------------------------------------


--1 Funciones Basicas:

--A
sucesor :: Int -> Int
sucesor x = x + 1


--B
sumar :: Int -> Int -> Int
sumar x y = x + y


--C
maximo :: Int -> Int -> Int
maximo x y = if x >= y
		then x
		else y 


---------------------------------------------------------------------------------------
-----------------------------------  Pattern Matching ---------------------------------
---------------------------------------------------------------------------------------


--2

--A		
negar :: Bool -> Bool
negar True = False
negar False = True


--B
andLogico :: Bool -> Bool -> Bool
andLogico  True x  = x 
andLogico False _ = False


--C
orLogico :: Bool -> Bool -> Bool
orLogico False False = False
orLogico _ _ = True

	
--D
primera :: (Int, Int) -> Int
primera (a,  b) = a


--E
segunda :: (Int, Int) -> Int 
segunda (a, b) = b


--F
sumarPar :: (Int, Int) -> Int
sumarPar (a, b) = a + b


--G
maxDelPar :: (Int, Int) -> Int
maxDelPar (a, b) = maximo a b


---------------------------------------------------------------------------------------
-------------------------------------  Polimorfismo -----------------------------------
---------------------------------------------------------------------------------------


--3

--A
loMismo :: a -> a
loMismo x = x


--B
siempreSiete :: a -> Int
siempreSiete x = 7


--C
duplicar :: a -> (a, a)
duplicar x = (x, x)


--D
singleton :: a -> [a]
singleton x = [x]


--4 Patter Matching sobre Listas:

--A
isEmpty :: [a] -> Bool
isEmpty [] = True
isEmpty _ = False


--B	
head' :: [a] -> a
head' [] = error "La lista no puede estar vacia."
head' (x : xs) = x


--C
tail' :: [a] -> [a]       
tail' [] = error "La lista no puede estar vacia"
tail' (x : xs) = xs


---------------------------------------------------------------------------------------
-------------------------------------  Recursion  -------------------------------------
---------------------------------------------------------------------------------------


--2

--2.1 Recursion sobre Listas:

--1
sumatoria :: [Int] -> Int
--sumatoria [] = ...
--sumatoria (x : xs) = ... sumatoria ...
sumatoria [] = 0
sumatoria (x : xs) = x + sumatoria xs 


--2
longitud :: [a] -> Int
--longitud [] = ...
--longitud (x : xs) = ... longitud ...
longitud [] = 0
longitud (x : xs) = 1 + longitud xs


--X Para que funcione plenamente hay que cambiar los tipos de las funciones sumatorias y longitud a Float
--Error: Instance of fractional Int requerid for definition of Promedio 
--3
--promedio :: [Int] -> Int
--promedio xs = sumatoria xs / longitud xs 


--4
mapSucesor :: [Int] -> [Int]
--mapSucesor [] = ...
--mapSucesor (x : xs) = ... mapSucesor ...
mapSucesor [] = []
mapSucesor (x : xs) = sucesor x : mapSucesor xs


--5
mapSumaPar :: [(Int, Int)] -> [Int]
--mapSumaPar [] = ...
--mapSumaPar (x : xs) = ... mapSumaPar xs ...
mapSumaPar [] = []
mapSumaPar (x : xs )  = sumarPar x : mapSumaPar xs

	
--6	
mapMaxDelPar :: [(Int, Int)] -> [Int]
--mapMaxDelPar [] = ...
--mapMaxDelPar (x : xs) = ... mapMaxdelPar ...
mapMaxDelPar [] = []
mapMaxDelPar (x : xs) = maxDelPar x : mapMaxDelPar xs


--7
todoVerdad :: [Bool] -> Bool
--todoVerdad [] = ...
--todoVerdad (x : xs) = ... todoVerdad ...
todoVerdad [] = True
todoVerdad (x : xs) = esVerdad x && todoVerdad xs   


esVerdad :: Bool -> Bool --Tranquilamente podria ser poliformica parametral a -> a, pero asi hace mas al problema.
esVerdad x = x


--8
algunaVerdad :: [Bool] -> Bool 
--algunaVerdad [] = ...
--algunaVerdad (x : xs) = ... algunaVerdad ...
algunaVerdad [] = False
algunaVerdad (x : xs) = (esVerdad x) || algunaVerdad xs


--9
pertenece :: Eq a => a -> [a] -> Bool
--pertenece z [] = ...
--pertenece z (x : xs) = ... pertenece ...
pertenece z [] = False
pertenece z (x : xs) =  sonIguales z x || pertenece z xs


sonIguales :: Eq a => a -> a -> Bool
sonIguales x y = x == y


--10
apariciones :: Eq a => a -> [a] -> Int
--apariciones z [] = ...
--apariciones z (x : xs) = ... apaciciones ...
apariciones z [] = 0
apariciones z (x : xs) = if (sonIguales z x)
			then 1 + apariciones z xs
			else apariciones z xs


--11
filtrarMenoresA :: Int -> [Int] -> [Int]
--filtrarMenoresA y [] = ...
--filtrarMenoresA y (x : xs) = ... filtrarMenoresA ...
filtrarMenoresA y [] = []
filtrarMenoresA y (x : xs) = if (esMenor x y)
				then filtrarMenoresA y xs
				else x : filtrarMenoresA y xs


esMenor :: Int -> Int -> Bool
esMenor a b = a < b


--12
--Funciona parcialmente. Revisar caso borde.
filtrarElemento :: Eq a => a -> [a] -> [a]
--filtrarElemento y [] = ...
--filtrarElemento y (x : xs) = ... filtrarElemento ...
filtrar elemento y [] = []
filtrarElemento y (x : xs) = if (not (sonIguales y x))
								then x : filtrarElemento y xs
								else filtrarElemento y xs


--13
--mapLongitudes :: [[a]] -> [a]
--mapLongitudes [] = ...
--mapLongitudes (x : xs) = ... mapLongitudes ...
--mapLongitudes [] = [0] 	
--mapLongitudes (x : xs) = longitud x : mapLongitudes xs


--13 
mapLongitudes :: [[a]] -> [Int] 
mapLongitudes [] = []
mapLongitudes (xs:ws) =    longitud xs :mapLongitudes ws


--X
--14
--longitudMayorA :: Int -> [[a]] -> [Int]
--longitudMayorA 0 xs = ...
--longitudMayorA (x : xs) = ... longitudMayorA ...
--longitudMayorA 0 xs = xs
--longitudMayorA num (x : xs) = if(longitud x > num)
--									then longitud x : longitudMayorA num xs 
--									else longitudMayorA num xs



--14. dado un nro, devuelve las listas que tenga esa cant o mas de caracteres
longitudMayorA :: Int -> [[a]] -> [[a]] 
longitudMayorA n[] = []
longitudMayorA  n (xs:ws) =    if(longitud xs )> n  
								then xs:longitudMayorA n ws
								else  longitudMayorA n ws

--15  
intercalar :: a -> [a] -> [a]
--intercalar y [] = ...
-- intercalar y (x : xs) = ... intercalar ...
intercalar y [] = []
intercalar y (x : xs) = if(longitud xs > 1)
							then x : y : intercalar y xs
							else xs


--16
snoc :: [a] -> a -> [a]
--snoc [] elem = ...
--snoc (x : xs) = ... snoc ...
snoc [] elem = [elem]
snoc (x : xs) elem =  x : xs ++ [elem]


--17
append :: [a] -> [a] -> [a]
--append [] ys = ...
--append (x : xs) ys = ... append ... 
append [] [] = []
append xs [] = xs
append [] ys = ys
append (x : xs) ys = x : append xs ys


--18
aplanar :: [[a]] -> [a]
--aplanar [] = ...
--aplanar (x : xs) = ... aplanar ...
aplanar [[]] = []
aplanar [] = []
aplanar (x : xs) = x ++ aplanar xs 


--19
reversa :: [a] -> [a]
--reversa [] = ...
--reversa (x:xs) = ...reversa...
reversa [] = []
reversa (x : xs) = reversa xs ++ [x]


--20
zipMaximos :: [Int] -> [Int] -> [Int]
--zipMaximos [] [] = ...
--zipMaximo [] ys = ...
--zipMaximo xs [] = ...
--zipMaximo (x : xs) ys = ... zipMaxmo...
zipMaximos [] [] = []
zipMaximos [] ys = ys
zipMaximos xs [] = xs
zipMaximos (x : xs) (y : ys) = maximo x  y : zipMaximos xs ys


--21
	:: [Int] -> [Int] -> [(Int, Int)]
--zipSort [] [] = ...
--zipSort (x : xs) ys = ... zipShort...
zipS	ort [] [] = []
zipSort (x : xs) (y : ys) = acomodarMenorMayor ( x y) ++ zipSort xs ys 


acomodarMenorMayor :: Int -> Int -> [(Int, Int)]
acomodarMenorMayor a b = [((minimo a b), (maximo a b))]


minimo :: Int -> Int -> Int
minimo x y = if(x < y)
		then x
		else y


--2.2 Recursion sobre Numeros:

--1
factorial :: Int -> Int
--factorial 0 = ...
--factorial x = ...factorial ...
factorial 0 = 1
factorial x = if(x > 1)
				 then x * factorial (x - 1)
				 else x


--2
cuentaRegresiva :: Int -> [Int]
--cuentaRegresiva 0 = ...
--cuentaRegresiva x =  ...cuentaRegresiva... 
cuentaRegresiva 0 = []
cuentaRegresiva x = [x] ++ cuentaRegresiva (x-1)


--3
contarHasta :: Int -> [Int] 
--contarHasta 0 = ...
--contarHasta x = ...contarHasta...
contarHasta 0 = []
contarHasta x = reversa(cuentaRegresiva x)


--4
replicarN :: Int -> a -> [a]
--replicarN 0 _ = ...
--replicarN x y = ... replicarN ...
replicarN 0 _ = []
replicarN x y = if( x > 0)
		then y : replicarN (x-1) y
		else []


--5
--Sin Recursividad:
desdeHasta :: Int -> Int -> [Int]
desdeHasta x y = if(x > y)
						then [x .. y]
						else [y .. x]


--Recursividad: ** LE AGREGUE UN =, SINO NO INCLUYE EL ULTIMO NRO 
desdeHastaR :: Int -> Int -> [Int]
desdeHastaR num1 num2 = if(num1 >= num2)
						then []
						else num1 : desdeHastaR (num1 + 1) num2 

--X
--6
takeN :: Int -> [a] -> [a]
--takeN 0 xs = ...
--takeN y (x: xs) = ... takeN ...
takeN 0 xs = []
takeN y (x : xs) = if(y > longitud(x : xs) && y > 1)
			then x : takeN (y - 1) xs
			else xs


--7
-- dropN :: Int -> [a] -> [a]

--Numeros

uno = 1
dos = 2
tres = 3
cuatro = 4
cinco = 5

--Operaciones

mult x y = x*y
div x y = x/y
sum x y = x+y
res x y = x-y

--Operaciones varias

prom2 x y = (x+y)/2
prom3 x y z = (x+y+z)/3




--Saludos

hola = "Hola chabon"
chau = "Chau capo"
comoestas = "Bien vos?"


aplanar :: [[a]] -> [a]
--aplanar [] = []
--aplanar (x:xs) = x:xs : aplanar xs ++ aplanar xs
aplanar [] = []
aplanar (x:xs) = x ++ aplanar xs

reversa :: [a] -> [a]
reversa [] = []
reversa (xs) = last xs : reversa (init(xs))

zipMaximos :: [Int] -> [Int] -> [Int]
zipMaximos [] [] = [] 
--zipMaximos [xs] [] = append  -- SEGUIR!!!
--zipMaximos [] [ys] = head(ys) : zipMaximos ys []
zipMaximos (x:xs) (y:ys) = 
			if x >= y
				then x : zipMaximos xs ys
				else y : zipMaximos xs ys
		
len :: [Int] -> Int		
-- len [] = 
-- len (x:xs) =          len xs
len [] = 0
len (x:xs) = 1 + len xs

sumatoria :: [Int] -> Int
-- sumatoria [] = 
-- sumatoria (x:xs) =          sumatoria xs
sumatoria [] = 0
sumatoria (x:xs) = x + sumatoria xs

--sumPromedios :: fromIntegral [[Int]] -> [Int]
--sumPromedios [[]] = 
--sumPromedios (x:xs) =         sumPromedios xs
--sumPromedios [[]] = []
--sumPromedios (x:xs) = fromIntegral sumatoria x / fromIntegral len x : sumPromedios xs
--sumPromedios (x:xs) = media x : sumPromedios xs

aprobados :: [Int] -> [Int]
aprobados [] = []
--aprobados (x:xs) =      xs
aprobados (x:xs) = 
				if x>=7
				then x : aprobados xs
				else aprobados xs






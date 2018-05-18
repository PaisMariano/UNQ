--Auxiliares

positivos :: [Int] -> [Int]
positivos [] = []
positivos (x:xs) = 
				if x >= 0 
					then x : positivos xs
					else positivos xs

negativos :: [Int] -> [Int]
negativos [] = []
negativos (x:xs) = 
				if x < 0 
					then x : negativos xs
					else negativos xs
					
esPar :: Int -> Bool
esPar x = if (mod x 2 == 0)
			then True
			else False
			
listaPar :: [Int] -> [Int]
listaPar [] = []
listaPar (x:xs) = if esPar x 
					then x : listaPar xs
					else listaPar xs

listaImpar :: [Int] -> [Int]
listaImpar [] = []
listaImpar (x:xs) = if esPar x 
					then listaImpar xs
					else x : listaImpar	xs

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

promedio :: [Int] -> Float
promedio [] = 0
promedio (x:xs) = fromIntegral (x + sumatoria xs) / fromIntegral (1 + len xs)

-- promedio xs = div (sumatoria xs) (len xs)

--promedio xs = fromIntegral (sumatoria xs) / fromIntegral (len xs)


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

algunaVerdad :: [Bool] -> Bool
algunaVerdad [] = False
algunaVerdad (x:xs) = x || algunaVerdad(xs)

pertenece :: Eq a => a -> [a] -> Bool
pertenece a [] = False
pertenece a (x:xs) =
		if x == a
			then True
			else pertenece a (xs)
			
-- e == x || pertenece a xs
			
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
aplanar (xs:xss) = xs ++ aplanar xss

reversa :: [a] -> [a]
--reversa [] = 
--reversa (x:xs) =           reversa xs
reversa [] = []
reversa (x:xs) = reversa xs ++ [x]
--reversa (xs) = last xs : reversa (init(xs))

zipMaximos :: [Int] -> [Int] -> [Int]
zipMaximos [] [] = [] 
zipMaximos (x:xs) [] = xs 
zipMaximos [] (x:ys) = ys
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
contarHasta x = contarHasta (x-1) ++ [x]

replicarN :: Int -> a -> [a]
-- replicarN 0 0 = 
-- replicarN x y =       replicarN x + 1
replicarN 0 a = []
replicarN x y = y : replicarN (x-1) y

desdeHasta :: Int -> Int -> [Int]
--desdeHasta 0 0 = 
--desdeHasta x y =         desdeHasta x y
desdeHasta 0 y = []
desdeHasta x y =
				if x > y 
					then desdeHasta 0 y
					else x : desdeHasta (x+1) y

takeN :: Int -> [a] -> [a]
-- takeN 0 y = []
-- takeN x ydro =              takeN x y
takeN 0 y = []
takeN x []  = []
takeN x (y:ys) = y : takeN (x-1) ys

dropN :: Int -> [a] -> [a]
--dropN 0 [] =
--dropN x ys =              dropN x ys
dropN 0 ys = ys
dropN x []     = []
dropN x (y:ys) = dropN (x-1) ys

splitN :: Int -> [a] -> ([a], [a])
-- splitN 0 ys = 
-- splitN x ys =             split x ys
splitN  0 [] = ([], [])
splitN 0 xs = (takeN 0 xs , dropN 0 xs)
splitN x [] = (takeN x [] , dropN x [])
splitN x xs = (takeN x xs , dropN x xs)

--Anexo

particionPorSigno :: [Int] -> ([Int], [Int])

-- particionPorSigno [] = 
-- particionPorSigno xs =             particionPorSigno xs

particionPorSigno [] = ([],[])
particionPorSigno (xs) = (positivos xs, negativos xs)
							
particionPorParidad :: [Int] -> ([Int], [Int])
particionPorParidad [] = ([],[])
particionPorParidad (xs) = (listaPar xs, listaImpar xs)

subtails :: [a] -> [[a]]
subtails [] = []
subtails xs = xs : subtails (tail(xs))

--agrupar :: Eq a => [a] -> [[a]]
--agrupar [x] = []
--agrupar (x:xs) = 
--			if x == head(tail(xs))
--				then x : agrupar xs
--				else agrupar xs

--agregar :: [a] -> [[a]]
--agregar (xs) = xs : [tail(xs)]

esPrefijo :: Eq a => [a] -> [a] -> Bool 
esPrefijo [] ys = True
esPrefijo xs [] = False
esPrefijo [] [] = True
esPrefijo (x:xs) (y:ys) = if x == y
							then esPrefijo xs ys
							else False

esSufijo :: Eq a => [a] -> [a] -> Bool
esSufijo [] ys = True
esSufijo xs [] = False
esSufijo (xs) (ys) = if len xs < len ys
							then esSufijo xs (tail(ys))
							else esPrefijo xs ys

--PRACTICA 2



--1)
data Dir = Norte | Sur | Este | Oeste deriving (Eq, Show)

opuesto :: Dir -> Dir
opuesto Norte = Sur
opuesto Sur = Norte
opuesto Este = Oeste
opuesto Oeste = Este

siguiente :: Dir -> Dir
siguiente Norte = Oeste
siguiente Oeste = Sur
siguiente Sur = Este
siguiente Este = Norte

--2)
data Persona = Persona String Int deriving (Eq, Show)

nombre :: Persona -> String
nombre (Persona nombre _) = nombre

edad :: Persona -> Int
edad (Persona _ e) = e

crecer :: Persona -> Persona
crecer (Persona s i) = Persona s (i+1)

cambioDeNombre :: String -> Persona -> Persona
cambioDeNombre nn (Persona s i) = Persona nn i

esMenorQueLaOtra :: Persona -> Persona -> Bool
esMenorQueLaOtra (Persona s1 i1) (Persona s2 i2) = 
						if i1 < i2 
							then True
							else False

mayoresA :: Int -> [Persona] -> [Persona]
mayoresA i [] = []
mayoresA i (x:xs) = if i < (edad x) 
						then x : mayoresA i xs
						else mayoresA i xs
						
--promedioEdad :: [Persona] -> Int
--promedioEdad [x] = edad x
--promedioEdad xs = fromIntegral (sumarEdad xs) / fromIntegral (len xs)

sumarEdad :: [Persona] -> Int
sumarEdad [] = 0
sumarEdad (x:xs) = edad x + sumarEdad xs

elMasViejo :: [Persona] -> Persona
elMasViejo [x] = x
elMasViejo xs = calcMax xs

calcMax :: [Persona] -> Persona
calcMax [] = error "No puede ser vacia"
calcMax [x] = x
calcMax (x:xs) = if edad x > edad (head xs)
					then calcMax (x: tail(xs))
					else calcMax xs

--3)
data Pokemon = Pokemon TipoPokemon Int deriving (Eq, Show)
data Entrenador = Entrenador String [Pokemon] deriving (Eq, Show)
data TipoPokemon = Agua | Fuego | Planta deriving (Eq, Show)

elementoGanador :: TipoPokemon -> TipoPokemon
elementoGanador Agua = Planta
elementoGanador Planta = Fuego
elementoGanador Fuego = Agua

leGanaA :: Pokemon -> Pokemon -> Bool
leGanaA (Pokemon t1 i1) (Pokemon t2 i2) = if t1 == elementoGanador t2
												then True
												else False
capturarPokemon :: Pokemon -> Entrenador -> Entrenador
capturarPokemon (Pokemon t i) (Entrenador s ps) = Entrenador s ((Pokemon t i) : ps)

cantidadDePokemons :: Entrenador -> Int
cantidadDePokemons (Entrenador s ps) = len ps

lePuedeGanar :: Entrenador -> Pokemon -> Bool
lePuedeGanar (Entrenador s ps) (Pokemon t i) = leGanaALista ps (Pokemon t i)

leGanaALista :: [Pokemon] -> Pokemon -> Bool
leGanaALista [] (Pokemon t i) = False
leGanaALista (p:ps) (Pokemon t i) = if leGanaA p (Pokemon t i)
										then True
										else leGanaALista ps (Pokemon t i)

cantidadDePokemonDeTipo :: TipoPokemon -> Entrenador -> Int
cantidadDePokemonDeTipo t (Entrenador s ps) = contFiltTipoPok t ps

contFiltTipoPok :: TipoPokemon -> [Pokemon] -> Int
contFiltTipoPok t (p:ps) = if t == tipoPok p
								then 1 + contFiltTipoPok t ps
								else contFiltTipoPok t ps

tipoPok :: Pokemon -> TipoPokemon
tipoPok (Pokemon t i) = t

puedenPelear :: TipoPokemon -> Entrenador -> Entrenador -> Bool
puedenPelear t (Entrenador s1 ps1) (Entrenador s2 ps2) = aptoPelea t ps1 && aptoPelea t ps2

aptoPelea :: TipoPokemon -> [Pokemon] -> Bool
aptoPelea t [] = False
aptoPelea t (p:ps) = if t == tipoPok p && energiaPok p > 0
						then True
						else aptoPelea t ps

energiaPok :: Pokemon -> Int
energiaPok (Pokemon t i ) = i
						
esExperto :: Entrenador -> Bool
esExperto (Entrenador s ps) =  tieneFuego ps && tieneAgua ps && tienePlanta ps

tienePlanta :: [Pokemon] -> Bool
tienePlanta [] = False
tienePlanta (p:ps) = if tipoPok p == Planta 
						then True
						else tienePlanta ps

tieneAgua :: [Pokemon] -> Bool
tieneAgua [] = False
tieneAgua (p:ps) = if tipoPok p == Agua
						then True
						else tieneAgua ps

tieneFuego :: [Pokemon] -> Bool
tieneFuego [] = False
tieneFuego (p:ps) = if tipoPok p == Fuego
						then True
						else tieneFuego ps

fiestaPokemon :: [Entrenador] -> [Pokemon]
fiestaPokemon [] = []
fiestaPokemon (e:es) = listaPokemon e ++ fiestaPokemon es

listaPokemon :: Entrenador -> [Pokemon]
listaPokemon (Entrenador s []) = []
listaPokemon (Entrenador s ps) = ps


--Ejercicios CLASE 02-09-2017


data Pizza = Prepizza | Agregar Ingrediente Pizza deriving (Eq, Show)
data Ingrediente = Salsa | Queso | AceitunasVerdes Int | Jamon deriving (Eq , Show)

-- Pizza				  

ingredientes :: Pizza -> [Ingrediente]
ingredientes Prepizza = []
ingredientes (Agregar i p) = i : ingredientes p

duplicarAceitunas :: Pizza -> Pizza
duplicarAceitunas Prepizza = Prepizza
duplicarAceitunas (Agregar ing ps) = Agregar (dupAceituna ing) (duplicarAceitunas ps)

dupAceituna :: Ingrediente -> Ingrediente
dupAceituna i = if esAceituna i 
					then dobleAcei i
					else i
					
dobleAcei :: Ingrediente -> Ingrediente
dobleAcei (AceitunasVerdes n) = AceitunasVerdes (n*2)

esAceituna :: Ingrediente -> Bool
esAceituna (AceitunasVerdes n) = True
esAceituna x = False

tieneJamon :: Pizza -> Bool
tieneJamon Prepizza = False
tieneJamon (Agregar ing ps) = esJamon ing || tieneJamon ps

esJamon :: Ingrediente -> Bool
esJamon Jamon = True
esJamon x = False

sacarJamon :: Pizza -> Pizza
sacarJamon Prepizza = Prepizza
sacarJamon (Agregar i p) = if esJamon i
								then sacarJamon p
								else Agregar i (sacarJamon p)

armarPizza :: [Ingrediente] -> Pizza
armarPizza [] = Prepizza
armarPizza (x:xs) = Agregar (x) (armarPizza xs)

quesos :: [Pizza] -> [Ingrediente]
quesos [] = []
quesos (x:xs) = if esQueso (ingrediente x)
				then ingrediente x : quesos xs
				else quesos xs

ingrediente :: Pizza -> Ingrediente
ingrediente Prepizza = error "No puede tomar una pizza sin ingredientes"
ingrediente (Agregar i p) = i
				
esQueso :: Ingrediente -> Bool
esQueso Queso = True
esQueso x = False

sacarIngrediente :: Pizza -> Ingrediente -> Pizza
sacarIngrediente Prepizza i = Prepizza
sacarIngrediente (Agregar i p) ing = 
									if ing == ingrediente (Agregar i p)
										then Agregar ing (sacarIngrediente p ing)
										else sacarIngrediente p ing

cantJamon :: [Pizza] -> [(Int, Pizza)]
cantJamon [] = []
cantJamon (p:ps) = (cantidadJamon p , p) : cantJamon ps

cantidadJamon :: Pizza -> Int
cantidadJamon Prepizza = 0
cantidadJamon (Agregar ing p) = if esJamon ing 
									then 1 + cantidadJamon p
									else cantidadJamon p

--PRACTICA 3

data Tree a = EmptyT | NodeT a (Tree a) (Tree a) deriving (Eq, Show)

--8
contarLeaves :: Tree a -> Int
contarLeaves EmptyT = 0
contarLeaves (NodeT a EmptyT EmptyT) = 1
contarLeaves (NodeT a t1 t2) = contarLeaves t1 + contarLeaves t2

--9
leaves :: Tree a -> [a]
leaves EmptyT = []
leaves (NodeT a EmptyT EmptyT) = [a]
leaves (NodeT a t1 t2) = leaves t1 ++ leaves t2

--10
heightT :: Tree a -> Int
heightT EmptyT = 0
heightT (NodeT a EmptyT EmptyT) = 1
heightT (NodeT a t1 t2) = 
		
		if (heightT t1) >= (heightT t2)
			then 1 + heightT t1
			else 1 + heightT t2

--11			
contarNoHojas :: Tree a -> Int
contarNoHojas EmptyT = 0
contarNoHojas (NodeT a EmptyT EmptyT) = 0
contarNoHojas (NodeT a t1 t2) = 1 + contarNoHojas t1 + contarNoHojas t2

--12

espejoT :: Tree a -> Tree a
espejoT EmptyT = EmptyT 
espejoT (NodeT a t1 t2) = NodeT a (espejoT t2) (espejoT t1)
			
--13

listInOrder :: Tree a -> [a]
listInOrder EmptyT = []
listInOrder (NodeT a t1 t2) = listInOrder t1 ++ [a] ++ listInOrder t2

--14

listPreOrder :: Tree a -> [a]
listPreOrder EmptyT = []
listPreOrder (NodeT a t1 t2) = [a] ++ listPreOrder t1 ++ listPreOrder t2

--15

listPostOrder :: Tree a -> [a]
listPostOrder EmptyT = []
listPostOrder (NodeT a t1 t2) = listPostOrder t1 ++ listPostOrder t2 ++ [a]

--16

concatenarListasT :: Tree [a] -> [a]
concatenarListasT EmptyT = []
concatenarListasT (NodeT a t1 t2) = concatenarListasT t1 ++ a ++ concatenarListasT t2

--17

levelN :: Int -> Tree a -> [a]
levelN i EmptyT = []
levelN i (NodeT a t1 t2) = if i == 0 
								then [a]
								else levelN (i-1) t1 ++ levelN (i-1) t2


--18

listPerLevel :: Tree a -> [[a]]
listPerLevel t = listarNiveles ((heightT t)-1) t


listarNiveles :: Int -> Tree a -> [[a]]
listarNiveles 0 t = [levelN 0 t]
listarNiveles i t = levelN i t : (listarNiveles (i-1) t)
							
							
-- [[1], [2,3] , [4,5,6,7]]

--19

widthtT :: Tree a -> Int
widthtT EmptyT = 0
widthT t = calcMaxT(listPerLevel t)

calcMaxT :: [[a]] -> Int
calcMaxT [] = 0
calcMaxT (xs:xss) = max (length(xs)) (calcMaxT(xss))


--(NodeT 1 (NodeT 2(NodeT 4 (NodeT 8 EmptyT EmptyT) EmptyT) (NodeT 5 EmptyT EmptyT)) (NodeT 3(NodeT 6 EmptyT EmptyT) (NodeT 7 EmptyT EmptyT)))
--       1
--      / \
--     2   3
--    / \ / \
--   4  5 6  7
--  /
-- 8
	
todosLosCaminos :: Tree a -> [[a]]
todosLosCaminos EmptyT                 = [[]]
todosLosCaminos (NodeT a EmptyT EmptyT) = [[a]]
todosLosCaminos (NodeT a t1 t2) = [a] : todosLosCaminos t1 ++ [a] : todosLosCaminos t2

--Mapa de Tesoros

data Dir1 = Izq | Der deriving (Eq, Show)
data Objeto = Tesoro | Chatarra deriving (Eq, Show)
data Mapa = Cofre Objeto | Bifurcacion Objeto Mapa Mapa deriving (Eq, Show)

hayTesoro :: Mapa -> Bool
hayTesoro (Cofre Tesoro)   = True
hayTesoro (Cofre Chatarra) = False
hayTesoro (Bifurcacion a m1 m2) = if esTesoro a
										then True
										else hayTesoro m1 || hayTesoro m2

esTesoro :: Objeto -> Bool
esTesoro Tesoro = True
esTesoro x      = False

hayTesoroEn :: [Dir1] -> Mapa -> Bool
hayTesoroEn [] m = tenesTesoro m
hayTesoroEn (x:xs) m = if esBifur m 
							then if esDerecha x
									then hayTesoroEn xs (ladoIzq m)
									else hayTesoroEn xs (ladoDer m)
							
							else error "No deberia ser un cofre"
	
esBifur :: Mapa -> Bool
esBifur (Bifurcacion o t1 t2) = True
esBifur (Cofre o)             = False
	
esDerecha :: Dir1 -> Bool
esDerecha Der = True
esDerecha x   = False 
	
tenesTesoro :: Mapa -> Bool
tenesTesoro (Cofre Tesoro) = True
tenesTesoro (Cofre x) = False
tenesTesoro (Bifurcacion Tesoro t1 t2) = True
tenesTesoro (Bifurcacion x t1 t2) = False
	
ladoDer :: Mapa -> Mapa
ladoDer (Bifurcacion o t1 t2) = t2
ladoDer (Cofre o)             = error "No deberia ser un cofre"

ladoIzq :: Mapa -> Mapa
ladoIzq (Bifurcacion o t1 t2) = t1
ladoIzq (Cofre o)             = error "No deberia ser un cofre" 
	

	
	

	

	
--3 

recolectorTesoros :: [Dir1] -> Mapa -> [Objeto]
recolectorTesoros [] m = if tenesTesoro m 
							then dameTesoro m : []
							else []
recolectorTesoros (x:xs) m = if esBifur m
								then if esDerecha x
										then if tenesTesoro m
												then dameTesoro m : recolectorTesoros xs (ladoDer m)
												else recolectorTesoros xs (ladoDer m)
										else if tenesTesoro m
												then dameTesoro m : recolectorTesoros xs (ladoIzq m)
												else recolectorTesoros xs (ladoIzq m)
								else error "Deberia ser una Bifurcacion"

dameTesoro :: Mapa -> Objeto
dameTesoro (Cofre x) = x
dameTesoro (Bifurcacion x t1 t2) = x	

--Parcial 1 2016

data Arbol a = Vacio | Nodo a (Arbol a) (Arbol a) deriving (Eq, Ord, Show)
data Dir2 = Izq1 | Der1 deriving (Eq, Show)
data Celda = ConsCelda Int Int deriving (Eq, Ord, Show)

celdaConMasRojas :: Arbol Celda -> Celda
celdaConMasRojas Vacio = ConsCelda 0 0
celdaConMasRojas (Nodo a t1 t2) = mayorCeldaBolitasR a (celdaConMasRojas t1) (celdaConMasRojas t2)

mayorCeldaBolitasR :: Celda -> Celda -> Celda -> Celda
mayorCeldaBolitasR a t1 t2 = if contarBolitasR a > contarBolitasR t1 
								then if contarBolitasR a > contarBolitasR t2
										then a
										else t2
								else if contarBolitasR t1 > contarBolitasR t2
										then t1 
										else t2

contarBolitasR :: Celda -> Int
contarBolitasR (ConsCelda x y) = y

esDerechaCelda :: Dir2 -> Bool
esDerechaCelda Der1 = True
esDerechaCelda x   = False 

vaciarCeldas :: [[Dir2]] -> Arbol Celda -> Arbol Celda
vaciarCeldas [] a = a
vaciarCeldas (x:xs) t = vaciarCeldas xs (vaciador x t)

vaciador :: [Dir2] -> Arbol Celda -> Arbol Celda
vaciador [] Vacio = Vacio
vaciador [] (Nodo a t1 t2) = Vacio
vaciador (x:xs) (Nodo a t1 t2) = if esDerechaCelda x
									then Nodo a t1 (vaciador xs t2)
									else Nodo a (vaciador xs t1) t2
									
caminoMasLargo :: Arbol Celda -> [Dir2]
caminoMasLargo Vacio = []
caminoMasLargo (Nodo a Vacio Vacio) = []
caminoMasLargo (Nodo a t1 t2) = if heightTC t1 > heightTC t2 
									then Izq1 : caminoMasLargo t1
									else Der1 : caminoMasLargo t2

heightTC :: Arbol Celda -> Int
heightTC Vacio = 0
heightTC (Nodo a Vacio Vacio) = 1
heightTC (Nodo a t1 t2) = 
		
		if (heightTC t1) >= (heightTC t2)
			then 1 + heightTC t1
			else 1 + heightTC t2
							
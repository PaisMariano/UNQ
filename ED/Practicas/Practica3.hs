data Tree a = EmptyT | NodeT a (Tree a) (Tree a)

sumarT :: Tree Int -> Int
sumarT EmptyT          = 0
sumarT (NodeT n t1 t2) = n + sumarT t1 + sumarT t2

sizeT :: Tree a -> Int
sizeT EmptyT          = 0
sizeT (NodeT n t1 t2) = 1 + sizeT t1 + sizeT t2

mapDobleT :: Tree Int -> Tree Int
mapDobleT EmptyT          = EmptyT  
mapDobleT (NodeT n t1 t2) = NodeT (n*2) (mapDobleT t1) (mapDobleT t2)

mapLongitudT :: Tree String -> Tree Int
mapLongitudT EmptyT          = EmptyT
mapLongitudT (NodeT s t1 t2) = NodeT (length s) (mapLongitudT t1) (mapLongitudT t2)

esIgual :: Eq a => a -> a -> Bool
esIgual a b = a == b

perteneceT :: Eq a => a -> Tree a -> Bool
perteneceT n1 EmptyT           = False
perteneceT n1 (NodeT n2 t1 t2) = esIgual n1 n2 || perteneceT n1 t1 || perteneceT n1 t2

aparicionesT :: Eq a => a -> Tree a -> Int
aparicionesT n1 EmptyT           = 0
aparicionesT n1 (NodeT n2 t1 t2) = if esIgual n1 n2 
					then 1 + aparicionesT n1 t1
					else aparicionesT n1 t2

data Persona = P String Int deriving (Eq, Show)

edad :: Persona -> Int
edad (P s i) = i

--promedioEdadesT :: Tree Persona -> Int
--promedioEdadesT t = totEdades t / fromIntegral (sizeT t)

totEdades :: Tree Persona -> Int
totEdades EmptyT          = 0
totEdades (NodeT n t1 t2) = edad n + totEdades t1 + totEdades t2

contarLeaves :: Tree a -> Int
contarLeaves EmptyT          = 0
contarLeaves (NodeT n t1 t2) = if esEmptyT t1 && esEmptyT t2 
				then 1
				else contarLeaves t1 + contarLeaves t2

esEmptyT :: Tree a -> Bool
esEmptyT EmptyT = True
esEmptyT _      = False

leaves :: Tree a -> [a]
leaves EmptyT          = []
leaves (NodeT n t1 t2) = if esEmptyT t1 && esEmptyT t2
				then [n]
				else leaves t1 ++ leaves t2

esLeave :: Tree a -> Bool
esLeave (NodeT n EmptyT EmptyT) = True
esLeave _                       = False

heightT :: Tree a -> Int
heightT EmptyT          = 0  
heightT (NodeT n t1 t2) = 1 + max (heightT t1) (heightT t2)

contarNoHojas :: Tree a -> Int
contarNoHojas EmptyT          = 0
contarNoHojas (NodeT n t1 t2) = if not (esEmptyT t1 && esEmptyT t2)
					then 1 + contarNoHojas t1 + contarNoHojas t2
					else contarNoHojas t1 + contarNoHojas t2

espejoT :: Tree a -> Tree a
espejoT EmptyT                = EmptyT 
espejoT (NodeT n t1 t2)       = NodeT n (espejoT t2) (espejoT t1)

listInOrder :: Tree a -> [a]
listInOrder EmptyT            = []
listInOrder (NodeT n t1 t2)   = listInOrder t1 ++ [n] ++ listInOrder t2

listPreOrder :: Tree a -> [a]
listPreOrder EmptyT          = []
listPreOrder (NodeT n t1 t2) = [n] ++ listPreOrder t1 ++ listPreOrder t2

listPosOrder :: Tree a -> [a]
listPosOrder EmptyT          = []
listPosOrder (NodeT n t1 t2) = listPosOrder t1 ++ listPosOrder t2 ++ [n]

concatenarListasT :: Tree [a] -> [a]
concatenarListasT EmptyT          = []
concatenarListasT (NodeT n t1 t2) = concatenarListasT t1 ++ n ++ concatenarListasT t2

levelN :: Int -> Tree a -> [a]
levelN n EmptyT           = []
levelN n (NodeT n1 t1 t2) = if n == 0
				then [n1] 
				else levelN (n-1) t1 ++ levelN (n-1) t2

listPerLevel :: Tree a -> [[a]]
listPerLevel t  = listarNiveles ((heightT t)-1) t

value :: Tree a -> a
value EmptyT          = error "No tiene valor"
value (NodeT n t1 t2) = n

listarNiveles :: Int -> Tree a -> [[a]]
listarNiveles 0 t = [[value t]]
listarNiveles n t = [levelN n t] ++ listarNiveles (n-1) t
 
widthT :: Tree a -> Int
widthT t = maxList (listPerLevel t)

maxList :: [[a]] -> Int
maxList []     = 0 
maxList (x:xs) = max (longitud x) (maxList xs)

longitud :: [a] -> Int
longitud []     = 0
longitud (x:xs) = 1 + longitud xs

ramaDerecha :: Tree a -> [a]
ramaDerecha EmptyT          = []
ramaDerecha (NodeT n t1 t2) = if not (esEmptyT t2)
				then ramaDerecha t1 ++ [value t2] ++ ramaDerecha t2
				else ramaDerecha t1 ++ ramaDerecha t2

ramaMasLarga :: Tree a -> [a]
ramaMasLarga EmptyT          = []
ramaMasLarga (NodeT n t1 t2) = if heightT t1 > heightT t2
					then n : ramaMasLarga t1
					else n : ramaMasLarga t2

{-
22. todosLosCaminos :: Tree a -> [[a]]
Dado un árbol devuelve todos los caminos, es decir, los caminos desde la raiz hasta las hojas.
Página 2 de 4Estructuras de datos - UNQ
-}

--2.
--Mapa de tesoros

data Dir = Izq | Der
data Objeto = Tesoro | Chatarra
data Mapa = Cofre Objeto | Bifurcacion Objeto Mapa Mapa

hayTesoro :: Mapa -> Bool
hayTesoro (Cofre o)             = esTesoro o
hayTesoro (Bifurcacion o m1 m2) = esTesoro o || hayTesoro m1 || hayTesoro m2

esTesoro :: Objeto -> Bool
esTesoro Tesoro = True
esTesoro _      = False

hayTesoroEn :: [Dir] -> Mapa -> Bool
hayTesoroEn [] m1     = esTesoro (objeto m1)
hayTesoroEn (x:xs) m1 = if esIzq x
				then hayTesoroEn xs (ladoIzq m1)
				else hayTesoroEn xs (ladoDer m1)

esIzq :: Dir -> Bool
esIzq Izq = True
esIzq _   = False

objeto :: Mapa -> Objeto
objeto (Cofre o)             = o
objeto (Bifurcacion o m1 m2) = o

ladoIzq :: Mapa -> Mapa
ladoIzq (Cofre o)             = error "No tiene bifurcación!!!!" 
ladoIzq (Bifurcacion o m1 m2) = m1

ladoDer :: Mapa -> Mapa
ladoDer (Cofre o)             = error "No tiene bifurcación!!!!" 
ladoDer (Bifurcacion o m1 m2) = m2

caminoAlTesoro :: Mapa -> [Dir]
caminoAlTesoro (Cofre o)             = []
caminoAlTesoro (Bifurcacion o m1 m2) = if esTesoro o
					then []
					else if hayTesoro m1 
						then Izq : caminoAlTesoro m1
						else Der : caminoAlTesoro m2


caminoRamaMasLarga :: Mapa -> [Dir]
caminoRamaMasLarga (Cofre o)             = []
caminoRamaMasLarga (Bifurcacion o m1 m2) = if heightT m1 > heightT m2
						then Izq : caminoRamaMasLarga m1
						else Der : caminoRamaMasLarga m2


tesorosPerLevel :: Mapa -> [[Objeto]]
tesorosPerLevel m1 = listarNiveles (heightT m1) m1 

--todosLosCaminos :: Mapa -> [[Dir]]

--Anexo con ejercicios adicionales
--3.
Expresiones aritméticas
Sea el tipo Exp, modelando expresiones aritméticas:

data Exp = Constante Int | ConsExpUnaria OpUnaria Exp | ConsExpBinaria OpBinaria Exp Exp
data OpUnaria = Neg
data OpBinaria = Suma | Resta | Mult | Div

eval :: Exp -> Int
eval (Constante i)              = i
eval (ConsExpUnaria opu e)      = 
eval (ConsExpBinaria opb e1 e2) =

Dada una expresión evalúe esta expresión y retorne su valor. ¿Qué casos hacen que eval sea
una función parcial?
2. simplificar :: Exp -> Exp
Dada una expresión la simplifica según los siguientes criterios:
a) 0 + x = x + 0 = x
b) x − 0 = x
c) 0 − x = −x
d ) x × 1 = 1 × x = x
e) x × 0 = 0 × x = 0
f ) x ÷ 1 = x
g) 0 ÷ x = 0, x 6 = 0

-}

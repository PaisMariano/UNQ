data ExpA = Cte Int | Sum ExpA ExpA | Prod ExpA ExpA deriving (Eq, Show)

{-

f :: ExpA -> b
f (Cte n) = ... n ...
f (Suma e1 e2) = ... f e1 ... f e2
f (Prod e1 e2) = ... f e1 ... f e2

-}

foldExpA :: (Int -> b) -> (b -> b -> b) -> (b -> b -> b) -> ExpA -> b
foldExpA c s p (Cte n)      = c n
foldExpA c s p (Sum e1 e2) = s (foldExpA c s p e1) (foldExpA c s p e2)
foldExpA c s p (Prod e1 e2) = p (foldExpA c s p e1) (foldExpA c s p e2)

cantidadDeCeros :: ExpA -> Int
cantidadDeCeros e = foldExpA sumaSiEsCero sumar sumar e

sumaSiEsCero :: Int -> Int
sumaSiEsCero 0 = 1
sumaSiEsCero _ = 0

sumar :: Int -> Int -> Int
sumar = (+)

noTieneNegativosExplicitosExpA :: ExpA -> Bool
noTieneNegativosExplicitosExpA e = foldExpA noEsNegativo devolverNeutro devolverNeutro e

noEsNegativo :: Int -> Bool
noEsNegativo n = n >= 0

devolverNeutro :: Bool -> Bool -> Bool
devolverNeutro n1 n2 = n1 && n2

simplificarExpA' :: ExpA -> ExpA
simplificarExpA' e = foldExpA Cte simpliSuma simpliProd e

simpliSuma :: ExpA -> ExpA -> ExpA
simpliSuma e1 e2 = if e1 == Cte 0 then e2
                                 else Sum e1 e2

simpliProd :: ExpA -> ExpA -> ExpA
simpliProd e1 e2 = if e1 == Cte 1 then e2 
                                 else Prod e1 e2

evalExpA' :: ExpA -> Int
evalExpA' e = foldExpA evalCte sumar mult e

evalCte :: Int -> Int
evalCte n = n

mult :: Int -> Int -> Int
mult = (*)

showExpA :: ExpA -> String
showExpA e  = foldExpA cteToString sumToString mulToString e

cteToString :: Int -> String
cteToString n = "Cte(" ++ (show n) ++ ")"

sumToString :: String -> String -> String
sumToString e1 e2 = "Sum(" ++ e1 ++ ")" ++ "(" ++ e2 ++ ")"

mulToString :: String -> String -> String
mulToString e1 e2 = "Prod(" ++ e1 ++ ")" ++ "(" ++ e2 ++ ")"


{-
¿ evalExpA' = EvalExpA ?
Aplico principio de extensionalidad
evalExpA' expA1 = evalExpA expA1
DEM : Por ppio. de induccion en la estructura de expA1
CASO BASE: Cte n
    evalExpA' (Cte n) = evalExpA (Cte n)
def evalExpA' 1                         def evalExpA 1
    foldExpA EvalCte sumar mult (Cte n) = n
def foldExpA' 1                          
    EvalCte n
def EvalCte n
    n

CASO INDUCTIVO SUM: expA1 = (Sum e1 e2)

HI1) evalExpA' e1 = evalExpA e1
HI2) evalExpA' e2 = evalExpA e2
TI) evalExpA' (Sum e1 e2) = evalExpA (Sum e1 e2)

    evalExpA' (Sum e1 e2)
def evalExpA'
    foldExpA evalCte sumar mult (Sum e1 e2)
def foldExpA 2
    sumar (foldExpA EvalCte sumar mult e1) (foldExpA EvalCte sumar mult e2)
def EvalExpA'
    sumar (evalExpA' e1) (evalExpA' e2)
HI 1 y HI 2
    sumar (evalExpA e1) (evalExpA e2)

    evalExpA (Sum e1 e2)
def evalExpA 2
  x  sumar (evalExpA e1) (evalExpA e2)


CASO INDUCTIVO MUL:
    IGUAL AL ANTERIOR
-}
-----------------------------------------------------------------------------------------------------
--2)

data EA = Const Int | BOp BinOp EA EA
data BinOp = Sum1 | Mul1
{-

f :: EA -> b
f (Const n) = ... n ...
f (BOp b e1 e2) = ... b ... f e1 ... f e2 ...

-}

foldEA :: (Int -> b) -> (BinOp -> b -> b -> b) -> EA -> b
foldEA c b (Const n)       = c n
foldEA c b (BOp bop e1 e2) = b bop (foldEA c b e1) (foldEA c b e2)

noTieneNegativosExplicitosEA :: EA -> Bool
noTieneNegativosExplicitosEA ea = foldEA (\x -> x < 0) (\bop ea1 ea2 -> (&&) ea1 ea2) ea

simplificarEA' :: EA -> EA
simplificarEA' ea = foldEA Const evalSimpliEA ea

evalSimpliEA :: BinOp -> EA -> EA -> EA
evalSimpliEA Sum1 (Const 0) e2 = e2
evalSimpliEA Sum1 e1 (Const 0) = e1
evalSimpliEA Sum1 e1 e2 = BOp Sum1 e1 e2
evalSimpliEA Mul1 (Const 1) e2 = e2
evalSimpliEA Mul1 e1 (Const 1) = e1
evalSimpliEA Mul1 e1 e2 = BOp Mul1 e1 e2

evalEA' :: EA -> Int
evalEA' ea = foldEA id calcEA ea

calcEA :: BinOp -> Int -> Int -> Int
calcEA Sum1 x y = (+) x y
calcEA Mul1 x y = (*) x y

ea2ExpA' :: EA -> ExpA
ea2ExpA' ea = foldEA (\x -> Cte x) (\bop x y -> case bop of 
                                                        Sum1 -> Sum x y
                                                        Mul1 -> Prod x y) ea

ea2Arbol' :: EA -> Arbol BinOp Int
ea2Arbol' ea = foldEA (\x -> Raiz x) (\bop x y -> Nodo bop x y) ea

data Arbol a b = Raiz b | Nodo a (Arbol a b) (Arbol a b) deriving (Show)

{-

    evalEA' = evalEA
Por ppio de extensionalidad 
    evalEA' ea = evalEA ea
Dem por induccion en la estructura de ea
CASO BASE : ea = Const n
    evalEA' (Const n) = evalEA (Const n)
= def evalEA'
    foldEA id calcEA (Const n)
= def foldEA 1
    id n
= def n
    n

    evalEA (Const n)
= def evalEA 1
    n

CASO INDUCTIVO: ea = (BOp Sum1 ea1 ea2)
HI1) ¡ evalEA' ea1 = evalEA ea1 !
HI2) ¡ evalEA' ea2 = evalEA ea2 !
TI) ¿ evalEA' (BOp Sum1 ea1 ea2) = evalEA (BOp Sum ea1 ea2) ?

    evalEA' (BOp Sum1 ea1 ea2)
= def evalEA'
    foldEA id calcEA (BOp Sum1 ea1 ea2)
= def foldEA 2
    calcEA Sum1 (foldEA id ea1) (foldEA id ea2)
= def foldEA -> evalEA'
    calcEA Sum1 (evalEA' ea1) (evalEA' ea2)
= HI1 e HI2)
    calcEA Sum1 (evalEA ea1) (evalEA ea2)
= def calcEA
    (+) (evalEA ea1) (evalEA ea2)

    evalEA (BOp Sum ea1 ea2)
= def evalEA
    (+) (evalEA ea1) (evalEA ea2s)

-}

--Ejercicio 3)

data Tree a = EmptyT | NodeT a (Tree a) (Tree a) deriving (Show, Eq)

foldT :: b -> (a -> b -> b -> b) -> (Tree a) -> b
foldT z n EmptyT = z
foldT z n (NodeT x t1 t2) = n x (foldT z n t1) (foldT z n t2)

mapT :: (a -> b) -> Tree a -> Tree b
mapT f t = foldT EmptyT (devolverNodeTArbol.f) t

devolverNodeTArbol :: b -> Tree b -> Tree b -> Tree b
devolverNodeTArbol x t1 t2 = NodeT x t1 t2

rama :: Int -> String
rama n = show n

sumT :: Tree Int -> Int
sumT t = foldT 0 sumarT t

sumarT :: Int -> Int -> Int -> Int
sumarT n1 n2 n3 = n1 + n2 + n3

sizeT :: Tree a -> Int
sizeT t = foldT 0 contarT t

contarT :: a -> Int -> Int -> Int
contarT x n1 n2 = 1 + n1 + n2 

heightT :: Tree a -> Int
heightT t = foldT 0 calcularMaxT t

calcularMaxT :: a -> Int -> Int -> Int
calcularMaxT x n1 n2 = 1 + max n1 n2

preOrder :: Tree a -> [a]
preOrder t = foldT [] preOrdenarT t

preOrdenarT :: a -> [a] -> [a] -> [a]
preOrdenarT x l1 l2 = [x] ++ l1 ++ l2

inOrder :: Tree a -> [a]
inOrder t = foldT [] ordenarT t

ordenarT :: a -> [a] -> [a] -> [a]
ordenarT x l1 l2 = l1 ++ [x] ++ l2

postOrder :: Tree a -> [a]
postOrder t = foldT [] postOrdenarT t

postOrdenarT :: a -> [a] -> [a] -> [a]
postOrdenarT x l1 l2 = l1 ++ l2 ++ [x]

mirrorT :: Tree a -> Tree a
mirrorT t = foldT EmptyT espejoT t

espejoT :: a -> Tree a -> Tree a -> Tree a
espejoT x t1 t2 = NodeT x t2 t1

countByT :: (a -> Bool) -> Tree a -> Int
countByT f t = foldT 0 (contarTSi.f) t

contarCincoT :: Int -> Bool
contarCincoT 5 = True
contarCincoT _ = False

contarTSi :: Bool -> Int -> Int -> Int
contarTSi b n1 n2 = if b then 1 + n1 + n2
                         else n1 + n2

partitionT :: (a -> Bool) -> Tree a -> ([a], [a])
partitionT f t = foldT ([], []) (particionar f) t

particionar :: (a-> Bool) -> a -> ([a],[a]) -> ([a],[a]) -> ([a],[a])
particionar f x (xs1, ys1) (xs2, ys2) = if f x then (x:(xs1++xs2), ys1++ys2)
                                                else (xs1++xs2, (x:ys1++ys2))

--zipWithT :: (a->b->c) -> Tree a -> Tree b -> Tree c

caminoMasLargo :: Tree a -> [a]
caminoMasLargo t = foldT [] devolverMaxT t

devolverMaxT :: a -> [a] -> [a] -> [a]
devolverMaxT x xs ys = if length xs > length ys then (x:xs)
                                                else (x:ys)

todosLosCaminos :: Tree a -> [[a]]
todosLosCaminos t = foldT [[]] agregarseALasListasDeListas t

agregarseALasListasDeListas :: a -> [[a]] -> [[a]] -> [[a]]
agregarseALasListasDeListas x xss yss = (foldr (agregarXALasListas x) [] xss) ++ (foldr (agregarXALasListas x) [] yss)

agregarXALasListas :: a -> [a] -> [[a]] -> [[a]]
agregarXALasListas x xs xss     = (x:xs):xss

--todosLosNiveles :: Tree a -> [[a]]

--nivelN :: Tree a -> Int -> [a]

recT :: b -> ( a -> Tree a -> b -> Tree a -> b -> b) -> Tree a -> b
recT z f EmptyT = z
recT z f (NodeT x t1 t2) = f x t1 (recT z f t1) t2 (recT z f t2)

insertT :: Ord a => a -> Tree a -> Tree a
insertT x t = recT EmptyT (insertarAlArbol x) t

insertarAlArbol :: Ord a => a -> a -> Tree a -> Tree a -> Tree a -> Tree a -> Tree a
insertarAlArbol x y t1' t1 t2' t2 = if x < y then NodeT x t1' t2 
                                             else NodeT y t1 t2'

--caminoHasta :: Eq a => a -> Tree a -> [a]
--caminoHasta x t = recT EmptyT (buscarCamino x) t


{-
    sizeT . mapT f = sizeT
Aplico principio de extensionalidad
    sizeT . mapT f t = sizeT t
Dem por ppio de induccion sobre la estructura de t

CASO BASE:    
    sizeT . mapT f EmptyT = sizeT EmptyT
def (.)
    sizeT(mapT f EmptyT) 
def mapT 1
    sizeT(foldT EmptyT (devolverNodeTArbol.f) EmptyT)
def foldT 1
    sizeT(EmptyT)
def sizeT 1
    0
----------------------------------------
    sizeT(EmptyT)
def sizeT 1
    0

CASO INDUCTIVO: t = (NodeT x t1 t2)
HI1) ¡ sizeT . mapT f t1 = sizeT t1 !
HI2) ¡ sizeT . mapT f t2 = sizeT t2 !
TI)  ¿ sizeT . mapT f (NodeT x t1 t2) = sizeT (NodeT x t1 t2) ?

    sizeT . mapT f (NodeT x t1 t2) = sizeT (NodeT x t1 t2)
def (.)
    sizeT(mapT f (NodeT x t1 t2)) 
def mapT 2
    sizeT(foldT EmptyT (devolverNodeTArbol.f) (NodeT x t1 t2))
def foldT 2
    sizeT((devolverNodeTArbol.f) x (foldT EmptyT (devolverNodeTArbol.f) t1) (foldT EmptyT (devolverNodeTArbol.f) t2))
def map 2
    sizeT((devolverNodeTArbol.f) x (mapT f t1) (mapT f t2))
def devolverNodeTArbol
    sizeT(NodeT x (mapT f t1) (mapT f t2))
def sizeT 2
    foldT 0 contarT (NodeT x (mapT f t1) (mapT f t2))
def foldT 2
    contarT x (foldT 0 contarT (mapT f t1)) (foldT 0 contarT (mapT f t2))
def contarT
    1 + (foldT 0 contarT (mapT f t1)) + (foldT 0 contarT (mapT f t2))
def sizeT
    1 + (sizeT (mapT f t1)) + (sizeT (mapT f t2))
def (.)
    1 + (sizeT . mapT f t1) + (sizeT . mapT f t2)
HI 1 e HI 2
    1 + sizeT t1 + sizeT t2

-----------------------------------------------------

    sizeT (NodeT x t1 t2)
def sizeT
    foldT 0 contarT (NodeT x t1 t2)
def foldT 2
    contarT x (foldT 0 contarT t1) (foldT 0 contarT t2)
def contarT
    1 + foldT 0 contarT t1 + foldT 0 contarT t2
def foldT 2
    1 + sizeT t1 + sizeT t2


mapT f . mapT g = mapT (f . g)
foldT NodeT EmptyT = id

-}

--Ejercicio 6

data Dir = Left' | Right' | Straight' deriving (Show , Eq)
data Mapa a = Cofre [a] | Nada (Mapa a) | Bifurcacion [a] (Mapa a) (Mapa a)

foldM :: ([a] -> b) -> (b -> b) -> ([a] -> b -> b -> b) -> Mapa a -> b
foldM c n b (Cofre xs) = c xs
foldM c n b (Nada m) = n (foldM c n b m)
foldM c n b (Bifurcacion xs m1 m2) = b xs (foldM c n b m1) (foldM c n b m2)

recM ::([a] -> b) -> (Mapa a -> b -> b) -> ([a] -> Mapa a -> b -> Mapa a -> b -> b) -> Mapa a -> b
recM c n b (Cofre xs) = c xs
recM c n b (Nada m) = n m (recM c n b m)
recM c n b (Bifurcacion xs m1 m2) = b xs m1 (recM c n b m1) m2 (recM c n b m2) 

objects :: Mapa a -> [a]
objects m = foldM (\xs -> xs) (\xs -> []) (\xs ys zs -> xs ++ ys ++ zs ) m

mapM :: (a -> b) -> Mapa a -> Mapa b
mapM f m = foldM (Cofre.(map f)) Nada (Bifurcacion.(map f)) m

has :: (a -> Bool) -> Mapa a -> Bool
has f m = foldM (\xs -> foldr ((||).f) False xs) (\b -> b) (\xs b1 b2 -> (foldr ((||).f) False xs) || b1 || b2) m
-- has f = foldM (any f) id (\xs b1 b2 -> any f xs || b1 || b2)

hasObjectAt :: (a -> Bool) -> Mapa a -> [Dir] -> Bool
hasObjectAt p = foldM f g h
    where f xs [] = any p xs
          f xs _ = False
          g r (Straight':xs) = r xs
          g r _ = False
          h ts r1 r2 [] = any p ts
          h ts r1 r2 (Right':xs) = r2 xs
          h ts r1 r2 (Left':xs) = r1 xs
          h ts r1 r2 _ = False

longestPath :: Mapa a -> [Dir]
longestPath = foldM (\xs -> []) (\r -> Straight': r) (\xs r1 r2 -> if length r1 >= length r2 then (Left': r1)
                                                                                                else (Right': r2))

objectsOfLongestPath' :: Mapa a -> [a]
objectsOfLongestPath' m = (foldM f g h m) (longestPath m)
    where f xs [] = xs
          f xs _ = error "no deberia llegar nunca aca"
          g r (Straight':ys) = r ys
          g r _ = error "no deberia llegar nunca aca"
          h xs r1 r2 [] = xs
          h xs r1 r2 (y:ys) = if y == Left' then xs ++ r1 ys
                                            else xs ++ r2 ys

objectsOfLongestPath :: Mapa a -> [a]
objectsOfLongestPath = recM id (\m r -> r) (\xs m1 r1 m2 r2 -> if length r1 >= length r2 then objects m1 else objects m2)

allPaths :: Mapa a -> [[Dir]]
allPaths = foldM (\xs -> [[]]) (\r -> agregarATodas Straight' r) (\xs r1 r2 -> agregarATodas Left' r1 ++ agregarATodas Right' r2)

agregarATodas :: Dir -> [[Dir]] -> [[Dir]]
agregarATodas dir = foldr (addAll dir) []

addAll :: Dir -> [Dir] -> [[Dir]] -> [[Dir]]
addAll d xs xss = [d:xs] ++ xss

objectsPerLevel :: Mapa a -> [[a]]
objectsPerLevel = foldM (\xs -> [xs]) (\r -> [] : r) (\xs r1 r2 -> xs : juntar r1 r2)

juntar :: [[a]] -> [[a]] -> [[a]]
juntar [] [] = []
juntar (xs:xss) [] = xs : xss
juntar [] (ys:yss) = ys : yss
juntar (xs:xss) (ys:yss) = (xs ++ ys) : (juntar xss yss)

zipWith' :: (a -> b -> c) -> [a] -> [b] -> [c]
zipWith' h = foldr f g
    where f x r [] = []
          f x r (y:ys) = (:) (h x y) (r ys)
          g _ = []

(!!!) :: [a] -> (Int -> a)
(!!!) = foldr f g
    where f x r 0 = x
          f x r n = r (n-1)
          g n = error "No se encontro el elemento."

esCinco :: Int -> Bool
esCinco 5 = True
esCinco _ = False

any' :: (a -> Bool) -> [a] -> Bool
any' f xs = foldr ((||) . f) False xs

any'' :: (a -> Bool) -> [a] -> Bool
any'' f [] = False
any'' f (x:xs) = f x || (any'' f xs)

has' :: (a -> Bool) -> Mapa a -> Bool
has' f (Cofre xs) = any f xs
has' f (Nada m) = has f m
has' f (Bifurcacion xs m1 m2) = any f xs || has f m1 || has f m2

objectsPerLevel' :: Mapa a -> [[a]]
objectsPerLevel' (Cofre xs) = [xs]
objectsPerLevel' (Nada m) = [] : objectsPerLevel m 
objectsPerLevel' (Bifurcacion xs m1 m2) = xs : juntar (objectsPerLevel' m1) (objectsPerLevel' m2)


{- 

    has (==x) = any (elem x) . objectsPerLevel
aplico ppio de extensionalidad
    has (==x) m = any (elem x) . objectsPerLevel m
                                     def (.)
    has (==x) m = any (elem x) (objectsPerLevel m)
DEM : Por induccion en la estructura de m
CASO BASE : (Cofre xs)
    has (==x) (Cofre xs) = any (elem x) (objectsPerLevel (Cofre xs))
def has 1                   def objectsPerLevel 1
    any (==x) xs = any (elem x) [xs]
                        def any
                    elem x xs || any (elem x) []
                        def any 1
                    elem x xs || False
                        neutro ||
                    elem x xs

Proposicion: Para todo xs. ¿ any (==x) xs = elem x xs ? 
Dem: Por induccion en la estructura de xs
CASO BASE : xs = []
    any (==x) [] = elem x []
def any 1           def elem 1
    False        =  False
CASO INDUCTIVO : xs = (x:xs')
HI) ¡ any (==y) xs' = elem y xs' !
TI) ¿ any (==y) (x:xs') = elem y (x:xs') ?

    any (==y) (x:xs') = elem y (x:xs')
def any 2                           def elem 2
    (==y) x || any (==y) xs' = y == x || elem y xs'
HI) y notación
    y == x || elem y xs' = y == x || elem y xs'

CASO INDUCTIVO 2 = m = (Nada m)
HI)
TI)
    has (==x) (Nada m) = any (elem x) (objectsPerLevel (Nada m))
def has 2           def objectsPerLevel 2
    has (==x) m = any (elem x) ([] : objectsPerLevel m)
                    def any
                = (elem x) [] || any (elem x) (objectsPerLevel m)
                    def elem 1
                = False || any (elem x) (objectsPerLevel m)
                    neutro ||
    has (==x) m = any (elem x) (objectsPerLevel m)

CASO INDUCTIVO 3 = m = (Bifurcacion xs m1 m2)
    has (==x) (Bifurcacion xs m1 m2) = any (elem x) (objectsPerLevel (Bifurcacion xs m1 m2))
def has 3
    any (==x) xs || has (==x) m1 || has (==x) m2 = 
HI)
    elem x xs || has (==x) m1 || has (==x) m2 

---------------------------------------------------------------------

    any (elem x) (objectsPerLevel (Bifurcacion xs m1 m2))
def objectsPerLevel 3
    any (elem x) (xs : juntar (objectsPerLevel m1) (objectsPerLevel m2))
def any 2
    elem x xs || any (elem x) (juntar (objectsPerLevel m1) (objectsPerLevel m2))
demostracion 
    elem x xs || any (elem x) (objectsPerLevel m1) || any (elem x) (objectsPerLevel m2)
caso inductivo 2
    elem x xs || has (==x) m1 || has (==x) m2 

Proposicion : Para todo xs, ys ¿ any (elem x) xs || any (elem x) ys = any (elem x) (juntar xs ys) ?
Dem: Por induccion en la estructura de xs
CASO BASE : xs = [] 
    any (elem x) [] || any (elem x) ys = any (elem x) (juntar [] ys)
def any 1                                           def juntar 
    False || any (elem x) ys = any (elem x) ys
neutro ||
        any (elem x) ys
CASO INDUCTIVO : xs = (x:xs')
    Dem: Por induccion en la estructura de ys
    CASO BASE: ys = []
        any (elem x) xs || any (elem x) [] = any (elem x) (juntar xs [])
    def any 1                                       def juntar
        any (elem x) xs || False = any (elem x) xs
    neutro ||
        any (elem x) xs
    CASO INDUCTIVO : xs = (x:xs') e ys = (y:ys')
    HI) ¡ any (elem z) xs' || any (elem z) ys' = any (elem z) (juntar xs' ys') !
    TI) ¿ any (elem z) (x:xs') || any (elem z) (y:ys') = any (elem z) (juntar (x:xs') (y:ys')) ?

    def any 2
        elem z x || any (elem z) xs' || elem z y || any (elem z) ys'
    conmutacion
        elem z x || elem z y || any (elem z) xs' || any (elem z) ys'
    HI)
        elem z x || elem z y || any (elem z) (juntar xs' ys')

--------------------------------------------------------------------------------
        any (elem z) (juntar (x:xs') (y:ys'))
    def juntar
        any (elem z) ((x ++ y) : (juntar xs' ys'))
    def any
        elem z (x ++ y) || any (elem z) (juntar xs' ys')
    demostracion ++ ||
        elem z x || elem z y || any (elem z) (juntar xs' ys')

-}

--EJ 7

{-
(GNode 1 [GNode 2 [GNode 5 [], GNode 6 []] , GNode 3 [GNode 7 []], GNode 4 []])

Árboles

-}

data GenTree a = GNode a [GenTree a] deriving (Eq, Show)

foldGT0 :: (a -> [b] -> b) -> GenTree a -> b
foldGT0 f (GNode x xs) = f x (map (foldGT0 f) xs)

foldGT1 :: (a -> c -> b) -> (b -> c -> c) -> c -> GenTree a -> b
foldGT1 g f z (GNode x xs) = g x (foldr f z (map (foldGT1 g f z) xs))

foldGT2 :: (a -> c -> b) -> ([b] -> c) -> GenTree a -> b
foldGT2 g f (GNode x xs) = g x (f (map (foldGT2 g f) xs))

recGT0 :: (a -> [GenTree a] -> [b] -> b) -> GenTree a -> b
recGT0 f (GNode x xs) = f x xs (map (recGT0 f) xs)

--VERSIONES EXPLICITAS

mapGT :: (a -> b) -> GenTree a -> GenTree b
mapGT f (GNode y xs) = GNode (f y) (map (mapGT f) xs)

sumaUno :: Int -> Int
sumaUno x = x + 1

sumGT :: GenTree Int -> Int
sumGT (GNode y xs) = y + sum (map sumGT xs)

sizeGT :: GenTree a -> Int
sizeGT (GNode y xs) = 1 + sum (map sizeGT xs)

heightGT :: GenTree a -> Int
heightGT (GNode _ []) = 1
heightGT (GNode _ xs) = 1 + (maximum (map heightGT xs))

preOrderGT :: GenTree a -> [a]
preOrderGT (GNode y xs) = y : (concat (map preOrderGT xs))

--inOrderGT :: GenTree a -> [a]
--inOrderGT 

postOrderGT :: GenTree a -> [a]
postOrderGT (GNode y xs) = reverse (concat (map preOrderGT xs)) ++ [y]

--mirrorGT1 :: GenTree a -> GenTree a
--mirrorGT1 (GNode y xs) = 

countByGT :: (a -> Bool) -> GenTree a -> Int
countByGT f (GNode y xs) = if (f y) then 1 + sum (map (countByGT f) xs)
                                    else sum (map (countByGT f) xs)

partitionGT :: (a -> Bool) -> GenTree a -> ([a], [a])
partitionGT f (GNode y xs) = if (f y) then (y : fst (listOfTuples(map (partitionGT f) xs)) , snd (listOfTuples(map (partitionGT f) xs)))
                                    else (fst (listOfTuples(map (partitionGT f) xs)) , y:  snd (listOfTuples(map (partitionGT f) xs)))

listOfTuples :: [([a],[a])] -> ([a],[a])
listOfTuples [] = ([],[])
listOfTuples ((x,y):xs) = (x ++ fst(listOfTuples xs), y ++ snd(listOfTuples xs))

--zipWithGT :: (a->b->c) -> GenTree a -> GenTree b -> GenTree c
--zipWithGT 

--Ejercicio 4

type Record a b = [(a,b)] 

crossWith :: (a -> b -> c) -> [a] -> [b] -> [c]
crossWith h = foldr f g
    where f x r [] = []
          f x r (y:ys) = (:) (h x y) (r ys)
          g ys = []

sumaPar (x1,y1) (x2,y2) = (x1+x2 , y1+y2)

select :: (Record a b -> Bool) -> [Record a b] -> [Record a b]
select f [] = []
select f (x:xs) = if f x then x : select f xs else select f xs

project :: (a -> Bool) -> [Record a b] -> [Record a b]
project f [] = []
project f (x:xs) = if (f (getA x)) then x : project f xs 
                                    else project f xs

getA :: (Record a b) -> a
getA [(x,y)] = x

product :: [Record a b] -> [Record a b] -> [Record a b]
product xs ys = foldr (:) ys xs

similar :: Eq a => Record a b -> Record a b 
similar r1 = foldr (\x xs -> if (contains x xs) then xs else x : xs) [] r1

contains :: Eq a => (a, b) -> Record a b -> Bool
contains (x, y) []     = False
contains (x, y) (z:zs) = x == fst z || contains (x, y) zs 

--Ejercicio 5

data Query a b = Table [Record a b] | Product (Query a b) (Query a b) | Projection (a -> Bool) (Query a b) | Selection (Record a b -> Bool) (Query a b)


-- Projection (/= "age") (Selection (\(c,v)-> c /= "name" || v == "Edward Snowden") (Table [ [("name", "Edward Snowden"),("age", "29")] [("name", "Jason Bourne"), ("age", "40")] ]))

foldQ :: ([Record a b] -> c) -> (c -> c -> c) -> ((a -> Bool) -> c -> c) -> ((Record a b -> Bool) -> c -> c) -> Query a b -> c
foldQ t pd pj s (Table rs) = t rs
foldQ t pd pj s (Product q1 q2) = pd (foldQ t pd pj s q1) (foldQ t pd pj s q2)
foldQ t pd pj s (Projection f q) = pj f (foldQ t pd pj s q)
foldQ t pd pj s (Selection g q) = s g (foldQ t pd pj s q)

tables :: Query a b -> [[Record a b]]
tables qr = foldQ (\xs -> [xs]) (++) (\f xs -> xs) (\f xs -> xs) qr

execute :: Query a b -> [Record a b]
execute (Table xs) = xs
execute (Product q1 q2) = execute q1 ++ execute q2
execute (Projection f q1) = project f (execute q1)
execute (Selection f q1) = select f (execute q1)

compact :: Query a b -> Query a b
compact (Table xs) = Table xs
compact (Product q1 q2) = Product (compact q1) (compact q2)
compact (Projection f1 qr) = case qr of 
                                    (Projection f2 qr') -> Projection (lift (||) f1 f2) (compact qr')
                                    (_) -> Projection f1 (compact qr)
compact (Selection f1 qr) = case qr of 
                                    (Selection f2 qr') -> Selection (lift (&&) f1 f2) (compact qr')
                                    (_) -> Selection f1 (compact qr)

lift :: (Bool-> Bool -> Bool) -> (a-> Bool) -> (a-> Bool) -> (a-> Bool)
lift f g h x = f (g x) (h x)

{-
    execute . compact = execute
aplico ppio de extensionalidad
    execute . compact qr = execute qr
def (.)
    execute (compact qr) = execute qr
demostracion por principio de induccion en la estructura de qr
CASO BASE : qr = (Table xs)
    execute (compact (Table xs)) = execute (Table xs)
def compact 1
    execute (Table xs) = execute (Table xs)

CASO INDUCTIVO 1 : qr = (Product q1 q2)
HI1) ¡execute (compact q1) = execute q1!
HI2) ¡execute (compact q2) = execute q2!
TI) ¿execute (compact (Product q1 q2)) = execute (Product q1 q2)?

    execute (compact (Product q1 q2))
def compact 2
    execute (Product (compact q1) (compact q2))
def execute 2
    execute (compact q1) ++ execute (compact q2)
HI1 e HI2
    execute q1 ++ execute q2
def execute 2
    execute (Product q1 q2)

CASO INDUCTIVO 2 : qr = (Projection f qr')
HI) ¡execute (compact qr) = execute qr!
TI) ¿execute (compact (Projection f qr)) = execute (Projection f qr))?

    execute (compact (Projection f qr))
def compact 3

    DE ESTO SALEN DOS CASOS:
CASO 1 : qr = (Projection f2 qr')
    execute (Projection (\x -> f1 x || f2 x) (compact qr')) = execute (Projection f1 (Projection f2 qr'))
def execute 3
    project (\x -> f1 x || f2 x) (execute (compact qr'))
HI)
    project (\x -> f1 x || f2 x) (execute qr')
def execute 3
    execute (Projection (\x -> f1 x || f2 x) (execute qr'))
def execute
    execute (Projection f1 (Projection f2 qr'))

CASO 2 : qr = qr
    execute (Projection f1 (compact qr)) = execute (Projection f1 qr)
def execute 3
    project f1 (execute (compact qr))
HI)
    project f1 (execute qr)
def execute 3
    execute (Projection f1 qr) 
-}
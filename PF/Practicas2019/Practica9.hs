-- EJERCICIO 3

data Tree a = EmptyT | NodeT a (Tree a) (Tree a)

sumarT :: Tree Int -> Int
sumarT EmptyT = 0
sumarT (NodeT n t1 t2) =  n + (sumarT t1) + (sumarT t2)

sizeT :: Tree a -> Int
sizeT EmptyT = 0
sizeT (NodeT e t1 t2) = 1 + (sizeT t1) + (sizeT t2)

anyT :: (a -> Bool) -> Tree a -> Bool
anyT f EmptyT = False
anyT f (NodeT e t1 t2) = if (f e) then True
                                  else (anyT f t1) || (anyT f t2)

countT :: (a -> Bool) -> Tree a -> Int
countT f EmptyT = 0
countT f (NodeT e t1 t2) = if (f e) then 1 + (countT f t1) + (countT f t2)
                                    else (countT f t1) + (countT f t2)

countLeavesT :: Tree a -> Int
countLeavesT EmptyT = 1
countLeavesT (NodeT e t1 t2) = (countLeavesT t1) + (countLeavesT t2)

heightT :: Tree a -> Int
heightT EmptyT = 1
heightT (NodeT e t1 t2) = max (1 + heightT t1) (1 + heightT t2)

inOrderT :: Tree a -> [a]
inOrderT EmptyT = []
inOrderT (NodeT e t1 t2) = (inOrderT t1) ++ [e] ++ (inOrderT t2)

listPerLevelT :: Tree a -> [[a]]
listPerLevelT EmptyT = []
listPerLevelT (NodeT e t1 t2) = [e] : juntarT (listPerLevelT t1) (listPerLevelT t2)

juntarT :: [[a]] -> [[a]] -> [[a]]
juntarT [] [] = []
juntarT (xs:xss) [] = xs : xss
juntarT [] (ys:yss) = ys : yss
juntarT (xs:xss) (ys:yss) = (xs ++ ys) : (juntarT xss yss)

mirrorT :: Tree a -> Tree a
mirrorT EmptyT = EmptyT
mirrorT (NodeT e t1 t2) = NodeT e (mirrorT t1) (mirrorT t2)

levelN :: Int -> Tree a -> [a]
levelN n EmptyT = []
levelN n (NodeT e t1 t2) = if (n == 0) then [e]
                                       else (levelN (n-1) t1) ++ (levelN (n-1) t2)

ramaMasLarga :: Tree a -> [a]
ramaMasLarga EmptyT = []
ramaMasLarga (NodeT e t1 t2) = if (length (ramaMasLarga t1) > length (ramaMasLarga t2)) then e : (ramaMasLarga t1)
                                                                                        else e : (ramaMasLarga t2)

todosLosCaminos :: Tree a -> [[a]]
todosLosCaminos EmptyT = [[]]
todosLosCaminos (NodeT e t1 t2) = map (add e) ((todosLosCaminos t1) ++ (todosLosCaminos t2))

add :: a -> [a] -> [a]
add e xs = e : xs


{-
b-

Propiedad: ¿ heightT = length . ramaMasLarga ?

Demostracion: 

Desarrollo preliminar: 

Por principio de extensionalidad, es equivalente demostrar:
    
    ¿ Para todo t :: Tree a. heightT t = (length . ramaMasLarga) t ?

Por composición es equivalente demostrar:

    ¿ Para todo t :: Tree a. heightT t = length (ramaMasLarga t) ?

Planteo:
    Esta propiedad se puede demostrar utilizando el principio de inducción estructural en la estructura de t

CASO BASE: t = emptyT

    ¿ heightT emptyT = length (ramaMasLarga emptyT) ?

heighT emptyT
=               (def heightT 1)
0

length (ramaMasLarga emptyT)
=               (def ramaMasLarga 1)
length []
=               (def length 1)
0

CASO INDUCTIVO: t = (NodeT e t1 t2)
HI1) ¡ heightT t1 = length (ramaMasLarga t1) !
HI2) ¡ heightT t2 = length (ramaMasLarga t2) !
TI) ¿ heightT (NodeT e t1 t2) = length (ramaMasLarga (NodeT e t1 t2)) ?

Lado Derecho:

length (ramaMasLarga (NodeT e t1 t2))
=                                       (def ramaMasLarga 2)
length (if (length (ramaMasLarga t1) > length (ramaMasLarga t2)) then e : (ramaMasLarga t1)
                                                                 else e : (ramaMasLarga t2)))

1) length (e : (ramaMasLarga t1))
2) length (e : (ramaMasLarga t2))

1) length (e : (ramaMasLarga t1))
=                               (def length 2)
    1 + (length (ramaMasLarga t1)))
=                               (HI1)
    1 + (height t1)

2) length (e : (ramaMasLarga t2))
=                               (def length 2)
    1 + (length (ramaMasLarga t2)))
=                               (HI1)
    1 + (height t2)

Lado Izquierdo:

    heightT (NodeT e t1 t2)
=                           (def heightT 2)
    max (1 + heightT t1) (1 + heightT t2)

3)  (1 + heightT t1)
4)  (1 + heightT t2)


Propiedad: ¿ reverse . listInOrder = listInOrder . mirrorT ?

Demostracion: 

Desarrollo preliminar: 

Por principio de extensionalidad, es equivalente demostrar:

    Para todo t :: Tree a. (reverse . listInOrder) t = (listInOrder . mirrorT) t

Por composición es equivalente demostrar:

    reverse (listInOrder t) = listInOrder (mirrorT t)

Esta propiedad se puede demostrar utilizando el principio de inducción estructural en la estructura de t

CASO BASE: t = emptyT

    reverse (listInOrder emptyT) = listInOrder (mirrorT emptyT)

Lado Izquierdo:

    reverse (listInOrder emptyT)
=                               (def listInOrder 1)
    reverse []
=                               (def reverse 1)
    []

Lado Derecho:

    listInOrder (mirrorT emptyT)
=                               (def mirrorT 1)
    listInOrder []
=                               (listInOrder 1)
    []

CASO INDUCTIVO: t = (NodeT e t1 t2)
HI1) ¡ reverse (listInOrder t1) = listInOrder (mirrorT t1) !
HI2) ¡ reverse (listInOrder t2) = listInOrder (mirrorT t2) !
TI) ¿ reverse (listInOrder ((NodeT e t1 t2))) = listInOrder (mirrorT (NodeT e t1 t2)) ?
    
Lado Izquierdo:
    reverse (listInOrder (NodeT e t1 t2))
=                                (def listInOrder 2)
    reverse ((listInOrder t1) ++ [e] ++ (listInOrder t2))
=                                (lema)
    (reverse (listInOrder t1)) ++ [e] ++ (reverse (listInOrder t2))
=                                (HI1 e HI2)
    (listInOrder (mirrorT t1)) ++ [e] ++ (listInOrder (mirrorT t2))

Lado Derecho:

    listInOrder (mirrorT (NodeT e t1 t2))
=                                 (def mirrorT 2)
    listInOrder (NodeT e (mirrorT t1) (mirrorT t2))
=                                 (def listInOrder 2)
    listInOrder (mirrorT t1) ++ [e] ++ listInOrder (mirrorT t2)

lema: 
    Prop: Para todo xs, ys :: [a] ¿ reverse (xs ++ [e] ++ ys) = reverse xs ++ [e] ++ reverse ys ?

Esta propiedad se puede demostrar utilizando el principio de inducción estructural en la estructura de xs

CASO BASE: xs = []

    reverse ([] ++ [e] ++ ys) = reverse [] ++ [e] ++ reverse ys

Lado Izquierdo:

    reverse ([] ++ [e] ++ ys)
=                               (def ++ 1)
    reverse([e] ++ ys)

Lado Derecho:

    reverse [] ++ [e] ++ reverse ys
=                               (def reverse 1)
    [] ++ [e] ++ reverse ys
=                               (def ++ 1)
    [e] ++ reverse ys
=                               (def reverse 2)
    reverse (e : ([] ++ ys))
=                               (def ++ 2)
    reverse ([e] ++ ys)

CASO INDUCTIVO: xs = (x:xs)
HI) ¡ reverse (xs ++ [e] ++ ys) = reverse xs ++ [e] ++ reverse ys !
TI) ¿ reverse ((x:xs) ++ [e] ++ ys) = reverse (x:xs) ++ [e] ++ reverse ys ?

Lado Izquierdo:

    reverse ((x:xs) ++ [e] ++ ys)
=                                (def reverse 2)
    (reverse (xs ++ [e] ++ ys)) ++ [x]
=                                (HI)
    (reverse xs ++ [e] ++ reverse ys) ++ [x]
=                                (Asoc.)
    reverse xs ++ [x] ++ [e] ++ reverse ys
=                                (def reverse 2)
    reverse (x:xs) ++ [e] ++ reverse ys
    
-}  

--EJERCICIO 5

data QuadTree a = LeafQ a | NodeQ (QuadTree a) (QuadTree a) (QuadTree a) (QuadTree a) deriving (Show, Eq)

data Color = RGB Int Int Int

type Image = QuadTree Color

heightQT :: QuadTree a -> Int
heightQT (LeafQ a) = 0
heightQT (NodeQ q1 q2 q3 q4) = 1 + max (heightQT q1) (max (heightQT q2) (max (heightQT q3) (heightQT q4)))

countLeavesQT :: QuadTree a -> Int
countLeavesQT (LeafQ a) = 1
countLeavesQT (NodeQ q1 q2 q3 q4) = (countLeavesQT q1) + (countLeavesQT q2) + (countLeavesQT q3) + (countLeavesQT q4)

sizeQT :: QuadTree a -> Int
sizeQT (LeafQ a) = 1
sizeQT (NodeQ q1 q2 q3 q4) = 1 + (countLeavesQT q1) + (countLeavesQT q2) + (countLeavesQT q3) + (countLeavesQT q4)

compress :: Eq a => QuadTree a -> QuadTree a
compress (LeafQ a) = LeafQ a
compress (NodeQ q1 q2 q3 q4) = if ((esIgualQT q1 q2) && (esIgualQT q1 q3) && (esIgualQT q1 q4))
                                    then q1
                                    else (NodeQ (compress q1) (compress q2) (compress q3) (compress q4))

esIgualQT :: Eq a => QuadTree a -> QuadTree a -> Bool
esIgualQT (LeafQ e1) (LeafQ e2) = e1 == e2
esIgualQT (LeafQ e1) _ = False
esIgualQT _ (LeafQ e2) = False
esIgualQT (NodeQ q1 q2 q3 q4) (NodeQ q5 q6 q7 q8) = esIgualQT q1 q5 && esIgualQT q2 q6 && esIgualQT q3 q7 && esIgualQT q4 q8


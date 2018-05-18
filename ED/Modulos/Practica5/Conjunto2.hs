module Conjunto2(Set, emptyS, singleton, unionS, belongs, setToList) where

data Set a = Mks [a] Int deriving (Eq, Show)

--O(1)
emptyS :: Set a
emptyS = Mks [] 0

--O(1)
singleton :: a -> Set a
singleton e = Mks (e : []) 1

--o(1)
addS :: Eq a => a -> Set a -> Set a
addS e (Mks xs i) = Mks (e : xs) (i+1)

--o(n)
belongs :: Eq a => a -> Set a -> Bool
belongs e (Mks xs i) = pertenece e xs

--o(n)
pertenece :: Eq a => a -> [a] -> Bool
pertenece e [] = False
pertenece e (x:xs) = if e == x
						then True
						else pertenece e xs

--o(1)
sizeS :: Eq a => Set a -> Int
sizeS (Mks xs i) = i

--o(n)
removeS :: Eq a => a -> Set a -> Set a
removeS e (Mks xs i) = Mks (quitarElem e xs) (i-1)

--o(n)
quitarElem :: Eq a => a -> [a] -> [a]
quitarElem e [] = []
quitarElem e (x:xs) = if e == x
							then quitarElem e xs
							else x : (quitarElem e xs) 
							
--PRECOND: Dos Listas que no tienen repetidos entre ellas.
--o(n)
unionS :: Eq a => Set a -> Set a -> Set a
unionS (Mks xs i) (Mks ys x) = Mks (agregar xs ys) (i+x)

--o(n)
agregar :: [a] -> [a] -> [a]
agregar [] ys = ys
agregar (x:xs) ys = x : (agregar xs ys)

--o(n)
intersectionS :: Eq a => Set a -> Set a -> Set a
intersectionS (Mks xs i) (Mks ys x) = Mks (inter xs ys) (i+x)

--o(n)
inter :: Eq a => [a] -> [a] -> [a]
inter [] ys = []
inter (x:xs) ys = if pertenece x ys 
					then x : inter xs ys
					else inter xs ys

--o(1)					
setToList :: Eq a => Set a -> [a]
setToList (Mks xs i) = xs

module Conjunto1(Set, emptyS, singleton, unionS, belongs, setToList) where

data Set a = Mks [a] deriving (Eq, Show)

emptyS :: Set a
emptyS = Mks []

singleton :: a -> Set a
singleton e = Mks (e : [])

addS :: Eq a => a -> Set a -> Set a
addS e (Mks xs) = Mks (e : xs)

belongs :: Eq a => a -> Set a -> Bool
belongs e (Mks xs) = pertenece e xs

pertenece :: Eq a => a -> [a] -> Bool
pertenece e [] = False
pertenece e (x:xs) = if e == x
						then True
						else pertenece e xs

sizeS :: Eq a => Set a -> Int
sizeS (Mks xs) = length xs

removeS :: Eq a => a -> Set a -> Set a
removeS e (Mks xs) = Mks (quitarElem e xs)

quitarElem :: Eq a => a -> [a] -> [a]
quitarElem e [] = []
quitarElem e (x:xs) = if e == x
							then quitarElem e xs
							else x : (quitarElem e xs)
							

unionS :: Eq a => Set a -> Set a -> Set a
unionS (Mks xs) (Mks ys) = Mks (agregar xs ys)

agregar :: [a] -> [a] -> [a]
agregar [] ys = ys
agregar (x:xs) ys = x : (agregar xs ys)

intersectionS :: Eq a => Set a -> Set a -> Set a
intersectionS (Mks xs) (Mks ys) = Mks (inter xs ys)

inter :: Eq a => [a] -> [a] -> [a]
inter [] ys = []
inter (x:xs) ys = if pertenece x ys 
					then x : inter xs ys
					else inter xs ys

setToList :: Eq a => Set a -> [a]
setToList (Mks xs) = xs



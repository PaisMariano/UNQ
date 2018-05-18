module Set(Set, emptyS, belongs, addS, removeS, unionS, intersectionS, sizeS, setToList) where

data Set a = MkS [a] Int
-- Invariantes de representación:
-- No hay elementos repetidos

-- O(1)
emptyS :: Set a
emptyS = MkS [] 0

-- O(n)
belongs :: Eq a => a -> Set a -> Bool
belongs x (MkS xs n) = pertenece x xs

-- O(n)
pertenece :: Eq a => a -> [a] -> Bool
pertenece y [] = False
pertenece y (x:xs) = y == x || pertenece y xs

-- O(n)
addS :: Eq a => a -> Set a -> Set a
addS x (MkS xs n) = if pertenece x xs
	                 then MkS xs n
	                 else MkS (x:xs) (n+1)

-- O(n)
removeS :: Eq a => a -> Set a -> Set a
removeS x (MkS xs n) = 
	if pertenece x xs
		then MkS (remove x xs) (n-1)
		else MkS xs n

-- O(n)
remove :: Eq a => a -> [a] -> [a]
remove y [] = []
remove y (x:xs) =
	if y == x
		then xs
		else x : remove y xs

-- O(n^2)
unionS :: Eq a => Set a -> Set a -> Set a
unionS (MkS xs n) s2 = addAll xs s2

-- O(n^2)
addAll :: Eq a => [a] -> Set a -> Set a
addAll [] s2 = s2
addAll (x:xs) s2 = addS x (addAll xs s2)

-- O(n^2)
intersectionS :: Eq a => Set a -> Set a -> Set a
intersectionS (MkS xs n1) (MkS ys n2) = 
	let rs = (intersection xs ys)
	    in MkS rs (length rs)

-- O(n^2)
intersection :: Eq a => [a] -> [a] -> [a]
intersection [] ys = []
intersection (x:xs) ys = 
	if pertenece x ys
		then x : intersection xs ys
		else intersection xs ys

-- O(1)
sizeS :: Set a -> Int
sizeS (MkS xs n) = n

-- O(1)
setToList :: Eq a => Set a -> [a]
setToList (MkS xs n) = xs
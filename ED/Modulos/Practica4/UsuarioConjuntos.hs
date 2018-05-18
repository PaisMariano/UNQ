import Conjuntos1 

data Tree a = EmptyT | NodeT a (Tree a) (Tree a)

losQuePertenecen :: Eq a => [a] -> Set a -> [a]

losQuePertenecen xs (Set a) = pertenecen xs (setToList (Set a))

pertenecen :: Eq a => [a] -> [a] -> [a]
pertenecen [] ys = []
pertenecen (x:xs) ys = let es' = pertenecen xs ys
						in if pertenece x ys
								then x : es'
								else es'

pertenece :: Eq a => a -> [a] -> Bool
pertenece a [] = False
pertenece a (x:xs) =
		if x == a
			then True
			else pertenece a xs

sinRepetidos :: [a] -> [a]
sinRepetidos xs = setToList (listToSet xs)

listToSet :: [a] -> Set a
listToSet [] = emptyS
listToSet (x:xs) = unionS (singleton x) (listToSet xs)

unirTodos :: Tree (Set a) -> Set a
unirTodos EmptyT          = emptyS
unirTodos (NodeT a t1 t2) = unionS a (unionS (unirTodos t1) 
							(unirTodos t2))
data Tree a = EmptyT | NodeT a (Tree a) (Tree a) deriving (Eq, Show)

headM :: [a] -> Maybe a
--Versión de head que es total
headM []     = Nothing 
headM (x:xs) = Just x


lastM :: [a] -> Maybe a
--Dada una lista, devuelve su último elemento.
lastM []   = Nothing
lastM (xs) = Just (last xs)

maximumM :: Ord a => [a] -> Maybe a
--Dada una lista de elementos devuelve el máximo.
maximumM []     = Nothing
maximumM (x:xs) = maxM x (maximumM xs)

maxM :: Ord a => a -> Maybe a -> Maybe a
maxM x Nothing     = Just x
maxM x (Just y) = Just (max x y)

initM :: [a] -> Maybe [a]
--Dada una lista quita su último elemento.
initM []   = Nothing
initM [x]  = Just []
initM (x:xs) = 
		case initM xs of 
			Nothing -> Just [x]
			(Just ys) -> Just (x:ys)

get :: Int -> [a] -> Maybe a
--Dado un índice devuelve el elemento de esa posición.
get i []     = Nothing
get i (x:xs) = if i == 0
					then Just x
					else get (i-1) xs


indiceDe :: Eq a => a -> [a] -> Maybe Int
--Dado un elemento y una lista devuelve la posición de la lista en la que se encuentra dicho elemento.
indiceDe e []       = Nothing
indiceDe e (x:xs)   = if e == x 
							then Just 0
							else case indiceDe e xs of 
									Nothing  -> Nothing
									(Just y) -> Just (y+1)
							

lookupM :: Eq k => [(k,v)] -> k -> Maybe v
--Dada una lista de pares (clave, valor) y una clave devuelve el valor asociado a la clave.
lookupM [] e       = Nothing
lookupM (x:xs) e   = if e == (fst x)
							then Just (snd x)
							else lookupM xs e

fromJusts :: [Maybe a] -> [a]
--Devuelve los valores de los Maybe que no sean Nothing.
fromJusts []     = []
fromJusts (x:xs) = case x of
					Nothing  -> fromJusts xs
					(Just y) -> y : fromJusts xs


minT :: Ord a => Tree a -> Maybe a
--Dado un árbol devuelve su elemento mínimo.
minT EmptyT          = Nothing
minT (NodeT x t1 t2) = minX (Just x) (minX (minT t1) (minT t2))

minX :: Ord a => Maybe a -> Maybe a -> Maybe a
minX Nothing Nothing   = Nothing
minX Nothing (Just y)  = Just y
minX (Just x) Nothing  = Just x 
minX (Just x) (Just y) = Just (min x y)

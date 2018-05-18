module MaybeModulo(headM, lastM, maximoM, maximoM2, initM, initM2, get, indiceDe, lookupM, fromJusts, fromJusts2, isNothing, fromJust, recalcularMaximo)where

--A:
headM :: [a] -> Maybe a
headM [] = Nothing
headM (x : xs) = Just x


--B:
lastM :: [a] -> Maybe a
lastM [] = Nothing
lastM [x] = Just x
lastM (x : xs) = lastM xs


--C:
maximoM :: Ord a => [a] -> Maybe a
maximoM [] = Nothing
maximoM (x: xs) = Just (elMasGrande x (maximum xs))

elMasGrande :: Ord a => a -> a -> a
elMasGrande x y = if(x > y)
						then x
						else y


--Version Mas linda:
maximoM2 :: Ord a => [a] -> Maybe a
maximoM2 [] = Nothing
maximoM2 (x : xs) = maxM x (maximoM2 xs)

maxM :: Ord a => a -> Maybe a -> Maybe a
maxM x Nothing = Just x
maxM x (Just y) = Just (max x y)


--D:
--Version Con subtarea.
initM :: [a] -> Maybe [a]
initM [] = Nothing
initM [x] = Just []
initM (x : xs) = agrego x (initM xs)

agrego :: a -> Maybe [a] -> Maybe [a]
agrego x Nothing = Just [x]
agrego x (Just xs) = Just (x : xs) 

--Version con Case of.
initM2 :: [a] -> Maybe [a]
initM2 [] = Nothing
initM2 [x] = Just []
initM2 (x : xs) = 
				case initM xs of
						Nothing -> Just [x]
						Just xs -> Just (x : xs)


--E:
get :: Int -> [a] -> Maybe a
--Dado un numero y una lista, retora un Maybe con el elemento que este en la posicion pasada por parametro de dicha lista.
get n [] = Nothing
get 0 (x : xs) = Just x
get n (x : xs) = get (n - 1) xs


--F:
--Dado un elemento y una lista del mismo tipo que ese elemento, retorna un Maybe Int, con la posicion que ocupa dicho elemento en la lista pasada por parametro.
--Version con subtarea:
indiceDe :: Eq a => a -> [a] -> Maybe Int
indiceDe x [] = Nothing
indiceDe x (y : ys) = if x == y
							then Just 0
							else subirIndice (indiceDe x ys)


subirIndice :: Maybe Int -> Maybe Int
subirIndice Nothing = Nothing
aubirIndice (Just a) = Just (sumarUno a)

sumarUno :: Int -> Int
sumarUno x = x + 1

--Version con case of:
indiceDe2 :: Eq a => a -> [a] -> Maybe Int
indiceDe2 y [] = Nothing
indiceDe2 y (x : xs) = 
						if x == y
								then Just 0
								else 
									case indiceDe2 y xs of
											Nothing -> Nothing
											(Just n) -> Just (n + 1)


--G:
lookupM :: Eq k => k -> [(k, v)] -> Maybe v
lookupM x [] = Nothing
lookupM x (p : ps) = if(x == fst p)
							then Just (snd p)
							else lookupM x ps


--H:
--Version con subtareas. 
fromJusts :: [Maybe a] -> [a]
fromJusts [] = []
fromJusts (m : ms) = if isNothing m
							then fromJusts ms
							else fromJust m : fromJusts ms

fromJust :: Maybe a -> a
--Precondicion: El maybe a no puede ser Nothing.
fromJust (Just x) = x

isNothing :: Maybe a -> Bool
isNothing Nothing = True
isNothing _ = False

--Version  on case of:
fromJusts2 :: [Maybe a] -> [a]
fromJusts2 [] = []
fromJusts2 (m : ms) =
					case m of
							Nothing -> fromJusts2 ms
							(Just x) -> x : fromJusts2 ms

recalcularMaximo :: Ord a => [a] -> Maybe a
recalcularMaximo [] = Nothing
recalcularMaximo xs = Just (maximum xs)
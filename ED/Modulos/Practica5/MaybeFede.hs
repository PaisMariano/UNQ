headM :: [a] -> Maybe a
headM [] = Nothing
headM (x:xs) = Just x

lastM :: [a] -> Maybe a
lastM [] = Nothing
lastM [x] = Just x
lastM (x:xs) = lastM xs

maximoM :: Ord a => [a] -> Maybe a
maximoM [] = Nothing
-- maximoM [x] = Just x -- no hace falta
maximoM (x:xs) = maxM x (maximoM xs)

maxM :: Ord a => a -> Maybe a -> Maybe a
maxM x Nothing = Just x
maxM x (Just y) = Just (max x y)

initM :: [a] -> Maybe [a]
initM [] = Nothing
initM [x] = Just []
initM (x:xs) = 
    case initM xs of
        Nothing -> Just [x]
        (Just ys) -> Just (x:ys)

    -- Variante con subtarea (mejor con case of)
    --  agregar x (initM xs) 

-- agregar :: a -> Maybe [a] -> Maybe [a]
-- agregar x Nothing = Just [x]
-- agregar x (Just ys) = Just (x:ys)

get :: Int -> [a] -> Maybe a
get n [] = Nothing
get 0 (x:xs) = Just x
get n (x:xs) = get (n-1) xs+

indiceDe :: Eq a => a -> [a] -> Maybe Int
indiceDe y [] = Nothing
indiceDe y (x:xs) =
    if y == x
        then Just 0
        else case indiceDe y xs of
                  -- si llego a Nothing "n" no estaba
                  Nothing -> Nothing 
                  (Just n) -> Just (n+1)

    -- Variante con subtarea                  
    -- if y == x
    --     then Just 0
    --     else sumarUno (indiceDe y xs)                  
    -- Me quedo con la de case of

-- sumarUno :: Maybe Int -> Maybe Int
-- sumarUno Nothing = Nothing
-- sumarUno (Just n) = Just (n+1)

lookupM :: Eq k => k -> [(k, v)] -> Maybe v
lookupM k [] = Nothing
lookupM k ((k',v):kvs) =
    if k == k'
        then Just v
        else lookupM k kvs

fromJusts :: [Maybe a] -> [a]
fromJusts [] = []
fromJusts (m:ms) = 
    case m of
        Nothing -> fromJusts ms
        (Just x) -> x : fromJusts ms

data Tree a = EmptyT | NodeT a (Tree a) (Tree a)        

minT :: Ord a => Tree a -> Maybe a        
minT EmptyT = Nothing
-- NO definir los casos para hojas
-- o arboles con una sola rama
minT (NodeT x t1 t2) = 
    minM (Just x) (minM (minT t1) (minT t2))
-- en este caso case of no queda prolijo

minM :: Ord a => Maybe a -> Maybe a -> Maybe a
minM Nothing Nothing = Nothing
minM (Just x) Nothing = Just x
minM Nothing (Just y) = Just y
minM (Just x) (Just y) = Just (min x y)

-- Version simplificada
-- minM j1 Nothing = j1
-- minM Nothing j2 = j2
-- minM (Just x) (Just y) = Just (min x y)
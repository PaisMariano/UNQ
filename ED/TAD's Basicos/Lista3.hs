module Lista3(Lista, nilL, isEmptyL, consL, headL, tailL, lenL, maximoL) where

import Maybe

data Lista a = MkL [a] Int (Maybe a) deriving Show

-- Invariantes de Representacion:
-- El Int tiene que ser el largo de la lista
-- Si la lista está esta vacia el Maybe es Nothing
-- y sino el Maybe es Just el maximo de la lista

-- Tarda tiempo constante
nilL :: Lista a
nilL = MkL [] 0 Nothing

-- Tarda tiempo constante
isEmptyL :: Lista a -> Bool
isEmptyL (MkL _ n m) = n == 0

-- Tarda tiempo constante
consL :: Ord a => a -> Lista a -> Lista a
consL x (MkL xs n m) = MkL (x:xs) (n+1) (maxM x m)

maxM x Nothing = Just x
maxM x (Just y) = Just (max x y)

-- Tarda tiempo constante
headL :: Lista a -> a
headL (MkL xs n m) = head xs

-- Recorre tail xs
tailL :: Ord a => Lista a -> Lista a
tailL (MkL xs n m) = MkL (tail xs) (n-1) (calcularMax (tail xs))

calcularMax [] = Nothing
calcularMax xs = Just (maximum xs)

-- Tarda tiempo constante
lenL  :: Lista a -> Int
lenL (MkL xs n m) = n

-- Tarda tiempo constante
maximoL :: Ord a => Lista a -> a
maximoL (MkL xs n m) = fromJust m
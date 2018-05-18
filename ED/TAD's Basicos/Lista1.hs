module Lista1(Lista, nilL, isEmptyL, consL, headL, tailL, lenL, maximoL) where

data Lista a = MkL [a] deriving Show

-- Invariantes de Representacion:
-- NO HAY

-- Tarda tiempo constante
nilL :: Lista a
nilL = MkL []

-- Tarda tiempo constante
isEmptyL :: Lista a -> Bool
isEmptyL (MkL []) = True
isEmptyL _        = False

-- Tarda tiempo constante
consL :: a -> Lista a -> Lista a
consL x (MkL xs) = MkL (x:xs)

-- Tarda tiempo constante
headL :: Lista a -> a
headL (MkL xs) = head xs

-- Tarda tiempo constante
tailL :: Lista a -> Lista a
tailL (MkL xs) = MkL (tail xs)

-- Recorre xs
lenL  :: Lista a -> Int
lenL (MkL xs) = length xs

maximoL :: Ord a => Lista a -> a
maximoL (MkL xs) = maximum xs

module Lista2(Lista, nilL, isEmptyL, consL, headL, tailL, lenL, maximoL) where

data Lista a = MkL [a] Int deriving Show

-- Invariantes de Representacion:
-- El Int tiene que ser el largo de la lista

-- Tarda tiempo constante
nilL :: Lista a
nilL = MkL [] 0

-- Tarda tiempo constante
isEmptyL :: Lista a -> Bool
isEmptyL (MkL _ n) = n == 0

-- Tarda tiempo constante
consL :: a -> Lista a -> Lista a
consL x (MkL xs n) = MkL (x:xs) (n+1)

-- Tarda tiempo constante
headL :: Lista a -> a
headL (MkL xs n) = head xs

-- Tarda tiempo constante
tailL :: Lista a -> Lista a
tailL (MkL xs n) = MkL (tail xs) (n-1)

-- Tarda tiempo constante
lenL  :: Lista a -> Int
lenL (MkL xs n) = n

-- Recorre xs
maximoL :: Ord a => Lista a -> a
maximoL (MkL xs n) = maximum xs
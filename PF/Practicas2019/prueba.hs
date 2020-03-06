{-
(GNode 1 [GNode 2 [GNode 5 [], GNode 6 []] , GNode 3 [GNode 7 []], GNode 4 []])

Árboles

-}

data GenTree a = GNode a [GenTree a] deriving (Eq, Show)

foldGT0 :: (a -> [b] -> b) -> GenTree a -> b
foldGT0 f (GNode x xs) = f x (map (foldGT0 f) xs)

allPaths :: GenTree a -> [[a]]
allPaths gt = foldGT0 addAll gt

addAll :: a -> [[a]] -> [[a]]
addAll x [] = []
addAll x (xs:xss) = (x:xs) ++ (addAll x xss)
---------------------------------------------------------------------------------------------------------
---------------------------------------------- Auxiliares -----------------------------------------------
---------------------------------------------------------------------------------------------------------

module Auxiliares (Tree (..), Persona(..), isEmptyT, rootT, leafT, cantElementos, sumarUno, restarUno, hacerPar, fromJust) where

data Tree a = EmptyT | NodeT a (Tree a) (Tree a) deriving (Eq, Show)

data Persona = P Nombre Edad deriving(Eq, Show)
type Nombre = String
type Edad = Int

isEmptyT :: Tree a -> Bool
isEmptyT EmptyT = True
isEmptyT _ = False

rootT :: Tree a -> a
rootT EmptyT = error "El arbol debe contener como minimo un elemento."
rootT (NodeT x _ _) = x

leafT :: Tree a -> a
leafT EmptyT = error "El arbol debe contener como minimo un elemento."
leafT (NodeT x EmptyT EmptyT) = x
leafT (NodeT x ri EmptyT) = leafT ri
leafT (NodeT x EmptyT rd) = leafT rd

cantElementos :: Tree a -> Int
cantElementos EmptyT = 0
cantElementos (NodeT _ ri rd) = 1 + cantElementos ri + cantElementos rd

sumarUno :: Int -> Int
sumarUno n = n + 1

restarUno :: Int -> Int 
restarUno n = n - 1

hacerPar :: k -> v -> (k, v)
hacerPar x y = (x, y)

fromJust :: Maybe v -> v --Parcial en Nothing.
fromJust Nothing = error "Nada"
fromJust (Just x) = x
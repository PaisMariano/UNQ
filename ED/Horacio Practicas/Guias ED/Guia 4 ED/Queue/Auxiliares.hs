---------------------------------------------------------------------------------------------------------
---------------------------------------------- Auxiliares -----------------------------------------------
---------------------------------------------------------------------------------------------------------

module Auxiliares (Tree (..), Persona(..), Arbol, elNombreDe) where

data Tree a = EmptyT | NodeT a (Tree a) (Tree a) deriving (Eq, Show)

data Persona = P Nombre Edad deriving(Eq, Show)

type Nombre = String
type Edad = Int
type Arbol a = Tree a

elNombreDe :: Persona -> Nombre
elNombreDe (P n e) = n
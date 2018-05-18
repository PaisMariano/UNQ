---------------------------------------------------------------------------------------------------------
---------------------------------------------- Auxiliares -----------------------------------------------
---------------------------------------------------------------------------------------------------------

module Auxiliares (Tree (..), Persona(..)) where

data Tree a = EmptyT | NodeT a (Tree a) (Tree a) deriving (Eq, Show)

data Persona = P Nombre Edad deriving(Eq, Show)

type Nombre = String
type Edad = Int
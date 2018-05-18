---------------------------------------------------------------------------------------------------------
---------------------------------------------- Auxiliares -----------------------------------------------
---------------------------------------------------------------------------------------------------------

module Auxiliares (Tree (..), Persona(..), abel, cain, eva, adan) where

data Tree a = EmptyT | NodeT a (Tree a) (Tree a) deriving (Eq, Show)

data Persona = P Nombre Edad deriving(Eq, Show)

type Nombre = String
type Edad = Int

abel :: Persona --Estructuras me pone... Biblico.
abel = P "Abel" 20

cain :: Persona
cain = P "Cain" 24

eva :: Persona
eva = P "Eva" 44

adan :: Persona
adan = P "Adan" 48
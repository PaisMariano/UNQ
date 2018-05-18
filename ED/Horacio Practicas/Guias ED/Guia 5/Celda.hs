module Celda(Celda, Color(..), celdaVacia, poner, sacar, nroBolitas, hayBolitas)where

import Map1

data Color = Azul | Negro | Rojo | Verde deriving (Eq, Show)
data Celda = MkCelda (Map Color Int) deriving (Eq, Show)

{- Inv. Rep.:
- Existe una clave para cada color existente
- El valor asociado a un color es un numero positivo
-}


colores :: [Color]
colores = [Azul, Negro, Rojo, Verde]


--A:
celdaVacia :: Celda
--Crea una celda con cero bolitas de cada color
celdaVacia = MkCelda (ponerCero colores emptyM) -- O Mkcelda emptyM?

ponerCero :: [Color] -> Map Color Int -> Map Color Int
--ponerCero [] map = map
ponerCero (c : cs) map = assocM (ponerCero cs map) c 0  


--B:
poner :: Color -> Celda -> Celda
--Agrega una bolita de ese color a la celda
poner c (MkCelda map) = MkCelda (ponerColor c map)

ponerColor :: Color -> Map Color Int -> Map Color Int
ponerColor c map = case lookUpM map c of
							Just n -> assocM map c (n + 1) 


--C:
sacar :: Color -> Celda -> Celda
--Saca una bolita de ese color, parcial cuando no hay bolitas de ese color
--Precondicion: Debe haber bolitas de ese color en la celda.
sacar c (MkCelda map) = if ( not (evaluarSiPuedosacar c map))
									then error "La celda no tiene bolitas de ese color para poder sacar."
									else MkCelda (sacarColor c map) 

evaluarSiPuedosacar :: Color -> Map Color Int -> Bool --Equivalente de hay bolitas. No lo quiero re utilizar por si hay un cambio en la interfaz.
evaluarSiPuedosacar c map = case lookUpM map c of
								Just x -> x > 0

sacarColor :: Color -> Map Color Int -> Map Color Int 
sacarColor c map = case lookUpM map c of
							Just n -> assocM map c (n - 1) 
	 


--D:
nroBolitas :: Color -> Celda -> Int
--Devuelve la cantidad de bolitas de ese color
nroBolitas c (MkCelda map) = case lookUpM map c of
									Just x -> x 

hayBolitas :: Color -> Celda -> Bool
--Indica si hay bolitas de ese color
hayBolitas c (MkCelda map) = fromJust (lookUpM map c) > 0

fromJust :: Maybe a -> a
fromJust Nothing = error "Bla" 
fromJust (Just x) = x

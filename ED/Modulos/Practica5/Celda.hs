module Celda(Celda, celdaVacia, poner) where

import Map
import Color 


data Celda m = Mkc (Map Color Int) deriving Show

celdaVacia :: Celda m
celdaVacia = Mkc (ponerEnCero [Rojo, Verde, Azul, Negro] emptyM 0)

ponerEnCero :: [Color] -> Map Color Int -> Int -> Map Color Int
ponerEnCero [] m i     = emptyM
ponerEnCero (x:xs) m i = assocM (ponerEnCero xs m i) x i


poner :: Color -> Celda m -> Celda m
poner col (Mkc m) = Mkc (ponerM col m)

ponerM :: Color -> Map Color Int -> Map Color Int
ponerM col m = case lookupM m col of
					Nothing -> assocM m col 1
					(Just x)-> assocM m col (x+1)


sacar :: Color -> Celda m -> Celda m
sacar col (Mkc m) = Mkc (sacarM col m)

sacarM :: Color -> Map Color Int -> Map Color Int
sacarM col m = case lookupM m col of
					Nothing -> assocM m col 0
					(Just x)-> if x == 0 
							then assocM m col 0
							else assocM m col (x-1)


nroBolitas :: Color -> Celda m -> Int
nroBolitas col (Mkc m) = bolitasCol col m

bolitasCol :: Color -> Map Color Int -> Int
bolitasCol col m = case lookup m col of
						Nothing -> 0
						(Just x)-> x


hayBolitas :: Color -> Celda m -> Bool
hayBolitas col (Mkc m) = hayBol col m

hayBol :: Color -> Map Color Int -> Bool
hayBol col m = case lookup m col of
						Nothing -> False
						(Just x)-> x == 0


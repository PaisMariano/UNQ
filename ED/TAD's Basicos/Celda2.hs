module Celda2(Celda, celdaVacia, poner, sacar, nroBolitas) where 

import Color

data Celda = MkC Int Int Int Int deriving Show

-- Invariantes de Representacion
-- Todos los Int son >= 0

celdaVacia :: Celda
celdaVacia = MkC 0 0 0 0

nroBolitas :: Color -> Celda -> Int
nroBolitas Azul (MkC n1 n2 n3 n4) = n1
nroBolitas Negro (MkC n1 n2 n3 n4) = n2
nroBolitas Rojo (MkC n1 n2 n3 n4) = n3
nroBolitas Verde (MkC n1 n2 n3 n4) = n4

poner :: Color -> Celda -> Celda
poner Azul (MkC n1 n2 n3 n4) = MkC (n1+1) n2 n3 n4
poner Negro (MkC n1 n2 n3 n4) = MkC n1 (n2+1) n3 n4
poner Rojo (MkC n1 n2 n3 n4) = MkC n1 n2 (n3+1) n4
poner Verde (MkC n1 n2 n3 n4) = MkC n1 n2 n3 (n4+1)

-- Prec. nroBolitas c > 0
sacar :: Color -> Celda -> Celda
sacar Azul (MkC n1 n2 n3 n4) = MkC (n1-1) n2 n3 n4
sacar Negro (MkC n1 n2 n3 n4) = MkC n1 (n2-1) n3 n4
sacar Rojo (MkC n1 n2 n3 n4) = MkC n1 n2 (n3-1) n4
sacar Verde (MkC n1 n2 n3 n4) = MkC n1 n2 n3 (n4-1)

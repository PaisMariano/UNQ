-------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------- Queue ---------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------

module Queue4Constante(Queue, emptyQ, isEmptyQ, queue, firstQ, deQueue, colaDeNumerosPares, colaDeNumerosImpares, colaDePersonas) where

import Auxiliares
import Listas

data Queue a = MkQ [a] LargoQueue deriving (Show) --Tipo de representacion: Listas de a

type LargoQueue = Int

--Invariante de representacin:
--Los elementos se encolan por el final y se desencolan por el principio.
--Considero que el primer elemento es el head, y el ultimo el last.
-- El largoQueue >= 0 y conincide con la cantidad de elementos de la lista.

--A:
emptyQ :: Queue a
emptyQ = MkQ [] 0


--B:
isEmptyQ :: Queue a -> Bool
isEmptyQ (MkQ _ n) = n == 0


--C:
queue :: a -> Queue a -> Queue a
queue x (MkQ xs n) = MkQ (xs ++ [x]) (n + 1) 


--D:
firstQ :: Queue a -> a
--Precondicion: La cola no puede estar vacia. N no puede ser 0.
firstQ (MkQ xs n) = if n == 0
							then error "La cola no puede estar vacia."
							else head xs 


--E:
deQueue :: Queue a -> Queue a
--Precondicion: La cola no puede ser vacia. N no puede ser 0
deQueue (MkQ xs n) = if n == 0
							then error "La cola no puede estar vacia."
							else MkQ (tail xs) (n - 1) 


--F:
lenQ :: Queue a -> Int
lenQ (MkQ _ n) = n
-------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------- Ejemplos --------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------

colaDeNumerosPares :: Queue Int
colaDeNumerosPares = MkQ [2,4,8,16,32,64] 6

colaDeNumerosImpares :: Queue Int
colaDeNumerosImpares = MkQ [1, 3, 5, 7, 9, 11] 6

colaDePersonas :: Queue Persona --Quizas no sea una decision de nombre muy feliz...
colaDePersonas = MkQ [adan, eva, cain, abel] 4
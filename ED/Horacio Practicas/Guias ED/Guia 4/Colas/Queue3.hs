-------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------- Queue ---------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------

module Queue3(Queue, emptyQ, isEmptyQ, queue, firstQ, deQueue, colaDeNumerosPares, colaDeNumerosImpares, colaDePersonas) where

import Auxiliares
import Listas

data Queue a = MkQ [a] deriving(Show) -- Tipo de representacion: Listas de a.


--Invariante de representacin:
--Los elementos se encolan por el principio y se desencolan por el final.
--Considero que el primer elemento es el last, y el ultimo el head.


--A:
emptyQ :: Queue a
emptyQ = MkQ []


--B:
isEmptyQ :: Queue a -> Bool
isEmptyQ (MkQ xs) = isEmpty xs 

--C:
queue :: a -> Queue a -> Queue a
queue x (MkQ xs) = MkQ (x : xs)


--D:
firstQ :: Queue a -> a
firstQ (MkQ xs) = if isEmpty xs
							then error "La cola debe contener al menos un elemento, no puede ser vacia."
							else last xs


--E:
deQueue :: Queue a -> Queue a
deQueue (MkQ xs) =  if isEmpty xs
							then error "La cola debe contener al menos un elemento, no puede ser vacia."
							else MkQ (init xs)

-------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------- Ejemplos --------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------

colaDeNumerosPares :: Queue Int
colaDeNumerosPares = MkQ [64, 32, 16, 8, 4, 2]

colaDeNumerosImpares :: Queue Int
colaDeNumerosImpares = MkQ [11, 9, 7, 5, 3, 1]

colaDePersonas :: Queue Persona --Quizas no sea una decision de nombre muy feliz...
colaDePersonas = MkQ [abel, cain, eva, adan]
-------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------- Queue ---------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------

module Queue2(Queue, emptyQ, isEmptyQ, queue, firstQ, deQueue, colaDeNumerosPares, colaDeNumerosImpares, colaDePersonas) where

import Auxiliares
import Listas

data Queue a = MkQ [a] deriving (Show) --Tipo de representacion: Listas de a

--Invariante de representacin:
--Los elementos se encolan por el final y se desencolan por el principio.
--Considero que el primer elemento es el head, y el ultimo el last.


--A:
emptyQ :: Queue a
emptyQ = MkQ []


--B:
isEmptyQ :: Queue a -> Bool
isEmptyQ (MkQ xs) = isEmpty xs


--C:
queue :: a -> Queue a -> Queue a
queue x (MkQ xs) = MkQ (xs ++ [x]) 


--D:
firstQ :: Queue a -> a
--Precondicion: La cola no puede estar vacia.
firstQ (MkQ xs) = if isEmpty xs
							then error "La cola no puede estar vacia."
							else head xs 


--E:
deQueue :: Queue a -> Queue a
deQueue (MkQ xs) = if isEmpty xs
							then error "La cola no puede estar vacia."
							else MkQ (tail xs)  

-------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------- Ejemplos --------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------

colaDeNumerosPares :: Queue Int
colaDeNumerosPares = MkQ [2,4,8,16,32,64]

colaDeNumerosImpares :: Queue Int
colaDeNumerosImpares = MkQ [1, 3, 5, 7, 9, 11]

colaDePersonas :: Queue Persona --Quizas no sea una decision de nombre muy feliz...
colaDePersonas = MkQ [adan, eva, cain, abel]
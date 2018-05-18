-------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------- Queue ---------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------

module Queue1(Queue, emptyQ, isEmptyQ, queue, firstQ, deQueue, colaDeNumerosPares, colaDeNumerosImpares, colaDePersonas) where

import Auxiliares
import Listas

data Queue a = EmptyQ | ConsQ a (Queue a) deriving (Show) --Tipo de representacion: Un tipo algebraico recursivo.

--Invariante de representacin:
--Los elementos se encolan por el final y se desencolan por el principio.
--Considero que el primer elemento es el siguiente al EmptQ -la cola vacia-,
--y el ultimo el que se encuentra mas hacia el exterior, es decir, a la derecha 
-- del ultimo ConsQ. -la cola con al menos un elemento-


--A:
emptyQ :: Queue a
emptyQ = EmptyQ


--B:
isEmptyQ :: Queue a -> Bool
isEmptyQ EmptyQ = True
isEmptyQ _ = False


--C:
queue :: a -> Queue a -> Queue a
queue x EmptyQ = ConsQ x (EmptyQ)
queue x cola = ConsQ x (cola)


--D:
firstQ :: Queue a -> a
firstQ EmptyQ = error "La cola debe contener al menos un elemento."
firstQ (ConsQ x EmptyQ) = x
firstQ (ConsQ _ cola) = firstQ cola


--E:
deQueue :: Queue a -> Queue a
deQueue EmptyQ = error "La cola debe contener al menos un elemento."
deQueue (ConsQ x EmptyQ) = EmptyQ
deQueue (ConsQ x cola) = queue x  (deQueue cola)


-------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------- Ejemplos --------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------

colaDeNumerosPares :: Queue Int
colaDeNumerosPares = ConsQ 2(ConsQ 4(ConsQ 8(ConsQ 16(ConsQ 32 EmptyQ))))

colaDeNumerosImpares :: Queue Int
colaDeNumerosImpares = ConsQ 1(ConsQ 3(ConsQ 5(ConsQ 7(ConsQ  9 EmptyQ))))


colaDePersonas :: Queue Persona
colaDePersonas = ConsQ abel (ConsQ cain (ConsQ eva (ConsQ adan (EmptyQ))))


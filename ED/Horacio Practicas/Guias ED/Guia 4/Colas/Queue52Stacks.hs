-------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------- Queue ---------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------

--Interfaz de Queue pero en lugar de una lista utilice dos stack.
--La estructura funciona de la siguiente manera. Llamemos a una de las stack
--fs (front stack) y a la otra bs (back stack). Quitaremos elementos a través de
--fs y agregaremos a través de bs.

module Queue52Stacks(Queue, emptyQ, isEmptyQ, queue, firstQ, deQueue, largoQ) where

--Invariante de representacion: 
--Se debe cumplir el invariante de representacion de ambas pilas.
--Si fs se encuentra vacía, entonces la cola se encuentra vacía.

import Auxiliares
import Listas
import ModuloStack1

data Queue a = MkQ (FrontStack a) (BackStack a) deriving(Eq, Show) --Fs y bs respectivamente

type FrontStack a = Stack a
type BackStack a = Stack a 
--A:
emptyQ :: Queue a
emptyQ = MkQ emptyS emptyS 

--B:
isEmptyQ :: Queue a -> Bool
isEmptyQ (MkQ fs bs) = isEmptyS fs


--C:
queue :: a -> Queue a -> Queue a
queue x (MkQ fs bs) = MkQ fs (push x bs) 


--D:
firstQ :: Queue a -> a
--Precondicion: La cola no puede estar vacia. N no puede ser 0.
firstQ (MkQ fs bs) = if isEmptyS fs
							then error "La cola esta vacia."
							else top fs


--E:
deQueue :: Queue a -> Queue a
--Precondicion: La cola no puede ser vacia. N no puede ser 0
deQueue (MkQ fs bs) = if isEmptyS fs
							then error "La cola no puede estar vacia."
							else MkQ (pop fs) bs


--F:
largoQ :: Queue a -> Int
largoQ (MkQ fs bs) = sizeS fs + sizeS bs


module ImplementacionQueue4(Queue, emptyQ, isEmptyQ, queue, dequeue, firstQ) where

import Auxiliares
import Listas 
import ImplementacionStack2
                
data Queue a = MkQ4 (FrontStack a) (BackStack a)  deriving(Show)

type FrontStack a = Stack a
type BackStack a = Stack a

-- Invariante de representacion
-- si front esta vacia no hay nada en back


--O(1)
emptyQ :: Queue a
emptyQ = MkQ4 emptyS emptyS


--O(1)
isEmptyQ :: Queue a -> Bool
isEmptyQ (MkQ4 fs bs) = isEmptyS fs


--O(1)
firstQ :: Queue a -> a
firstQ (MkQ4 fs bs) = top fs


--O(1)
queue :: a -> Queue a -> Queue a
queue x (MkQ4 fs bs) = if isEmptyS fs
							then MkQ4  (push x fs) bs
							else MkQ4 fs (push x bs)


--O(n) En el peor de los casos vuelca bs en fs. Siendo n el largo de bs
dequeue :: Queue a -> Queue a
dequeue (MkQ4 fs bs) = if isEmptyS fs
							then error "La pila esta vacia."
							else 
								if cantElementos fs == 1
											then MkQ4 (volcar (pop fs) bs) emptyS
											else MkQ4 (pop fs) bs


--O(n)
cantElementos :: Stack a -> Int
cantElementos pila = if isEmptyS pila
									then 0
									else 1 + cantElementos (pop pila)

--O(n)
volcar :: Stack a -> Stack a -> Stack a
volcar pila1 pila2 = if isEmptyS pila2
								then pila1
								else volcar (push (top pila2) pila1) (pop pila2)
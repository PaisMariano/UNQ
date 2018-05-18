module ImplementacionQueue1(Queue, emptyQ, isEmptyQ, firstQ, queue, dequeue, colaPar, colaImpar, colaNombres)where

import Listas
import Auxiliares

data Queue a = MkQ [a] deriving(Show)--Tipo de representacion: [a]

--Invariante de representacion:
-- El primer elemento de la cola es el ultimo de la lista. Se desencola por el principio de la lista. 

--Una Queue es un tipo abstracto de datos de naturaleza FIFO (first in, first out). 
--Esto significa que los elementos salen en el orden con el que entraron, es decir, el que se agrega primero es el primero en salir 

--O(1)
emptyQ :: Queue a
--Crea una cola vacía.
emptyQ = MkQ []


--O(1)
isEmptyQ :: Queue a -> Bool
--Dada una cola indica si la cola está vacía.
isEmptyQ (MkQ xs) = isEmpty xs


--O(1)
queue :: a -> Queue a -> Queue a
--Dados un elemento y una cola, agrega ese elemento a la cola.
queue x (MkQ xs) = MkQ (x : xs)


--O(n)
firstQ :: Queue a -> a
--Dada una cola devuelve el primer elemento de la cola.
firstQ (MkQ []) = error "La cola esta vacia."
firstQ (MkQ xs) = last xs


--O(n)
dequeue :: Queue a -> Queue a
--Dada una cola la devuelve sin su primer elemento.
dequeue (MkQ []) = error "La cola esta vacia."
dequeue (MkQ xs) = MkQ (init xs)


colaPar :: Queue Int
colaPar = MkQ [128, 64, 32, 16, 8, 4, 2, 0]

colaImpar :: Queue Int
colaImpar = MkQ [15, 13, 11, 9, 7, 5, 3, 1]

colaNombres :: Queue String
colaNombres = MkQ ["Atreyu", "Cosme Fulanito", "Mr. X", "Mefistoteles", "Marco Aurelio", "Melquiades", "Fausto", "Aureliano"]
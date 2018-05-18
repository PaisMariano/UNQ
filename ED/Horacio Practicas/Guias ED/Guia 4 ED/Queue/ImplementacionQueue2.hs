module ImplementacionQueue2(Queue, emptyQ, isEmptyQ, firstQ, queue, dequeue, colaPar, colaImpar, colaNombres)where

import Listas
import Auxiliares

data Queue a = MkQ2 [a] deriving(Show)--Tipo de representacion: [a]

--Invariante de representacion:
-- El primer elemento de la cola es el primero de la lista. Se desencola por el principio de la lista 

--Una Queue es un tipo abstracto de datos de naturaleza FIFO (first in, first out). 
--Esto significa que los elementos salen en el orden con el que entraron, es decir, el que se agrega primero es el primero en salir 


--O(1)
emptyQ :: Queue a
--Crea una cola vacía.
emptyQ = MkQ2 []


--O(1)
isEmptyQ :: Queue a -> Bool
--Dada una cola indica si la cola está vacía.
isEmptyQ (MkQ2 xs) = isEmpty xs


--O(n)
queue :: a -> Queue a -> Queue a
--Dados un elemento y una cola, agrega ese elemento a la cola.
queue x (MkQ2 xs) = MkQ2 (xs ++ [x])


--O(1)
firstQ :: Queue a -> a
--Dada una cola devuelve el primer elemento de la cola.
firstQ (MkQ2 []) = error "La cola esta vacia."
firstQ (MkQ2 xs) = head xs


-- O(1)
dequeue :: Queue a -> Queue a
--Dada una cola la devuelve sin su primer elemento.
dequeue (MkQ2 []) = error "La cola esta vacia."
dequeue (MkQ2 xs) = MkQ2 (tail xs)


colaPar :: Queue Int
colaPar = MkQ2 [0, 2, 4, 8, 16, 32, 64, 128]

colaImpar :: Queue Int
colaImpar = MkQ2 [1, 3, 5, 7, 9, 11, 13, 15]

colaNombres :: Queue String
colaNombres = MkQ2 ["Aureliano", "Fausto", "Melquiades", "Marco Aurelio", "Mefistoteles", "Mr. X", "Cosme Fulanito", "Atreyu"]
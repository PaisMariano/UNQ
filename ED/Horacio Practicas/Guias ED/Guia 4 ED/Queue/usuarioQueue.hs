import ImplementacionQueue2

import Auxiliares

--Una Queue es un tipo abstracto de datos de naturaleza FIFO (first in, first out). 
--Esto significa que los elementos salen en el orden con el que entraron, es decir, el que se agrega primero es el primero en salir 

--emptyQ :: Queue a
--Crea una cola vacía.

--isEmptyQ :: Queue a -> Bool
--Dada una cola indica si la cola está vacía.

--queue :: a -> Queue a -> Queue a
--Dados un elemento y una cola, agrega ese elemento a la cola.

--firstQ :: Queue a -> a
--Dada una cola devuelve el primer elemento de la cola.

--dequeue :: Queue a -> Queue a
--Dada una cola la devuelve sin su primer elemento.


largoQ :: Queue a -> Int
largoQ cola = if isEmptyQ cola
						then 0
						else 1 + largoQ (dequeue cola) 


atender :: Queue String -> [String]
atender cola = if isEmptyQ cola
						then []
						else firstQ cola : atender (dequeue cola)

unirQ :: Queue a -> Queue a -> Queue a
unirQ cola1 cola2 = if isEmptyQ cola2
							then cola1
							else unirQ (queue (firstQ cola2) cola1)(dequeue cola2)
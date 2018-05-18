module ImplementacionQueue3(Queue, emptyQ, isEmptyQ, firstQ, queue, dequeue, colaPar, colaImpar, colaNombres)where

import Listas
import Auxiliares

data Queue a = MkQ3 [a] Largo deriving(Show)--Tipo de representacion: [a]
type Largo = Int

--Invariante de representacion:
-- El primer elemento de la cola es el primero de la lista. Se desencola por el principio de la lista 
--Largo coincide con la cantidad de elementos de la cola. largo >= 0

--Una Queue es un tipo abstracto de datos de naturaleza FIFO (first in, first out). 
--Esto significa que los elementos salen en el orden con el que entraron, es decir, el que se agrega primero es el primero en salir 


--O(1)
emptyQ :: Queue a
--Crea una cola vacía.
emptyQ = MkQ3 [] 0


--O(1)
isEmptyQ :: Queue a -> Bool
--Dada una cola indica si la cola está vacía.
isEmptyQ (MkQ3 _ n) = esCero n


--O(1)
esCero :: Int -> Bool
esCero 0 = True
esCero _ = False


--O(n)
queue :: a -> Queue a -> Queue a
--Dados un elemento y una cola, agrega ese elemento a la cola.
queue x (MkQ3 xs n) = MkQ3 (xs ++ [x]) (sumarUno n)

--O(1)
sumarUno :: Int -> Int
sumarUno n = n + 1


--O(1)
firstQ :: Queue a -> a
--Dada una cola devuelve el primer elemento de la cola.
firstQ (MkQ3 [] _) = error "La cola esta vacia."
firstQ (MkQ3 xs _) = head xs


--O(1)
dequeue :: Queue a -> Queue a
--Dada una cola la devuelve sin su primer elemento.
dequeue (MkQ3 [] _) = error "La cola esta vacia."
dequeue (MkQ3 xs n) = MkQ3 (tail xs) (restarUno n)

--O(1)
restarUno :: Int -> Int
restarUno x = x - 1

colaPar :: Queue Int
colaPar = MkQ3 [0, 2, 4, 8, 16, 32, 64, 128] 8

colaImpar :: Queue Int
colaImpar = MkQ3 [1, 3, 5, 7, 9, 11, 13, 15] 8

colaNombres :: Queue String
colaNombres = MkQ3 ["Aureliano", "Fausto", "Melquiades", "Marco Aurelio", "Mefistoteles", "Mr. X", "Cosme Fulanito", "Atreyu"] 8
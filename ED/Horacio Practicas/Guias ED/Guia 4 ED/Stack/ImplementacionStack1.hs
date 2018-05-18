module ImplementacionStack1(Stack, emptyS, isEmptyS, push, pop, top, pilaPar, pilaImpar, arbolPrueba)where

import Auxiliares
import Listas

data Stack a = MkSt [a] deriving(Show)--Tipo de Representacion: [a]

--Invariante de representacion:
-- No hay.
-- Una Stack es un tipo abstracto de datos de naturaleza LIFO (last in, first out). 
--Esto significa que los últimos elementos agregados a la estructura son los
--primeros en salir.
--Se considera al primero en entrar el last de la lista y al ultimo el head


--O(1)
emptyS :: Stack a
--Crea una pila vacía.
emptyS = MkSt [] 


--O(1)
isEmptyS :: Stack a -> Bool
--Dada una pila indica si está vacía.
isEmptyS (MkSt xs) = isEmpty xs


--O(1)
push :: a -> Stack a -> Stack a
--Dados un elemento y una pila, agrega el elemento a la pila.
push x (MkSt xs) = MkSt (x : xs) 


--O(1)
top :: Stack a -> a
--Dada un pila devuelve el elemento del tope de la pila.
top (MkSt []) = error "La pila esta vacia."
top (MkSt xs) = head xs


--O(1)
pop :: Stack a -> Stack a
--Dada una pila devuelve la pila sin el primer elemento.
pop (MkSt []) = error "La pila esta vacia."
pop (MkSt xs) = MkSt (tail xs)

pilaPar :: Stack Int
pilaPar = MkSt [128, 64, 32, 16, 8, 4, 2, 0]

pilaImpar :: Stack Int
pilaImpar = MkSt [15, 13, 11, 9, 7, 5, 3, 1]

arbolPrueba :: Tree Int
arbolPrueba = NodeT 2 (NodeT 4 (NodeT 8(EmptyT) (EmptyT)) (NodeT 8 (EmptyT) (EmptyT))) (NodeT 4 (NodeT 8 (EmptyT) (EmptyT)) (NodeT 8 (EmptyT) (EmptyT)))
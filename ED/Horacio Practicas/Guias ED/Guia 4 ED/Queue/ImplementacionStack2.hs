module ImplementacionStack2(Stack, emptyS, isEmptyS, push, pop, top, pilaPar, pilaImpar, arbolPrueba)where

import Auxiliares
import Listas

data Stack a = MkSt2 [a] deriving(Show)--Tipo de Representacion: [a]

--Invariante de representacion:
-- No hay.
-- Una Stack es un tipo abstracto de datos de naturaleza LIFO (last in, first out). 
--Esto significa que los últimos elementos agregados a la estructura son los
--primeros en salir.
--Se considera al primero en entrar el head de la lista y al ultimo el last

emptyS :: Stack a
--Crea una pila vacía.
emptyS = MkSt2 [] 


isEmptyS :: Stack a -> Bool
--Dada una pila indica si está vacía.
isEmptyS (MkSt2 xs) = isEmpty xs


push :: a -> Stack a -> Stack a
--Dados un elemento y una pila, agrega el elemento a la pila.
push x (MkSt2 xs) = MkSt2 (xs ++ [x]) 

top :: Stack a -> a
--Dada un pila devuelve el elemento del tope de la pila.
top (MkSt2 []) = error "La pila esta vacia."
top (MkSt2 xs) = last xs

pop :: Stack a -> Stack a
--Dada una pila devuelve la pila sin el primer elemento.
pop (MkSt2 []) = error "La pila esta vacia."
pop (MkSt2 xs) = MkSt2 (init xs)

pilaPar :: Stack Int
pilaPar = MkSt2 [0, 2, 4, 8, 16, 32, 64, 128]

pilaImpar :: Stack Int
pilaImpar = MkSt2 [1, 3, 5, 7, 9, 11, 13, 15]

arbolPrueba :: Tree Int
arbolPrueba = NodeT 2 (NodeT 4 (NodeT 8(EmptyT) (EmptyT)) (NodeT 8 (EmptyT) (EmptyT))) (NodeT 4 (NodeT 8 (EmptyT) (EmptyT)) (NodeT 8 (EmptyT) (EmptyT)))
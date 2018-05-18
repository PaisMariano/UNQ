module ImplementacionStack3(Stack, emptyS, isEmptyS, push, pop, top, pilaPar, pilaImpar, arbolPrueba)where

import Auxiliares
import Listas

data Stack a = MkSt3 [a] [a] CantElementos deriving(Show)--Tipo de Representacion: [a]

type CantElementos = Int

--Invariante de representacion:
-- La primer elemento de la segunda lista coincide con el maximo elemento de la pila.
-- Una Stack es un tipo abstracto de datos de naturaleza LIFO (last in, first out). 
--Esto significa que los últimos elementos agregados a la estructura son los
--primeros en salir.
--Se considera al primero en entrar el head de la lista y al ultimo el last


--O(1)
emptyS :: Stack a
--Crea una pila vacía.
emptyS = MkSt3 [] [] 0


--O(1)
isEmptyS :: Stack a -> Bool
--Dada una pila indica si está vacía.
isEmptyS (MkSt3 xs ys n) = n == 0


--O(n)
push ::Ord a => a -> Stack a -> Stack a
--Dados un elemento y una pila, agrega el elemento a la pila.
push x (MkSt3 xs ys n) = MkSt3 (xs ++ [x]) ((max x (head ys)) : ys) (n + 1) 


--O(n)
top :: Stack a -> a
--Dada un pila devuelve el elemento del tope de la pila.
top (MkSt3 [] [] 0) = error "La pila esta vacia."
top (MkSt3 xs _ _) = last xs


--O(n)
pop :: Stack a -> Stack a
--Dada una pila devuelve la pila sin el primer elemento.
pop (MkSt3 _ _ 0) = error "La pila esta vacia."
pop (MkSt3 [x] [y] 1) = MkSt3 [] [] 0
pop (MkSt3 xs ys n) = MkSt3 (init xs) (init ys) (n - 1)


--O(1)
maxS :: Ord a => Stack a -> a
maxS (MkSt3 [] [] 0) = error "La pila no posee un elemento minimo"
maxS (MkSt3 xs ys n) = head ys


pilaPar :: Stack Int
pilaPar = MkSt3 [0, 2, 4, 8, 16, 32, 64, 128] [128, 64, 32, 16, 8, 4, 2, 0] 8

pilaImpar :: Stack Int
pilaImpar = MkSt3 [1, 3, 5, 7, 9, 11, 13, 15] [15, 13, 11, 9, 7, 5, 3, 1] 8

arbolPrueba :: Tree Int
arbolPrueba = NodeT 2 (NodeT 4 (NodeT 8(EmptyT) (EmptyT)) (NodeT 8 (EmptyT) (EmptyT))) (NodeT 4 (NodeT 8 (EmptyT) (EmptyT)) (NodeT 8 (EmptyT) (EmptyT)))
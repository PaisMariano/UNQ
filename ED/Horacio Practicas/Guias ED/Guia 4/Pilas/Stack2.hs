--------------------------------------------------------------------------------------------------------------
----------------------------------------------------- Stack --------------------------------------------------
--------------------------------------------------------------------------------------------------------------

module Stack2(Stack, emptyS, isEmptyS, push, top, pop, pilaPar, pilaImpar)where

import Listas
import Auxiliares

data Stack a = MkSt [a] deriving(Show)--Tipo de representacion listas de a

--Invariante de representacion:
--No hay.
--El ultimo elemento ingresado, es el primero en salir. 
-- Consideramos al ultimo ingresado como el last de la lista, 
--y ultimo al head.

emptyS :: Stack a
--Crea una pila vacía.
emptyS = MkSt []

isEmptyS :: Stack a -> Bool
--Dada una pila indica si está vacía.
isEmptyS (MkSt xs) = isEmpty xs

push :: a -> Stack a -> Stack a
--Dados un elemento y una pila, agrega el elemento a la pila.
push x (MkSt xs) = MkSt (xs ++ [x])

top :: Stack a -> a
--Dada un pila devuelve el elemento del tope de la pila.
top (MkSt xs) = if isEmpty xs
						then error "La pila debe contener al menos un elemento, no puede ser vacia."
						else last xs

pop :: Stack a -> Stack a
--Dada una pila devuelve la pila sin el primer elemento. 
pop (MkSt xs) = MkSt (init xs)


---------------------------------------------------------------------------------------------------
------------------------------------------ Ejemplos -----------------------------------------------
---------------------------------------------------------------------------------------------------

pilaPar :: Stack Int 
pilaPar = MkSt [64, 32, 16, 8, 4, 2]

pilaImpar :: Stack Int 
pilaImpar = MkSt [11, 9, 7, 5, 3, 1]
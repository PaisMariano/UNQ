--------------------------------------------------------------------------------------------------------------
----------------------------------------------------- Stack --------------------------------------------------
--------------------------------------------------------------------------------------------------------------

module Stack1 (Stack, emptyS, isEmptyS, push, top, pop, pilaPar, pilaImpar)where

import Listas
import Auxiliares

data Stack a = MkSt [a] deriving(Show)--Tipo de representacion listas de a

--Invariante de representacion:
--No hay.
--El ultimo elemento ingresado, es el primero en salir. 
-- Consideramos al ultimo ingresado como el head de la lista, 
--y ultimo al last

emptyS :: Stack a
--Crea una pila vacía.
emptyS = MkSt []

isEmptyS :: Stack a -> Bool
--Dada una pila indica si está vacía.
isEmptyS (MkSt xs) = isEmpty xs

push :: a -> Stack a -> Stack a
--Dados un elemento y una pila, agrega el elemento a la pila.
push x (MkSt xs) = MkSt (x : xs)

top :: Stack a -> a
--Dada un pila devuelve el elemento del tope de la pila.
top (MkSt xs) = if isEmpty xs
						then error "La pila debe contener al menos un elemento, no puede ser vacia."
						else head xs

pop :: Stack a -> Stack a
--Dada una pila devuelve la pila sin el primer elemento. 
--Precondicion: La pila no puede ser vacia.
pop (MkSt xs) = if isEmpty xs
					then error "La pila no puede estar vacia."
					else MkSt (tail xs)


---------------------------------------------------------------------------------------------------
------------------------------------------ Ejemplos -----------------------------------------------
---------------------------------------------------------------------------------------------------

pilaPar :: Stack Int 
pilaPar = MkSt [2,4,8,16,32,64]

pilaImpar :: Stack Int 
pilaImpar = MkSt [1,3,5,7,9,11] 
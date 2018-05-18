--------------------------------------------------------------------------------------------------------------
----------------------------------------------------- Stack --------------------------------------------------
--------------------------------------------------------------------------------------------------------------

module ModuloStack1 (Stack, emptyS, push, isEmptyS, top, pop, pilaPar, pilaImpar, sizeS)where

import Listas
import Auxiliares

data Stack a = MkSt [a] N deriving(Eq, Show)--Tipo de representacion listas de a

type N = Int

--Invariante de representacion:
--N >= 0 y conincide con el largo de la lista.
--El ultimo elemento ingresado, es el primero en salir. 
--Consideramos al ultimo ingresado como el head de la lista, 
--y ultimo al last

emptyS :: Stack a
--Crea una pila vacía.
emptyS = MkSt [] 0 


isEmptyS :: Stack a -> Bool
--Dada una pila indica si está vacía.
isEmptyS (MkSt xs n) = n == 0


push :: a -> Stack a -> Stack a
--Dados un elemento y una pila, agrega el elemento a la pila.
push x (MkSt xs n ) = MkSt (x : xs) (n + 1)

top :: Stack a -> a
--Dada un pila devuelve el elemento del tope de la pila.
top (MkSt xs n) = if n == 0
						then error "La pila debe contener al menos un elemento, no puede ser vacia."
						else head xs 

pop :: Stack a -> Stack a
--Dada una pila devuelve la pila sin el primer elemento. 
pop (MkSt xs n) = if n == 0
						then error "La pila no puede estar vacia."
						else MkSt (tail xs) (n - 1)

sizeS :: Stack a -> Int
sizeS (MkSt xs n) = n 
---------------------------------------------------------------------------------------------------
------------------------------------------ Ejemplos -----------------------------------------------
---------------------------------------------------------------------------------------------------

pilaPar :: Stack Int 
pilaPar = MkSt [2,4,8,16,32,64] 6

pilaImpar :: Stack Int 
pilaImpar = MkSt [1,3,5,7,9,11] 6
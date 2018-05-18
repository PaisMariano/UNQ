--------------------------------------------------------------------------------------------------------------
----------------------------------------------------- Stack --------------------------------------------------
--------------------------------------------------------------------------------------------------------------

module Stack3 (Stack, emptyS, isEmptyS, push, top, pop, maxS, pilaPar, pilaImpar)where

import Listas
import Auxiliares
import MaybeModulo

data Stack a = MkSt [a] Max deriving(Show)--Tipo de representacion listas de a

type Max = Maybe 

--Invariante de representacion:
--El ultimo elemento ingresado, es el primero en salir. 
--Consideramos al ultimo ingresado como el head de la lista y al ultimo como el last.
--Si la lista es vacia el Max es Nothing, caso contrario Just (maximo de la lista).

emptyS :: Stack a
--Crea una pila vacía.
emptyS = MkSt [] Nothing

isEmptyS :: Stack a -> Bool
--Dada una pila indica si está vacía.
isEmptyS (MkSt xs m) = isEmpty xs && isNothing m

push :: a -> Stack a -> Stack a
--Dados un elemento y una pila, agrega el elemento a la pila.
push x (MkSt xs m) = MkSt (x : xs) (recalcularMaximo (x:xs)) 

top :: Stack a -> a
--Dada un pila devuelve el elemento del tope de la pila.
top (MkSt xs _) = if isEmpty xs
						then error "La pila debe contener al menos un elemento, no puede ser vacia."
						else head xs

pop :: Stack a -> Stack a
--Precondicion: La pila no puede ser vacia.
--Dada una pila devuelve la pila sin el primer elemento. 
pop (MkSt xs m) = if n == 0 
						then error "No se puede quitar elementos de una pila vacia." 
						else MkSt (tail xs) (recalcularMaximo (tail xs))


maxS :: Ord a => Stack a -> a
--Devuelve el elemento máximo de la pila.
--Precondicion: La pila debe tener un maximo.
maxS (MkSt xs m) = if isNothing m
							then error "La pila no posee un maximo."
							else fromJust m

---------------------------------------------------------------------------------------------------
------------------------------------------ Ejemplos -----------------------------------------------
---------------------------------------------------------------------------------------------------

pilaPar :: Stack Int 
pilaPar = MkSt [2,4,8,16,32,64]

pilarImpar :: Stack Int 
pilaImpar = MkSt [1,3,5,7,9,11] 
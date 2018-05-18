--------------------------------------------------------------------------------------------------------------
----------------------------------------------------- Stack --------------------------------------------------
--------------------------------------------------------------------------------------------------------------

module Stack3ConMaximo(Stack, emptyS, isEmptyS, push, top, pop, maxS, pilaPar, pilaImpar)where


import Listas
import Auxiliares
import MaybeModulo


data Stack a = MkSt [a] NumElemen (Max a) deriving(Show)--Tipo de representacion listas de a

type NumElemen = Int
type Max a = Maybe a


--Invariante de representacion:
--El ultimo elemento ingresado, es el primero en salir. 
--Consideramos al ultimo ingresado como el head de la lista y al ultimo como el last.
--Si la lista es vacia el Max es Nothing, caso contrario Just (maximo de la lista).
-- NumElemen coincide con la cantidad de elementos de la lista, y es >= 0


emptyS :: Stack a
--Crea una pila vacía.
emptyS = MkSt [] 0 Nothing


isEmptyS :: Stack a -> Bool
--Dada una pila indica si está vacía.
isEmptyS (MkSt xs n m) = n == 0 


push :: Ord a =>a -> Stack a -> Stack a
--Dados un elemento y una pila, agrega el elemento a la pila.
push x (MkSt xs n m) = if n == 0
								then MkSt [x] 1 (Just x)
 								else MkSt (x : xs) (n + 1) (Just (max x (fromJust m))) 


top :: Stack a -> a
--Dada un pila devuelve el elemento del tope de la pila.
top (MkSt xs n _) = if n == 0
						then error "La pila debe contener al menos un elemento, no puede ser vacia."
						else head xs


pop ::Ord a => Stack a -> Stack a
--Precondicion: La pila no puede ser vacia.
--Dada una pila devuelve la pila sin el primer elemento. 
pop (MkSt xs n m) = if n == 0 
						then error "No se puede quitar elementos de una pila vacia." 
						else MkSt (tail xs) (n - 1) (recalcularMaximo (tail xs))


maxS :: Ord a => Stack a -> a
--Devuelve el elemento máximo de la pila.
--Precondicion: La pila debe tener un maximo.
maxS (MkSt xs n m) = if n == 0
							then error "La pila no posee un maximo."
							else fromJust m

---------------------------------------------------------------------------------------------------
------------------------------------------ Ejemplos -----------------------------------------------
---------------------------------------------------------------------------------------------------

pilaPar :: Stack Int 
pilaPar = MkSt [2,4,8,16,32,64] 6 (Just 64)

pilaImpar :: Stack Int 
pilaImpar = MkSt [1,3,5,7,9,11] 6 (Just 11)
--------------------------------------------------------------------------------------------------------------
------------------------------------------------ Usuario Stack -----------------------------------------------
--------------------------------------------------------------------------------------------------------------

import Stack2
import Auxiliares 

apilar :: [a] -> Stack a
--Dada una lista devuelve una pila sin alterar el orden de los elementos.
apilar [x] = push x emptyS
apilar (x : xs) = push x (apilar xs)


desapilar :: Stack a -> [a]
--La pila no puede ser vacia.
--Dada una pila devuelve una lista sin alterar el orden de los elementos.
desapilar pila = 
				if isEmptyS pila
						then []
						else (top pila) : desapilar (pop pila) 


treeToStack :: Tree a -> Stack a
--Dado un árbol devuelve una pila con los elementos apilados inorde: I - R - D. 
treeToStack EmptyT = emptyS
treeToStack (NodeT x EmptyT EmptyT) = push x emptyS
treeToStack (NodeT x ri rd) = unirStacks (treeToStack ri) (push x (treeToStack rd))


unirStacks :: Stack a -> Stack a -> Stack a
unirStacks pila1 pila2 = if isEmptyS pila1
									then pila2
									else unirStacks (pop pila1) (push (top pila1) pila2)


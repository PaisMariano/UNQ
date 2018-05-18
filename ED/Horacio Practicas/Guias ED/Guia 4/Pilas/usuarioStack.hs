--------------------------------------------------------------------------------------------------------------
------------------------------------------------ Usuario Stack -----------------------------------------------
--------------------------------------------------------------------------------------------------------------

import Stack1
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


--Feo pero funcional.
balanceado :: String -> Bool
balanceado cs = (cantidadDe '(' (laPila cs)) == (cantidadDe ')' (laPila cs))  

laPila :: String -> Stack Char
laPila [] = emptyS
laPila [c] = push c emptyS
laPila (c : cs) = if (c == '(' || c == ')')
									then push c (laPila cs)
									else laPila cs


cantidadDe :: Eq a => a -> Stack a -> Int
cantidadDe x pila = if isEmptyS pila
							then 0
							else 
								if (top pila == x)
											then 1 + cantidadDe x (pop pila)
											else cantidadDe x (pop pila)


balanceado2 :: String -> Bool
balanceado2 cs = isEmptyS (laPila2 cs)  

laPila2 :: String -> Stack Char
laPila2 [c] = push c emptyS
laPila2 (c : cs) = if c == '('
						then push c (laPila2 cs)
						else 
							if c ==')'
									then pop (laPila2 cs)
									else laPila2 cs



import ImplementacionStack1

import Auxiliares
import Listas

--emptyS :: Stack a
--Crea una pila vacía.

--isEmptyS :: Stack a -> Bool
--Dada una pila indica si está vacía.

--push :: a -> Stack a -> Stack a
--Dados un elemento y una pila, agrega el elemento a la pila.

--top :: Stack a -> a
--Dada un pila devuelve el elemento del tope de la pila.

--pop :: Stack a -> Stack a
--Dada una pila devuelve la pila sin el primer elemento.


apilar :: [a] -> Stack a
--Dada una lista devuelve una pila sin alterar el orden de los elementos.
apilar [] = emptyS
apilar [x] = push x emptyS
apilar (x : xs) = push x (apilar xs) --Queda al reves la pila que la lista


desapilar :: Stack a -> [a]
--Dada una pila devuelve una lista sin alterar el orden de los elementos.
desapilar pila = if isEmptyS pila
						then []
						else top pila : desapilar (pop pila)


treeToStack :: Tree a -> Stack a
--Dado un árbol devuelve una pila con los elementos apilados inorde
--treeToStack EmptyT = ...
--treeToStack (NodeT x ri  rd) = ... treeToStack ... treeToStack ...
treeToStack EmptyT = emptyS
treeToStack (NodeT x ri rd) = unirS (treeToStack ri) (push x (treeToStack rd))

unirS :: Stack a -> Stack a -> Stack a
unirS stack1 stack2 = if isEmptyS stack2
								then stack1
								else unirS (push (top stack2) stack1) (pop stack2)

balanceado :: String -> Bool --desafío
--Toma un string que representa una expresión aritmética, por ejemplo
--"(2 + 3) x 2", y verifica que la cantidad de paréntesis que abren se
--corresponda con los que cierran. Para hacer esto utilice una stack.
--Cada vez que encuentra un paréntesis que abre, lo apila. Si encuentra
--un paréntesis que cierra desapila un elemento. Si al terminar de
--recorrer el string se desapilaron tantos elementos como los que se
--apilaron, ni más ni menos, entonces los paréntesis están balaceados.
--Pista: recorra una stack pasada por parámetro a una subtarea.
balanceado str = isEmptyS (pasarAPila str)

pasarAPila :: [Char] -> Stack Char
pasarAPila "" = emptyS
pasarAPila (x : xs) = if x == '(' 
							then push x (pasarAPila xs)
							else 
								if x == ')' 
									then pop (pasarAPila xs)
									else pasarAPila xs




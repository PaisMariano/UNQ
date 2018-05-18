module Queue1 where

data Queue a = MkQ [a]

emptyQ :: Queue a                --Crea una cola vacía.
emptyQ = MkQ []

isEmptyQ :: Queue a -> Bool      --Dada una cola indica si la cola está vacía.
isEmptyQ (MkQ xs) = if (length xs) == 0
							then True
							else False
							
queue :: a -> Queue a -> Queue a --Dados un elemento y una cola, agrega ese elemento a la cola.
queue e (MkQ xs) = xs ++ [e]

--La cola no puede estar vacia.
firstQ :: Queue a -> a           --Dada una cola devuelve el primer elemento de la cola.
firstQ (MkQ xs) = last(xs)

--La cola no puede estar vacia y no hay repetidos
dequeue :: Queue a -> Queue      --Dada una cola la devuelve sin su primer elemento
dequeue (MkQ xs) = quitarElem last(xs) xs


quitarElem :: Eq a => a -> [a] -> [a]
quitarElem e [] = []
quitarElem e (x:xs) = if e == x
							then quitarElem e xs
							else x : (quitarElem e xs)





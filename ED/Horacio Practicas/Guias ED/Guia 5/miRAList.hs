module RAList(emptyRAL, isEmptyRAL, add, get, set, last, lengthRAL, minRAL, minToMax) where

import Heap --on BST
import BST

-- Invariantes de Representación
-- Sea MkR n m h:
-- 1. n es igual al maximo de las claves de m + 1
-- 2. Las claves son numeros positivos
-- 3. n es un numero positivo
-- 4. Las claves van de 0 a (n-1)
-- 5. h tiene todos los valores de m

data RAList = MkR Int (Map Int a) (Heap a)

-- Propósito: devuelve una RAList vacía
emptyRAL :: RAList a -- O(1)
emptyRAL  = MkR 0 emptyM emptyH

-- Propósito: indica si la RAList está vacía
isEmptyRAL :: RALIst a -> Bool -- O(1)
isEmptyRAL (MkR n map heap) = isEmptyH heap  

-- Propósito: agrega un elemento al final dela RAList
add :: Ord a => a -> RAList a -> RAList a -- O(log n)
add x (MkR n map heap)  = MkR (n+1) (assocM map n x) (insertH x heap) 

-- Propósito: devuelve el elemento en la posicion indicada
-- El índice tiene que ser válido
get :: Ord a => Int -> RAList a -> a -- O(log n)
get n (MkR n map heap) = if n == 0
								then findMin heap
								else 

get' :: Ord a => Int -> Heap a -> a
get' 0 heap = findMin heap
get n heap = if n < 0
					then error "El ingresado no es un numero valido."
					else 
						if isEmptyH heap
								then error "No se cumple la precondicion"
								else
									if n == 0
										then findMin heap
										else get (n-1) (deleteMin heap) 


-- Propósito: reemplaza el elemento en la posicion indicada
-- El índice tiene que ser válido
set :: Int -> a -> RAList a -> RAList a -- O(n . log n)

-- Propósito: devuelve el primer elemento
first :: RAList a -> a -- O(log n)

-- Propósito: devuelve el último elemento
last :: RAList a -> a -- O(log n)

-- Propósito: devuelve la longitud
lengthRAL :: RAList a -> Int -- O(1)
lengthRAL (MkR n map heap) = n - 1

-- Propósito: devuelve el mínimo
minRAL :: Ord a => RAList a -> a -- O(log n)

-- Propósito: devuelve los elementos ordenados de menor a mayor
minToMax :: Ord a => RAList a -> [a] -- O(n . log n)

-- Propósito: elimina el último elemento
init :: RAList a -> RAList a -- O(n . log n)

-- Propósito: agrega un elemento al principio
cons :: a -> RAList a -> RAList a -- O(n . log n)

-- Propósito: borra el primer elemento
tail :: RAList a -> RAList a -- O(n . log n)

-- SUBTAREA
-- El elemento está en la heap
deleteX :: Ord a => a -> Heap a -> Heap a
deleteX x h = 
	if  x == findMin h
		then deleteMin h
		else insertH (findMin h) (deleteX x (deleteMin h))

data Tree a = EmptyT | NodeT a (Tree a) (Tree a)
type Camino = [Dir]
data Dir = Izq | Der
data RAL a = MKR (Tree a) Camino

{- INV. REPRESENTACION: 
	-La lista de direcciones contiene el camino para poder llegar a la posicion donde se va a agregar el proximo elemento.
	-

-}

nil :: RAL a
nil = MKR (EmptyT) []
--Devuelve una RAL vacía.

isNil :: RAL a -> Bool
isNil (MKR EmptyT []) = True
isNil _               = False
--Indica si la RAL est´a vac´ıa.

--Precond: La Ral no es vacia. 
last :: RAL a -> a
last (MKR t c) = lastT (prev(c)) t
--Devuelve el último elemento agregado.

lastT :: Camino -> Tree a -> Tree a
lastT c EmptyT = error : "No se puede usar el tree vacio"
lastT c t      = ultimo c t

ultimo :: Tree a -> Camino -> a
ultimo [] (NodeT x t1 t2)     = x
ultimo (x:xs) (NodeT x t1 t2) = if esDerecha x
									then ultimo xs t2 
									else ultimo xs t1

esDerecha :: Dir -> Bool
esDerecha Der = True
esDerecha _   = False

snoc :: a -> RAL a -> RAL a
snoc x (MKR t c)  = MKC (agregar c x t) (next c)

agregar :: a -> Tree a -> Camino -> Tree a
agregar [] y EmptyT     = NodeT y EmptyT EmptyT
agregar (x:xs) y (NodeT x' t1 t2) = case x of
										Der -> agregar xs y t2 
										Izq -> agregar xs y t1


--Agrega un elemento al final de la RAL.
init :: RAL a -> RAL a
init (MKR t c) = MKR (initT c t) (prev c)

initT :: Camino -> Tree a -> Tree a
initT c EmptyT = error: "No se puede usar el tree vacio"
initT c t      = quitarUltimo c t

quitarUltimo :: Camino -> Tree a -> Tree a
quitarUltimo [] (NodeT x t1 t2)     = EmptyT 
quitarUltimo (x:xs) (NodeT x t1 t2) = if esDerecha x
										then quitarUltimo xs t2
										else quitarUltimo xs t1

--Quita el último elemento de la RAL.

lookup :: Int -> RAL a -> a
lookup i (MKR t c) = ultimo numACamino(i) t


--Dada una posición válida obtiene el elemento que se encuentre en esa posición.
update :: Int -> a -> RAL a -> RAL a
update e a (MKR t c) = MKR (updateT (numACamino i) e t) c

updateT :: Camino -> a -> Tree a -> Tree a 
updateT [] e (NodeT x t1 t2)     = NodeT e t1 t2
updateT (x:xs) e (NodeT x t1 t2) = case x of
									Der -> NodeT x t1 (updateT xs e t2) 
									Izq -> NodeT x (updateT xs e t1) t2

--Dados una posición válida y un elemento, 
--reemplaza el elemento encontrado en esa posición por el nuevo.

indexOf :: Eq a => a -> RAL a -> Int
indexOf a r = if isNil then error "No puede ser nill"
					   else indexOfL 0 a r

indexOfL :: Int -> a -> Ral a -> Int
indexOfL i e r = if e == lookup i r
					then i
					else indexOfL (i+1) e r
					

--Dado un elemento y un RAL, devuelve la posici´on de la primera aparici´on de ese elemento en la RAL.
ralToList :: RAL a -> [a]
ralToList r = reverse (listarRal r)

listarRal :: Ral a -> [a]
listarRal r = if isNil r 
				then []
				else (last r) : listarRal(init r)

--Convierte una RAL en una lista de Haskell, manteniendo el orden de los elementos.
append :: RAL a -> RAL a -> RAL a
append r1 r2 = appendear r1 ralToList(r2) 

appendear :: RAL a -> [a] -> RAL a
appendear r []     = r
appendear r (x:xs) = snoc x (appendear r xs)

--Concatena dos RAL, manteniendo el orden de los elementos. Primero los elementos de la primera lista, y luego
--los de la segunda.



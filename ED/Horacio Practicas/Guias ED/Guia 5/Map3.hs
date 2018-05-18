module Map3(Map(MkM3), emptyM, assocM, deleteM, lookUpM, domM, ponerEnLaPosicion, laPosicion, filtrar, eliminarPosicion)where

import Listas

data Map k v = MkM3 [k] [v] deriving(Eq, Show) --Tipo de representacion: [k] [v]



--Invariante de representacion:
--La lista de claves no posee claves repetidas.
--La posicion i de la lista de claves coincide  con la clave del valor i de la lista de valores.


--O(1)
emptyM :: Map k v
emptyM = MkM3 [] []


--O()
assocM :: Eq k => Map k v -> k -> v -> Map k v
assocM (MkM3 ks vs) k v = MkM3 (agregar k ks) (ponerEnLaPosicion v (laPosicion k (agregar k ks)) vs)


--O(n)
agregar :: Eq a => a -> [a] -> [a] 
--agregar x [] = ...
--agregar x (y : ys) = ... agregar ys
agregar x [] = x : []
agregar x (y : ys) = if  x == y 
							then x : ys
							else y : agregar x ys

--O(n)
ponerEnLaPosicion :: v -> Int -> [v] -> [v]
ponerEnLaPosicion v n [] = [v]
ponerEnLaPosicion v 0 (x : xs) = v : xs
ponerEnLaPosicion v n (x : xs) = x : ponerEnLaPosicion v (n - 1) xs 							

--O(n)
laPosicion ::Eq a => a -> [a] -> Int
laPosicion x [] = 0
laPosicion x (y : ys) = if x == y
							then 0
							else 1 + laPosicion x ys

--O(n) --en Vez de la posicion
posicion :: Int -> [a] -> a
posicion x (xs) = xs !! x

--O(n)
lookUpM :: Eq k => Map k v -> k -> Maybe v
lookUpM (MkM3 ks vs) k = lookUp (laPosicion k ks) vs

--O(n)
lookUp :: Int -> [v] -> Maybe v
--lookUp n [] = ...
--lookUp n (v : vs) = ... lookUp (n-1) vs
lookUp n [] = Nothing
lookUp n (v : vs) = if n == 0
							then Just v
							else lookUp (n-1) vs


--O(n)
deleteM :: Eq  k => Map k v -> k -> Map k v
deleteM (MkM3 kv vs) k = if(isEmpty kv)
								then error "Asociacion vacia."
								else MkM3 (filtrar k kv) (eliminarPosicion (laPosicion k kv) vs) 


--O(n)
filtrar :: Eq k => k -> [k] -> [k]
filtrar k [] = []
filtrar k (k' : ks) = if k == k'
								then ks
								else k' : filtrar k ks


--O(n)
eliminarPosicion :: Int -> [a] -> [a]
eliminarPosicion n [] = error "Es imposible borrar esa posicion"
eliminarPosicion 0 (x : xs) = xs
eliminarPosicion n (x : xs) = x : eliminarPosicion (n - 1) xs


--O(1)
domM :: Map k v -> [k]
domM (MkM3 ks vs) = ks



data Map k v = MkM3 [k] [v] deriving(Eq, Show) --Tipo de representacion: [k] [v]

--Invariante de representacion:
--La lista de claves no posee claves repetidas.
--La posicion i de la lista de claves coincide  con la clave del valor i de la lista de valores.


--O(1)
emptyM :: Map k v
emptyM = MkM3 [] []


--O()
assocM :: Eq k => Map k v -> k -> v -> Map k v
assocM (MkM3 ks vs) k' v' = MkM3 (agregar k' ks) (ponerEnLaPosicion v' (laPosicion k' (agregar k' ks)) vs)	


--O(n)
agregar :: Eq a => a -> [a] -> [a] 
--agregar x [] = ...
--agregar x (y : ys) = ... agregar ys
agregar x [] = [x]
agregar x ys = if  pertenece x ys 
							then ys
							else x : ys

--O(n)
ponerEnLaPosicion :: a -> Int -> [a] -> [a]
ponerEnLaPosicion v n [] = error "La posicion donde se desea ingresar el nuevo elemento no es correcta."
ponerEnLaPosicion v 0 [] = [v]
ponerEnLaPosicion v 0 (x : xs) = v : xs
ponerEnLaPosicion v n (x : xs) = x : ponerEnLaPosicion v (n - 1) xs 							

--O(n)
laPosicion ::Eq a => a -> [a] -> Int
laPosicion x [] = 0 
laPosicion x (y : ys) = if x == y
							then 0
							else 1 + laPosicion x ys



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
								else 
									if pertenece k kv 
											then MkM3 (filtrar k kv) (eliminarPosicion (laPosicion k kv) vs) 
											else MkM3 kv vs

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

pertenece :: Eq a => a -> [a] -> Bool
pertenece x [] = False
pertenece x (y : ys) = x == y || pertenece x ys 

isEmpty :: [a] -> Bool
isEmpty [] = True
isEmpty _ = False
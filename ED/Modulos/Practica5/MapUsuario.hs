import Map1
import Conjunto2

--O(n^2)
pedirTelefonos :: [String] -> Map String Int -> [Maybe Int]
pedirTelefonos [] m     = []
pedirTelefonos (x:xs) m = 
			lookupM m x : pedirTelefonos xs m
			
--O(n) o O(n^2) Dependiendo del assocM
asociarTelefonos :: [(String, Int)] -> Map String Int
asociarTelefonos []         = emptyM
asociarTelefonos ((k,v):ms) = assocM (asociarTelefonos ms) k v 

--O(n) o O(n^2) Dependiendo del assocM
mapSuccM :: [String] -> Map String Int -> Map String Int
mapSuccM [] m     = emptyM
mapSuccM (k:ks) m = case (lookupM m k) of 
						Nothing  -> mapSuccM ks m
						(Just x) -> mapSuccM ks (assocM m k (x+1))
						

						
--Ejercicio4

--O(n^2)  Por cada assocM que realizo, recorro la lista en quitarElementos y en apariciones. 

ocurrencias :: String -> Map Char Int 
ocurrencias str = ocurrenciasL str
 

ocurrenciasL :: [Char] -> Map Char Int
ocurrenciasL []     = emptyM
ocurrenciasL (x:xs) = assocM (ocurrenciasL (quitarElementos x xs)) x (apariciones x xs)
							
								
apariciones :: Eq a => a -> [a] -> Int
apariciones x []     = 1
apariciones x (y:ys) = if x == y
							then 1 + apariciones x ys
							else apariciones x ys

quitarElementos :: Eq a => a -> [a] -> [a]
quitarElementos x []     = []
quitarElementos x (y:ys) = if x == y 
							then quitarElementos x ys
							else y : quitarElementos x ys


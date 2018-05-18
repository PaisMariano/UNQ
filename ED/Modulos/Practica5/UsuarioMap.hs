import Map4 
import Conjunto2

pedirTelefonos :: [String] -> Map String Int -> [Maybe Int]
pedirTelefonos [] m     = []
pedirTelefonos (s:ss) m = (lookupM m s) : pedirTelefonos ss m

asociarTelefonos :: [(String, Int)] -> Map String Int
asociarTelefonos []            = emptyM
asociarTelefonos ((k, v):kvs)  = assocM (asociarTelefonos kvs) k v

mapSuccM :: (Eq k, Ord k) => [k] -> Map k Int -> Map k Int
mapSuccM [] m     = emptyM
mapSuccM (k:ks) m = case lookupM m k of
							Nothing  -> mapSuccM ks m
							(Just x) -> assocM (mapSuccM ks m) k (x+1) 

agregarMap :: (Eq k, Ord k, Ord v) => Map k v -> Map k v -> Map k v
agregarMap m1 m2 = agMap (hacerListaM m1) m1 m2

hacerListaM :: Eq k => Map k v -> [k]
hacerListaM m = setToList(domM m)

agMap :: (Eq k, Ord k, Ord v) => [k] -> Map k v -> Map k v -> Map k v
agMap [] m1 m2     = emptyM
agMap (k:ks) m1 m2 = case lookupM m2 k of 
						
				Nothing  -> assocM (agMap ks m1 m2) 
				(Just x) -> assocM (agMap ks m1 m2) k x


import Map3
import Auxiliares

type Nombre = String 
type Telefono = Int


pedirTelefonos :: [Nombre] -> Map Nombre Telefono -> [Maybe Telefono]
--Dada una lista de nombres de personas y un Map que relaciona nombres con numeros de
--telefonos, devuelve una lista con los numeros de las personas de la lista o Nothing en caso
--de que no posea numero.
pedirTelefonos [] map = []
pedirTelefonos (n : ns) map = pedirTelefono n map : pedirTelefonos ns map

pedirTelefono :: Nombre -> Map Nombre Telefono -> Maybe Telefono
pedirTelefono n map = lookUpM map n


asociarTelefonos :: [(Nombre, Telefono)] -> Map String Int
--Dada una lista de pares nombre y telefono genera un map.
asociarTelefonos [] = emptyM
asociarTelefonos ((n,t) : nts) = 
	let validos = filtrarNombresInvalidos ((n,t) : nts)  
	in assocM (asociarTelefonos validos) n t 

filtrarNombresInvalidos :: [(Nombre, Telefono)] -> [(Nombre, Telefono)]
filtrarNombresInvalidos [] = []
filtrarNombresInvalidos ((n,t) : nts) = if esNombreValido n
												then (n, t) : filtrarNombresInvalidos nts
												else filtrarNombresInvalidos nts

esNombreValido :: Nombre -> Bool
esNombreValido "" = False
esNombreValido _ = True


mapSuccM :: Eq k => [k] -> Map k Int -> Map k Int
--Dada una lista de claves de tipo k y un mapa que va de k a int, le suma uno a cada numero asociado con dichas claves.
mapSuccM [] map = map
mapSuccM (k : ks) map = 
	let numero = case lookUpM map k of
						Nothing -> 0
						Just x -> x 
	in assocM (mapSuccM ks map) k (sumarUno numero)    


agregarMap :: Ord k => Map k v -> Map k v -> Map k v
--Dado dos maps se agregan las claves y valores del primer map en el segundo. Si una clave
--del primero existe en el segundo, es reemplazada por la del primero.
agregarMap map1 map2 = agregarAl map1 map2 (domM map1)
									  --Al que le agregan.

agregarAl :: Ord k => Map k v -> Map k v -> [k] -> Map k v
agregarAl map1 map2 [] = map2
agregarAl map1 map2 (k : ks) = assocM (agregarAl map1 map2 ks) k (fromJust(lookUpM map1 k))
							


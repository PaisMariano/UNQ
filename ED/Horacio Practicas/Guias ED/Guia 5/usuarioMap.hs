import Map1
import Listas

pedirTelefonos :: [String] -> Map String Int -> [Maybe Int]
--Dada una lista de nombres de personas y un Map que relaciona nombres con numeros de
--telofonos, devuelve una lista con los numeros de las personas de la lista o Nothing en caso
--de que no posea numero.
pedirTelefonos [] map = [Nothing]
pedirTelefonos (s : ss) map = pedirTelefono s map : pedirTelefonos ss map

pedirTelefono :: String -> Map String Int -> Maybe Int
pedirTelefono str map = lookUpM map str  

indexar :: [a] -> Map Int a
--Dada una lista de elementos construye un Map que relaciona cada elemento con su posicion
--en la lista.
indexar xs = indexo xs 0

indexo :: [a] -> Int -> Map Int a
indexo [] n = emptyM
indexo (x : xs) n = assocM (indexo xs (n -1)) n x

ocurrencias :: String -> Map Char Int
--Dado un string cuenta las ocurrencias de cada caracter utilizando un Map.
ocurrencias "" = emptyM
ocurrencias (c : cs)  = assocM (ocurrencias cs) c (apariciones c (c : cs))

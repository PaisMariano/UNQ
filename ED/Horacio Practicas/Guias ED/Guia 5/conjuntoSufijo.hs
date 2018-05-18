module ConjuntoSufijo(ConjuntoSufijos, vacio, terminanCon, agregarSufijos, borrarSufijos, ejemplo, Palabra, Sufijo) where 

import Map3
import Listas
import Set1

data ConjuntoSufijos = CP (Map Sufijo (Set Palabra)) deriving(Show)
type Sufijo = String
type Palabra = String

--Invariante de representacion:
--Todas las palabras del map deben ser palabras validas. (No puede haber "")
--Cada sufijo de cada palabra del map existe en el mismo, asociado a esa palabra y a todas las palabras que compartan dichos sufijo.
--Todos los sufijo tienen asociada, como minimo, una palabra.


--A:
vacio :: ConjuntoSufijos
--Crea una ConjuntoSufijos vacio. O(1).
vacio = CP emptyM


--B:
terminanCon :: Sufijo -> ConjuntoSufijos -> Set Palabra
--Devuelve el conjunto de palabras asociadas a determinado sufijo. O(log(n)).
terminanCon sufijo (CP mapSsP) = lasPalabras sufijo mapSsP

lasPalabras :: Sufijo -> Map Sufijo (Set Palabra) -> Set Palabra -- O(log(n))
lasPalabras sufijo mapSsP = case lookUpM mapSsP sufijo of
										Nothing -> emptyS
										Just setPalabras -> setPalabras


--C:
--O(m.log(n))
agregarSufijos :: Palabra -> ConjuntoSufijos -> ConjuntoSufijos
--Asocia una palabra a cada uno de sus sufijos. O(s:log(n)).
agregarSufijos palabra (CP mapSsP) = if (esPalabraValida palabra)
											then CP (agregarLosSufijos palabra (losSufijosDe palabra) mapSsP)
											else error "La palabra que quiere agregar NO es una palabra valida." --Incumple el invariante.

--O(1)
esPalabraValida :: Palabra -> Bool
esPalabraValida palabra = longitud palabra > 0

--O(m.log(n)), siendo n la cantidad de claves y siendo m el largo de la lista.
agregarLosSufijos ::  Palabra -> [Sufijo] -> Map Sufijo (Set Palabra) -> Map Sufijo (Set Palabra) --O(2.log(n).n), siendo n el largo de la lista de sufijos.
agregarLosSufijos palabra [] mapSsP = mapSsP
agregarLosSufijos palabra (sufijo : sufijos) mapSsP = 
									let conjuntoPalabras = addS palabra (lasPalabras sufijo mapSsP) --O(log(n))
										in --No se xq no me tome solo un let
										let nuevoMap = agregarLosSufijos palabra sufijos mapSsP 
									in assocM nuevoMap sufijo conjuntoPalabras --O(log(n))

--O(n) siendo n el largo de la palabra.
losSufijosDe :: Palabra -> [Sufijo] --O(n), siendo n el largo de la palabra.
losSufijosDe "" = "" : []
losSufijosDe (c : chs) = (c : chs) : losSufijosDe chs --El : O(1) y recorrer la lista, O(n) siendo n el largo de la palabra.


--D:
borrarSufijos :: Palabra -> ConjuntoSufijos -> ConjuntoSufijos
--Borra la palabra de cada uno de sus sufijos. O(s:log(n)) siendo s el largo del string y siendo n la cantidad de sufijos dentro del conjunto.
borrarSufijos palabra (CP mapSP) = CP (filtrar' (losSufijosDe palabra) (eliminarSufijos palabra (losSufijosDe palabra) mapSP))

--Depende del costo de assocM, asumo que es o(n.log(m)), donde n es el largo de la lista y m la cantidad de claves dentro del map, dado que llama a assocM
--por cada elemento de la lista. 
eliminarSufijos :: Palabra -> [Sufijo] -> Map Sufijo (Set Palabra) -> Map Sufijo (Set Palabra)
eliminarSufijos paabra [] map = map
eliminarSufijos palabra (sufijo : sufijos) map = assocM (eliminarSufijos palabra sufijos map) sufijo (deleteS palabra (lasPalabras sufijo map))

--Depende del costo de assocM, asumo que es o(n.log(m)), donde n es el largo de la lista y m la cantidad de claves dentro del map, dado que llama a assocM
--por cada elemento de la lista.
filtrar' :: [Sufijo] -> Map Sufijo (Set Palabra) -> Map Sufijo (Set Palabra)
filtrar' [] map = map
filtrar' (sufijo : sufijos) map =
	let filtrando = filtrar' sufijos map
	in
		if sizeS (lasPalabras sufijo map) < 1
						then deleteM filtrando sufijo
						else assocM filtrando sufijo (lasPalabras sufijo map) 


ejemplo :: ConjuntoSufijos
ejemplo = agregarSufijos "sigfrido" (agregarSufijos "horacio" (agregarSufijos "mora" (agregarSufijos "abuela" (agregarSufijos "pizza" (agregarSufijos "pasa" (agregarSufijos "murcielago" (agregarSufijos "ludmila" (agregarSufijos "anana" (agregarSufijos "mariposa" (agregarSufijos "penelope" (agregarSufijos "pepe" (agregarSufijos "asd" (agregarSufijos "casa" vacio)))))))))))))
import ConjuntoSufijo
import Auxiliares
import Set1

conjuntoSufijos :: Ord ConjuntoSufijos => Tree ConjuntoSufijos -> Set Palabra
--Une todas los palabras de los ConjuntoSufijos del arbol.
conjuntoSufijos EmptyT = emptyS
conjuntoSufijos (NodeT cs ri rd) = unionS (terminanCon "" cs) (unionS (conjuntoSufijos ri) (conjuntoSufijos rd))
				
				--[Sufijo]					--Sufijo
sufijoMayor :: Ord ConjuntoSufijos =>  [String] -> ConjuntoSufijos -> String
--Devuelve la palabra de la lista que es sufio de mayor cantidad de palabras del ConjuntoSufijos.
--Los sufijos de la lista deben pertenecer a ls sufijos del conjunto.
sufijoMayor [] conjunto = error "La lista debe contener al menos un sufijo para evaluar."
sufijoMayor [sufijo] conjunto = if estaEnElConjunto (terminanCon sufijo conjunto)
															then sufijo
															else error "El sufijo no pertenece al conjunto de sufijos." 
sufijoMayor (sufijo : sufijos) conjunto = 	if estaEnElConjunto (terminanCon sufijo conjunto)
														then mayorSufijo conjunto sufijo (sufijoMayor sufijos conjunto) 
														else sufijoMayor sufijos conjunto

mayorSufijo :: Ord ConjuntoSufijos =>  ConjuntoSufijos -> Sufijo -> Sufijo -> Sufijo
mayorSufijo conjunto sufijo1 sufijo2  = if palabrasAsociadas sufijo1 conjunto > palabrasAsociadas sufijo2 conjunto
															then sufijo1
															else sufijo2 


estaEnElConjunto :: Set String -> Bool
estaEnElConjunto set = sizeS set > 0

palabrasAsociadas :: Sufijo -> ConjuntoSufijos -> Set Palabra
palabrasAsociadas sufijo conjunto = terminanCon sufijo conjunto   
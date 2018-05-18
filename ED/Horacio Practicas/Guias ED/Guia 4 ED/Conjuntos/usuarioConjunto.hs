import ImplementacionConjunto3

import Auxiliares

--vacioC :: Conjunto a
--Crea un conjunto vacío.

--agregarC :: Eq a => a -> Conjunto a -> Conjunto a
--Dados un elemento y un conjunto, agrega el elemento al conjunto.

--perteneceC :: Eq a => a -> Conjunto a -> Bool
--Dados un elemento y un conjunto indica si el elemento pertenece al conjunto.

--cantidadC :: Eq a => Conjunto a -> Int
--Devuelve la cantidad de elementos distintos de un conjunto

--borrarC :: Eq a => a -> Conjunto a -> Conjunto a
--Devuelve la cantidad de elementos distintos de un conjunto

--unionC :: Eq a => Conjunto a -> Conjunto a -> Conjunto a
--Dados dos conjuntos devuelve un conjunto con todos los elementos de ambos conjuntos.

--listaC :: Eq a => Conjunto a -> [a]
--Dado un conjunto devuelve una lista con todos los elementos distintos del conjunto.


--A:
losQuePertenecen :: Eq a => [a] -> Conjunto a -> [a]
--Dados una lista y un conjunto, devuelve una lista con todos los elementos que pertenecen al conjunto.
--losQuePertenecen [] set = ...
--losQuePertenecen (x : xs) = ... losQuePertenecen xs
losQuePertenecen [] set = []
losQuePertenecen (x : xs) set = if perteneceC x set
									then x : losQuePertenecen xs set
									else losQuePertenecen xs set 


--B:
sinRepetidos :: Eq a =>  [a] -> [a]
--Quita todos los elementos repetidos de la lista dada utilizando un conjunto como estructura auxiliar.
sinRepetidos [] = []
sinRepetidos xs = listaC (conjuntoL xs)

conjuntoL :: Eq a => [a] -> Conjunto a
--Dado una lista, retorna un conjunto.  
--conjuntoL [] = ...
--conjuntoL (x : xs) = ... conjuntoL xs
conjuntoL [] = vacioC
conjuntoL (x : xs) = unionC (singlenC x) (conjuntoL xs)

singlenC :: Eq a => a -> Conjunto a
--Dado un elemento, retorna un conjunto con ese unico elemento.
singlenC x = agregarC x vacioC  


--C:
unirTodos :: Eq a => Arbol (Conjunto a) -> Conjunto a
--Dado un arbol de conjuntos devuelve un con(junto con la union de todos los conjuntos del arbol.
--unirTodos EmptyT = ...
--unirTodos (NodeT x ri rd) = ... unirTodos ... unirTodos ...
unirTodos EmptyT = vacioC
unirTodos (NodeT set ri rd) = unionC set (unionC (unirTodos ri) (unirTodos rd))
---------------------------------------------------------------------------------------------------------
--------------------------------------------------- Usuario ---------------------------------------------
---------------------------------------------------------------------------------------------------------

import Conjunto1
import Auxiliares


--A:
losQuePertenecen :: Eq a => [a] -> Set a -> [a]
--losQuePertenecen [] set = ...
--losQuePertenecen (e : es) = ... losQuePertenecen ...
losQuePertenecen []  set = []
losQuePertenecen (e : es) set = if belongS e set
									then e : losQuePertenecen es set
									else losQuePertenecen es set


--B:
sinRepetidos :: Eq a => [a] -> [a]
sinRepetidos xs = setTolist (agregarATodos xs)   

agregarATodos ::Eq a => [a] -> Set a
agregarATodos [] = emptyS
agregarATodos (x : xs) = addS x (agregarATodos xs)   


--C:
unirTodos :: Eq a => Tree (Set a) -> Set a
unirTodos EmptyT = emptyS
unirTodos (NodeT set ri rd) = unionS set (unionS (unirTodos ri) (unirTodos rd))


--D: De la practica vieja.
interseccionArbol :: Eq a => Tree a -> Tree a -> Set a
interseccionArbol EmptyT EmptyT = emptyS
interseccionArbol (NodeT x EmptyT EmptyT) (NodeT y EmptyT EmptyT) = if (sonLoMismo x y)
																			then addS x emptyS
																			else emptyS
interseccionArbol (NodeT x1 ri1 rd1) (NodeT x2 ri2 rd2) = if (sonLoMismo x1 x2)
																then addS x2 (unionS (interseccionArbol ri1 rd1) (interseccionArbol ri2 rd2)) 
																else unionS (interseccionArbol ri1 rd1) (interseccionArbol ri2 rd2)

sonLoMismo :: Eq a => a -> a -> Bool
sonLoMismo x y = x == y
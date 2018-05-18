module Conjunto1(Set, empty, singleton, union, pertenece, set2list) where
      -- La INTERFAZ del TAD!

data Set a = ConsS [ a ] -- el TIPO DE REPRESENTACIÓN 
  -- INV.REP.: la lista NO tiene repetidos!!

empty     :: Set a
singleton :: a -> Set a
union     :: Set a -> Set a -> Set a
pertenece :: a -> Set a -> Bool
set2list  :: Set a -> [ a ] -- La lista NO TIENE elementos repetidos

empty = ConsS []
singleton x = ConsS (x:[])
pertenece x (ConsS xs) = elem x xs

set2list (ConsS xs) = xs  -- No tiene repetidos por INV.REP.

union (ConsS xs) (ConsS ys) = ConsS (juntarSinRepes xs ys) -- Cumple PRECON. por INV.REP.!!

-- Observar que juntarSinRepes NO ES VISIBLE por el usuario! (No está en la interfaz)

juntarSinRepes :: [ a ] -> [ a ] -> [ a ]
-- PROP: pone todos los elementos, SIN repetidos
-- PRECOND: Las listas xs e ys NO TIENEN repetidos
juntarSinRepetidos [ ] ys = ys -- No tiene repetidos, por precondición
juntarSinRepetidos (x:xs') ys =
     if (elem x ys)   -- Por PRECOND, x NO PUEDE estar en xs'
      then juntarSinRepetidos xs' ys
      else x : juntarSinRepetidos xs' ys


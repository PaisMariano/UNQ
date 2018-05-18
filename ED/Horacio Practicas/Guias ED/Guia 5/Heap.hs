--Colas de Prioridad (Heaps)
--con BST
module Heap(Heap, emptyH, isEmptyH, insertH, deleteMin, findMin, splitMin)where

import Auxiliares
import BST

data Heap a = MkH (Tree a)
--Invariante de representacion: 
--El Arbol es AVL. 

--En vez de insertBST se podria reutilizar armarAVL o balancear.

emptyH :: Heap a
emptyH = MkH EmptyT

isEmptyH :: Heap a -> Bool
isEmptyH (MkH tree) = isEmptyT tree 

insertH :: Ord a => a -> Heap a -> Heap a
insertH x (MkH tree) = MkH (insertBST x tree)

findMin :: Ord a => Heap a -> a -- Parcial en emptyH
findMin (MkH tree) = minBST tree

deleteMin :: Ord a => Heap a -> Heap a -- Parcial en emptyH
deleteMin (MkH tree) = MkH (deleteBST (minBST tree) tree)

splitMin :: Ord a => Heap a -> (a, Heap a) -- Parcial en emptyH
splitMin (MkH tree) = 
	let (minimo, arbol) = splitMinBST tree
	in (minimo, MkH arbol)
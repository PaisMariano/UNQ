import Heap

heapSort :: Ord a => [a] -> [a]
--Dada una lista la ordena de menor a mayor utilizando una Heap como estructura auxiliar.
heapSort xs = desarmarHeap (armarHeap xs)

armarHeap :: Ord a => [a] -> Heap a
armarHeap [] = emptyH
armarHeap (x : xs) = insertH x (armarHeap xs) 

desarmarHeap :: Ord a => Heap a -> [a] 
desarmarHeap heap = if isEmptyH heap
							then []
							else findMin heap : desarmarHeap (deleteMin heap)


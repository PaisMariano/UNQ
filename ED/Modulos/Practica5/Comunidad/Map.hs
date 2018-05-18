module Map(Map, emptyM, lookupM, assocM, deleteM, domM) where

data Map k v = MkM [(k, v)]
-- Invariantes de representación:
-- Las claves no se repiten

-- O(1)
emptyM :: Map k v
emptyM = MkM []

-- O(n)
lookupM :: Eq k => Map k v -> k -> Maybe v
lookupM (MkM xs) k = lookup' k xs

-- O(n)
lookup' :: Eq k => k -> [(k, v)] -> Maybe v
lookup' k [] = Nothing
lookup' k ((k', v):xs) = 
	if k == k'
		then Just v
		else lookup' k xs

-- O(1)
assocM :: Eq k => Map k v -> k -> v -> Map k v
assocM (MkM xs) k v = MkM (insert k v xs)

insert :: Eq k => k -> v -> [(k, v)] -> [(k, v)]
insert k v [] = [(k, v)]
insert k v ((k', v') : xs) =
	if k == k'
		then (k, v) : xs
		else (k', v') : insert k v xs

-- O(n)
deleteM :: Eq k => Map k v -> k -> Map k v
deleteM (MkM xs) k = MkM (delete' k xs)

-- O(n)
delete' :: Eq k => k -> [(k, v)] -> [(k, v)]
delete' k [] = []
delete' k ((k', v):xs) =
	if k == k'
		then xs
		else (k', v) : delete' k xs

-- O(n)
domM :: Eq k => Map k v -> [k]
domM (MkM xs) = obtenerClaves xs

-- O(n)
obtenerClaves :: [(k, v)] -> [k]
obtenerClaves [] = []
obtenerClaves ((k, v):xs) = k : obtenerClaves xs
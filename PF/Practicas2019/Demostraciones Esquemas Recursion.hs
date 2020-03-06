noVacias' = filter (not . null)	

noVacias [] = []
noVacias (xs:xss) = if (\xs' -> not (null xs')) xs then xs : noVacias xss
			 										else noVacias xss

¿noVacias' = noVacias?
por ppio de extensionalidad

	noVacias' xs = noVacias xs
demostracion por principio de induccion en la estructura de xs
	¿ noVacias' xs = noVacias xs ?

CASO BASE: xs = []

	noVacias' [] = noVacias []
def noVacias'
	filter (not . null) []
def filter 1
	[]

------------------------------------------------------------------------------------------------------

	noVacias [] = 
def noVacias 1
	[]

CASO INDUCTIVO: xs = (x:xs')
HI) ¡ noVacias' xs' = noVacias xs' !
TI) ¿ noVacias' (x:xs') = noVacias (x:xs') ?

	noVacias' (x:xs')
def noVacias'
	filter (not . null) (x:xs')
def filter 2
	if (not . null) x then x : filter (not . null) xs'
					  else filter (not . null) xs'
def noVacias'
	if (not . null) x then x : noVacias' xs'
					  else noVacias xs'
HI)
	if (not . null) x then x : noVacias xs'
					  else noVacias xs'

def noVacias 2
	noVacias (x:xs')

------------------------------------------------------------------------------------------------------

	¿concat' = concat?

Por ppio. de extensionalidad 
	concat' xs = concat xs

Demostración por principio de induccion en la estructura de xs

CASO BASE: xs = []
	concat' [] = concat []
def concat'
	foldr (++) [] []
def foldr
	[]

------------------------------------------------------------------------------------------------------

	concat []
def concat
	[]

CASO INDUCTIVO: xs = (x:xs')
HI) ¡ concat' xs' = concat xs' !
TI) ¿ concat' (x:xs') = concat (x:xs') ?

	concat' (x:xs')
def concat'
	foldr (++) [] (x:xs')
def foldr
	(++) x (foldr (++) [] xs')
def concat'
	(++) x (concat' xs')
HI)
	(++) x (concat xs')
def concat 2
	concat (x:xs')

-------------------------------------------------------------------------------------------------------

	¿ foldr f z (map g xs) = foldr (f . g) z xs ?
Dem por induccion en la estructura de xs
CASO BASE: xs = []
	
	foldr f z (map g [])
def map 1
	foldr f z []
def foldr 1
	[]

--------------------------------------------------------------------------------------------------------
	foldr (f . g) z []
def foldr 1
	[]

-------------------------------------------------------------------------------------------------------

CASO INDUCTIVO : xs = (x:xs')
HI) ¡ foldr f z (map g xs') = foldr (f . g) z (xs') !
TI) ¿ foldr f z (map g (x:xs')) = foldr (f . g) z (x:xs') ?

	foldr f z (map g (x:xs'))
def map 2
	foldr f z (g x : map g xs')
def foldr 2
	f (g x) (foldr f z (map g xs'))
HI)
	f (g x) (foldr (f . g) z xs')
def (.)
	(f . g) x (foldr (f . g) z xs')
def foldr 2
	foldr (f . g) z (x:xs')

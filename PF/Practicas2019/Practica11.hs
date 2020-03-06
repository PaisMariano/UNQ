data Pizza = Prepizza | Capa Ingrediente Pizza

data Ingrediente = Aceitunas Int | Queso | Jamon | Salsa

--Ejercicio 1)

cantidadCapasQueCumplen :: (Ingrediente -> Bool) -> Pizza -> Int
cantidadCapasQueCumplen f Prepizza   = 0
cantidadCapasQueCumplen f (Capa i p) = if (f i) then 1 + cantidadCapasQueCumplen f p 
												else cantidadCapasQueCumplen f p

conCapasTransformadas :: (Ingrediente -> Ingrediente) -> Pizza -> Pizza
conCapasTransformadas f Prepizza   = 0
conCapasTransformadas f (Capa i p) = Capa (f i) (conCapasTransformadas p)

soloLasCapasQue :: (Ingrediente -> Bool) -> Pizza -> Pizza
soloLasCapasQue f Prepizza   = Prepizza 
soloLasCapasQue f (Capa i p) = if (f i) then Capa i (soloLasCapasQue f p)
                                        else soloLasCapasQue f p

--Ejercicio 2)

sinLactosa :: Pizza -> Pizza
sinLactosa Prepizza   = Prepizza
sinLactosa (Capa i p) = sololasCapasQue (quitarQueso i) p

aptaIntolerantesLactosa :: Pizza -> Bool
aptaIntolerantesLactosa Prepizza   = True
aptaIntolerantesLactosa (Capa i p) = cantidadCapasQueCumplen (esQueso i) p > 0

cantidadDeQueso :: Pizza -> Int
cantidadDeQueso Prepizza   = 0
cantidadDeQueso (Capa i p) = cantidadCapasQueCumplen (esQueso i) p

conElDobleDeAceitunas :: Pizza -> Pizza
conElDobleDeAceitunas Prepizza   = Prepizza
conElDobleDeAceitunas (Capa i p) = conCapasTransformadas (dobleAceitunas i) p

--Ejercicio 3)

pizzaProcesada :: (Ingrediente -> b -> b) -> b -> Pizza -> b
pizzaProcesada f p Prepizza   = p
pizzaProcesada f p (Capa i p') = (f i) (pizzaProcesada f p p')

--Ejercicio 4)

cantidadCapasQueCumplen' :: (Ingrediente -> Bool) -> Pizza -> Int
cantidadCapasQueCumplen' f p = pizzaProcesada (sumar.sumar1Si.f) 0 p

sumar1Si :: Bool -> Int
sumar1Si True = 1
sumar1Si _    = 0

conCapasTransformadas' :: (Ingrediente -> Ingrediente) -> Pizza -> Pizza
conCapasTransformadas' f p = pizzaProcesada (Capa.f) Prepizza p

soloLasCapasQue' :: (Ingrediente -> Bool) -> Pizza -> Pizza
soloLasCapasQue' f p = pizzaProcesada (agregoSi f) Prepizza p

agregoSi :: (Ingrediente -> Bool) -> Ingrediente -> Pizza -> Pizza
agregoSi f i p = if (f i) then Capa i p
			         else p	

sinLactosa' :: Pizza -> Pizza
sinLactosa' p = pizzaProcesada (AgregoSi !esQueso) Prepizza p

aptaIntolerantesLactosa' :: Pizza -> Bool
aptaIntolerantesLactosa' p = pizzaProcesada ((&&).esQueso) True p

cantidadDeQueso' :: Pizza -> Int
cantidadDeQueso' p = pizzaProcesada ((+).sumar1Si.esQueso) Prepizza p

conElDobleDeAceitunas' :: Pizza -> Pizza
conElDobleDeAceitunas' p = pizzaProcesada (Capa.dobleAceitunas) Prepizza p

dobleAceitunas' :: Ingrediente -> Ingrediente
dobleAceitunas' (Aceitunas n) = Aceitunas (n*2)
dobleAceitunas' _ 	   = _

--Ejercicio 5)

cantidadAceitunas :: Pizza -> Int
cantidadAceitunas p = pizzaProcesada (sumar.aceitunas) 0 p

capasQueCumplen :: (Ingrediente -> Bool) -> Pizza -> [Ingrediente]
capasQueCumplen f p = pizzaProcesada (agregoONo f) [] p

agregoONo :: (Ingrediente -> Bool) -> Ingrediente -> [Ingrediente] -> [Ingrediente]
agregoONo f i ps = if (f i) then i : ps
			    else ps

agregaAceitunasCorrectamente :: Pizza -> Bool
agregaAceitunasCorrectamente p = pizzaProcesada (esAceitunaCorrecta.esAceituna) True p

esAceitunaCorrecta :: (Ingrediente -> Bool) -> Ingrediente -> Bool -> Bool
esAceitunaCorrecta f i b = if (f i) || cantAceitunas i > 0
					then b
					else False

conDescripcionMejorada' :: Pizza -> Pizza
conDescripcionMejorada' p = pizzaProcesada () Prepizza p

conDescripcionMejorada :: Pizza -> Pizza
conDescripcionMejorada Prepizza = Prepizza
conDescripcionMejorada (Capa i p) = juntar i (conDescripcionMejorada p)

juntar :: Ingrediente -> Pizza -> Pizza
juntar (Aceitunas n) (Capa (Aceitunas m) p) = Capa (Aceitunas (n+m)) ps
juntar ing ps = Capa ing ps

conCapasDe :: Pizza -> Pizza -> Pizza
conCapasDe p1 p2 = pizzaProcesada (Capa.agregaIngrediente) p1 p2

agregaIngrediente :: Ingrediente -> Ingrediente
agregaIngrediente i = i

primerasNCapas :: Int -> Pizza -> Pizza
primerasNCapas i p = pizzaProcesada (hastaAca n) Prepizza p

pizzaProcesada' :: ((Ingrediente -> b) -> b) -> b -> Pizza -> b
pizzaProcesada' f p Prepizza   = p
pizzaProcesada' f p (Capa i p') = (f i) (pizzaProcesada' f p p')

cantidadDe :: (Ingrediente -> Int) -> Ingrediente -> Int -> Int
cantidadDe f p = pizzaProcesada (suma.devuelve1) Prepizza p

devuelve1 :: Ingrediente -> Int
devuelve1 _ = 1

--Ejercicio 6)
{-
length . capasQueCumplen f = cantidadDe f

por ppio de extensionalidad
para todo ps :: Pizza length(capasQueCumplen f ps) = cantidadDe f ps
dem: por ppio de induccion en la estructura de ps.
Caso base:
length(capasQueCumplen f Prepizza) = cantidadDe f Prepizza
def capasQueCumple 1				def cantidadDe 1
lenght[]
def lenght 1
0						0

Caso Inductivo: ps = (Capa i ps')
HI)¡ length(capasQueCumplen f ps') = cantidadDe f ps' !
TI)¿ length(capasQueCumplen f (Capa i ps') = cantidadDe f (Capa i ps') ?

= def capasQueCumplen								def cantidadDe
length(pizzaProcesada (agregoONo f) [] (Capa i ps')) = pizzaProcesada (suma.devuelve1) Prepizza (Capa i ps')
= def pizzaProcesada								def pizzaProcesada 
length((agregoONo f i) (pizzaProcesada (agregoOno f) [] ps')) = (suma.devuelve1 i) (pizzaProcesada (suma.devuelve1) Prepizza ps')
= def agregoONo										def . y devuelve 1
length((if (f i) then i : ps else ps) (pizzaProcesada (agregoONo f) [] ps')) = suma 1 (pizzaProcesada (suma.devuelve1) Prepizza ps')
													notacion +
																			 = 1 + (pizzaProcesada (suma.devuelve1) Prepizza ps')


CASO (f i) = True
	length(i : (pizzaProcesada (agregoONo f) [] ps') = 1 + (pizzaProcesada (suma.devuelve1) Prepizza ps')
	= def length									def cantidadDe
	1 + (pizzaProcesada (agregoONo f) [] ps')		 = 1 + cantidadDe f ps'
	= HI)
	1 + cantidadDe f ps'							 = 1 + cantidadDe f ps'

CASO (f i) = False
	length(pizzaProcesada (agregoONo f) [] ps') = cantidadDe f (Capa i ps')
	= HI)
	cantidadDe f ps'

	cantidadDe :: (Ingrediente -> Int) -> Ingrediente -> Int -> Int
cantidadDe f p = pizzaProcesada (suma.devuelve1) Prepizza p

--b)
cantidadCapasQueCumplen f (conCapasDe p1 p2) = cantidadCapasQueCumplen f p1 + cantidadCapasQueCumplen f p2

-}
--Ejercicio 7)

map'' :: (a -> b) -> [a] -> [b]
map'' f []     = []
map'' f (x:xs) = f x : map f xs

filter' :: (a -> Bool) -> [a] -> [a]
filter' f []	= []
filter' f (x:xs)	= if (f x) then x : filter f xs
			   else filter f xs

foldr'' :: (a -> b -> b) -> b -> [a] -> b
foldr'' f y []	 = y
foldr'' f y (x:xs) = f x (foldr'' f y xs)

recr :: b -> (a -> [a] -> b -> b) -> [a] -> b
recr y f [] 	= y
recr y f (x:xs) = f x xs (recr y f xs)

foldr1 :: (a -> a -> a) -> [a] -> a
foldr1 f []     = error "no pases lista vacia"
foldr1 f [x]	= x
foldr1 f (x:xs) = f x foldr1 xs

zipWith :: (a -> b -> c) -> [a] -> [b] -> [c]
zipWith f [] [] = []
zipWith f [] ys = ys
zipWith f xs [] = xs
zipWith f (x:xs) (y:ys) = f x y : zipWith f xs ys

scanr :: (a -> b -> b) -> b -> [a] -> [b]
scanr f y []     = [y]
scanr f y (x:xs) = f (head (scanr f y xs)) : scanr f y xs

--Ejercicio 8)

--a)
{-
map f . map g = map (f . g)
por ppio de extensionalidad.
(map f . map g) xs = map (f . g) xs

dem por ppio de induccion en la estructura de xs 
CASO BASE: TRIVIAL

CASO INDUCTIVO: xs = (x:xs')
HI) map f (map g xs') = map f (g xs')
TI) map f (map g (x:xs')) = map f (g (x:xs'))
= Def map 2		  			= Def map 2
map f (g x : map g xs') =
= Def map 2
f (g x) : map f (map g xs')
HI)
f(g x) : map f (g xs')
def map 2
map f (g x:xs')


--b)

map f (xs ++ ys) = map f xs ++ map f ys
Dem: por ppio de induccion en la estructura de xs

CASO BASE: xs = []

map f ([] ++ ys) = map f [] ++ map f ys
= def (++) 1		= def map 1
map f ys 	 = [] ++ map f ys
		 	= def (++) 1
		 = map f ys 

CASO INDUCTIVO: xs = (x:xs')
HI) ¡ map f (xs' ++ ys) = map f xs' ++ map f ys !
TI) ¿ map f ((x:xs') ++ ys) = map f (x:xs') ++ map f ys ?

= def ++
map f (x : (xs' ++ ys))
= def map
f x : map f (xs' ++ ys)
HI) 
f x : (map f xs' ++ map f ys)
def map 2
map f (x:xs') ++ map f ys 


--c)

concat . map (map f) = map f . concat
por ppio de extensionalidad 
concat(map (map f) xss) = map f (concat xss)
Dem por induccion en la estructura de xss
CASO BASE:
= def map 1					def concat 1 
concat []				= map f []
= def concat 1				def map 1
[]						= []

CASO INDUCTIVO: xss = (xs:xss')
HI) ¡ concat(map (map f) xss') = map f (concat xss') !
TI) ¿ concat(map (map f) (xs:xss')) = map f (concat (xs:xss')) ?

= def map 2 								def concat 2
concat((map f xs) : map (map f) xss') = map f (xs ++ concat xss')
= def concat 2 								ya demostrado
(map f xs) ++ concat(map (map f) xss') = map f xs ++ map f (concat xss')
HI)
(map f xs) ++ map f (concat xss')

--d)

foldr ((+) . suma’) 0 = sum . map suma’
por ppio de extensionalidad
foldr ((+) . suma’) 0 xs = sum . map suma’ xs
Dem por induccion en la estructura de xss
CASO BASE:
foldr ((+).(suma')) 0 [] = sum(map suma' [])
= def foldr 1		 def map 1
0			   sum[]
= def sum 1
			   0

CASO INDUCTIVO:
HI)¡ foldr ((+) . suma’) 0 xs' = sum . map suma’ xs' !
TI)¿ foldr ((+) . suma’) 0 (x:xs') = sum . map suma’ (x:xs') ?

=def foldr 2
(((+) . suma') x) (foldr ((+).suma') 0 xs')
HI)
(((+) . suma') x) ((sum . map suma') xs')
= def .
(suma' x) + (sum (map suma' xs'))
= def sum
sum (suma' x : map suma' xs')
= def map 2
sum (map suma' (x:xs'))
= def .
sum . map suma' (x:xs')

--e)

foldr f z . foldr (:) [] = foldr f z
por ppio de extensionalidad
foldr f z (foldr (:) [] xs) = foldr f z xs

Dem por ppio de induccion en la estructura de las listas
CASO INDUCTIVO: xs = (x:xs')
HI)¡ foldr f z (foldr (:) [] xs') = foldr f z xs' !
TI)¿ foldr f z (foldr (:) [] (x:xs')) = foldr f z (x:xs')
= def foldr 2
				= f x (foldr f z xs')
= HI)
				= f x (foldr f z (foldr (:) [] xs'))
= chamuyo foldr 2
				=  foldr f z (foldr(:) [] (x:xs'))

--f)

foldr f z (xs ++ ys) = foldr f (foldr f z ys) xs
Dem por ppio de induccion en la estructura de las listas

CASO INDUCTIVO: xs = (x:xs')
HI)¡ foldr f z (xs' ++ ys) = foldr f (foldr f z ys) xs' !
TI)¿ foldr f z ((x:xs') ++ ys) = foldr f (foldr f z ys) (x:xs') ?

= def foldr 2
f x (foldr f z (xs' ++ ys))
= def ++
f x (foldr f z (x:xs' ++ ys))
= HI) 
f x (foldr f (foldr f z ys) xs')
= def foldr
foldr f (foldr f z ys) (x:xs')

--g)

foldr :: (a -> b -> b) -> b -> [a] -> b
foldr f y []	 = y
foldr f y (x:xs) = f x foldr f y xs

(+1) . foldr (+) 0 = foldr (+) 1
por ppio de extensionalidad
(+1) . foldr (+) 0 xs = foldr (+) 1 xs
Dem por ppio de induccion en la estructura de xs

CASO INDUCTIVO: xs = (x:xs')
HI)¡ (+1) . foldr (+) 0 xs' = foldr (+) 1 xs' !
TI)¿ (+1) . foldr (+) 0 (x:xs') = foldr (+) 1 (x:xs') ?

(+1) . foldr (+) 0 (x:xs') = foldr (+) 1 (x:xs')
= def foldr 2
			= (+) x (foldr (+) 1 xs')
= HI
			= (+) x ((+1). foldr (+) 0 xs')
= def (.)
			= (+) x ((+1)(foldr (+) 0 xs'))
= aritm.
			= (+1) (+) x (foldr (+) 0 xs')
= def foldr
			= (+1) (foldr (+) 0 xs')

--h)

many n f = foldr (.) id (replicate n f)
por ppio de induccion en la estructura de n 
CASO INDUCTIVO : n = (n' + 1) 
HI)¡ many n' f = foldr (.) id (replicate n' f) !
TI)¿ many (n'+1) f = foldr (.) id (replicate (n'+1) f) ?

= def many 
f (many n' f)
HI)
f (foldr(.) id (replicate n' f))

foldr (.) id (replicate (n'+1) f)
= def replicate 2
foldr (.) id (f : (replicate (n'+1) f))
= def foldr 2
(.) f (foldr (.) id (replicate n' f)
= def (.)
f (foldr (.) id (replicate n' f))


--i)

zipWith (f . swap) = map (uncurry f) . flip zip
por ppio de extensionalidad 
zipWith (f . swap) xs ys = map (uncurry f) . flip zip xs ys
dem. por induccion en la estructura de xs e ys
4 CASOS 

CASO [] []:
def (.)											def (.)
zipWith (f (swap [] [])) = map (uncurry f) (flip zip [] [])
def swap								def flip
zipWith f [] [] 		 = map (uncurry f) (zip [] [])
def zipWith								def zip 1
[]						 = map (uncurry f) []
										def map 1
						 = []

CASO xs []:
TRIVIAL

CASO [] ys:
def (.)											def (.)
zipWith (f (swap [] ys)) = map (uncurry f) (flip zip [] ys)
def swap 										def flip
zipWith (f ys [])		 = map (uncurry f) zip ys []
def zipWith										def zip
[]						 = map (uncurry f) []
												def map
						 = []

CASO INDUCTIVO : xs = (x:xs') ys = (y:ys')
HI) ¡ zipWith f (swap xs' ys') = map (uncurry f) (flip zip xs' ys') !
TI) ¿ zipWith f (swap (x:xs') (y:ys')) = map (uncurry f) (flip zip (x:xs') (y:ys') ?

def swap 														def flip
zipWith f (y:ys') (x:xs')			   = map (uncurry f) (zip (y:ys') (x:xs'))
def zipWith	2												def zip	2  
f y x : zipWith f ys' xs'			   = map (uncurry f) ((y,x) : zip ys' xs'))	
def swap														def map 2
f y x : zipWith f (swap xs' ys')       = uncurry f (x,y) : map (uncurry f) (zip ys' xs')
HI)
f y x : map (uncurry f) (flip zip xs' ys')
def flip
f y x : map (uncurry f) (zip ys' xs')
def uncurry
uncurry f (x,y) : map (uncurry f) (zip ys' xs')

-}
--Ejercicio 9)

sum :: [Int] -> Int
sum xs = foldr sumar 0 xs

sumar :: Int -> Int -> Int
sumar x y = x + y

length' :: [a] -> Int
length' xs = foldr (sumar.dev1) 0 xs

dev1 :: a -> Int
dev1 _ = 1

map' :: (a -> b) -> [a] -> [b]
map' f xs = foldr f [] xs

filter :: (a -> Bool) -> [a] -> [a]
filter f xs = foldr (filtrar f) [] xs

filtrar :: (a -> Bool) -> a -> [a] -> [a]
filtrar f x xs' = if (f x) then (x : xs')
			   else xs'

esUno :: Int -> Bool
esUno 1 = True
esUno _ = False

find :: (a -> Bool) -> [a] -> Maybe a
find f xs = foldr (buscar f) Nothing xs

buscar :: (a -> Bool) -> a -> Maybe a -> Maybe a
buscar f x xs' = if (f x) then Just x
			  			  else xs' 

any :: (a -> Bool) -> [a] -> Bool
any f xs = foldr ((||) . f) False xs

all :: (a -> Bool) -> [a] -> Bool
all f xs = foldr ((&&) . f) True xs

countBy :: (a -> Bool) -> [a] -> Int
countBy f xs = foldr (sumarSi f) [] xs

sumarSi :: (a -> Bool) -> a -> Int -> Int
sumarSi f x n = if (f x) then (+) 1 n
						 else n

partition :: (a -> Bool) -> [a] -> ([a], [a])
partition f xs = foldr (particionar f) ([],[]) xs

particionar :: (a-> Bool) -> a -> ([a],[a]) -> ([a],[a])
particionar f x (ys, zs) = if (f x) then ((x:ys), zs)
									else (ys, (x:zs))

zipWith' :: (a -> b -> c) -> [a] -> [b] -> [c]
zipWith' h = foldr f g
    where f x r [] = []
          f x r (y:ys) = (:) (h x y) (r ys)
          g _ = []

foldr' :: (a -> b -> b) -> b -> [a] -> b
foldr' f y []	 = y
foldr' f y (x:xs) = f x (foldr' f y xs)

scanr' :: (a -> b -> b) -> b -> [a] -> [b]
scanr' f y xs = f (foldr f y xs) (scanr f y xs)

takeWhile :: (a -> Bool) -> [a] -> [a]
takeWhile f xs = foldr (tomarMientras f) [] xs

tomarMientras :: (a -> Bool) -> a -> [a] -> [a]
tomarMientras f y xs = if (f y) then y : xs
								else []

take' :: [a] -> (Int -> [a])
take' = foldr f g 
    where f _ _ 0 = []
          f x r n = x : r (n-1)
          g _ = []

take :: Int -> [a] -> [a] 
take = flip take'

drop' :: [a] -> (Int -> [a])
drop' xs = foldr f g xs
    where f x r n = if n > 0 then r (n-1) else x : r (n-1)
          g _ = []

drop :: Int -> [a] -> [a]
drop = flip drop'

(!!) :: Int -> [a] -> a
(!!) = flip (!!!)

(!!!) :: [a] -> (Int -> a)
(!!!) = foldr f g
    where f x r 0 = x
          f x r n = r (n-1)
          g n = error "No se encontro el elemento."

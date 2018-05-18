--1) TIPOS DE DATOS DEFINIDOS POR EL USUARIO

--1)

data Dir = Norte | Sur | Este | Oeste deriving (Eq, Show)



opuesto :: Dir -> Dir 
opuesto Norte = Sur
opuesto Sur   = Norte
opuesto Este  = Oeste
opuesto Oeste = Este

siguiente :: Dir -> Dir
siguiente Norte = Este
siguiente Este  = Sur
siguiente Sur   = Oeste
siguiente Oeste = Norte

--2)
data Persona = P String Int deriving (Eq, Show)

nombre :: Persona -> String
nombre (P s e) = s

edad :: Persona -> Int
edad (P s e) = e

crecer :: Persona -> Persona
crecer (P n e) = P n (e + 1)

cambioDeNombre :: String -> Persona -> Persona
cambioDeNombre str (P n e) = P str e
 
esMenorQueLaOtra :: Persona -> Persona -> Bool
esMenorQueLaOtra p1 p2 = edad p1 < edad p2

mayoresA :: Int -> [Persona] -> [Persona]
mayoresA i []     = []
mayoresA i (x:xs) = if i > edad x
			then x : mayoresA i xs
			else mayoresA i xs

--promedioEdad :: [Persona] -> Int
--promedioEdad xs = sumEdad xs / longitud xs

sumEdad :: [Persona] -> Int
sumEdad []     = 0
sumEdad (x:xs) = edad x + sumEdad xs

longitud :: [a] -> Int
longitud []     = 0
longitud (x:xs) = 1 + longitud xs

 
elMasViejo :: [Persona] -> Persona
elMasViejo []     = error "Al menos debe tener una persona."
elMasViejo [x]    = x
elMasViejo (x:xs) = maxViejo x (elMasViejo xs)

maxViejo :: Persona -> Persona -> Persona
maxViejo p1 p2 = if edad p1 > edad p2
			then p1
			else p2

--3)  
data Entrenador = Ent String [Pokemon] deriving (Eq, Show)

data Pokemon = Pok TipoDePokemon Int  deriving (Eq, Show)

data TipoDePokemon = Agua | Fuego | Planta deriving (Eq, Show)

bulbasaur :: Pokemon
bulbasaur = Pok Planta 100

charmander :: Pokemon
charmander = Pok Fuego 100

squirtle :: Pokemon
squirtle = Pok Agua 100

ash :: Entrenador
ash = Ent "Ash" [bulbasaur, squirtle]


esExperto :: Entrenador -> Bool
esExperto (Ent str xs) = pertenece Agua (listarTipos xs)
			 && pertenece Fuego (listarTipos xs)
			 && pertenece Planta (listarTipos xs)

tipoPok :: Pokemon -> TipoDePokemon
tipoPok (Pok t i) = t

listadoPokemon :: Entrenador -> [Pokemon]
listadoPokemon (Ent s xs) = xs

listarTipos :: [Pokemon] -> [TipoDePokemon]
listarTipos []    = []
listarTipos (x:xs) = tipoPok x : listarTipos xs

pertenece :: Eq a => a -> [a] -> Bool
pertenece e []     = False
pertenece e (x:xs) = e == x || pertenece e xs 


fiestaPokemon :: [Entrenador] -> [Pokemon]
fiestaPokemon []     = []
fiestaPokemon (x:xs) = listadoPokemon x ++ fiestaPokemon xs

todosLosTipos :: [TipoDePokemon]
todosLosTipos = Agua : Fuego : Planta :[]

esIgual :: TipoDePokemon -> TipoDePokemon -> Bool
esIgual Fuego Fuego   = True
esIgual Agua Agua     = True
esIgual Planta Planta = True
esIgual _ _           = False

leGana :: TipoDePokemon -> TipoDePokemon -> Bool
leGana Agua Fuego = True
leGana Fuego Planta = True
leGana Planta Agua = True
leGana _ _ = False

leGanaP :: Pokemon -> Pokemon -> Bool
leGanaP (Pok t1 i1) (Pok t2 i2) =  leGana t1 t2

capturarPokemon :: Pokemon -> Entrenador -> Entrenador
capturarPokemon p1 (Ent str xs) = Ent str (p1 : xs)

cantidadDePokemons :: Entrenador -> Int
cantidadDePokemons (Ent str xs) = longitud xs

cantidadDePokemonsDeTipo :: TipoDePokemon -> Entrenador -> Int
cantidadDePokemonsDeTipo t1 (Ent str xs) = ocurrenciasPok t1 xs

ocurrenciasPok :: TipoDePokemon -> [Pokemon] -> Int
ocurrenciasPok t1 []     = 0
ocurrenciasPok t1 (x:xs) = if esIgual t1 (tipoPok x)
							then 1 + ocurrenciasPok t1 xs
							else ocurrenciasPok t1 xs


lePuedeGanar :: Entrenador -> Pokemon -> Bool
lePuedeGanar (Ent str xs) p1 = algunoGanaA xs p1

algunoGanaA :: [Pokemon] -> Pokemon -> Bool
algunoGanaA [] p1     = False
algunoGanaA (x:xs) p1 = leGanaP x p1 || algunoGanaA xs p1


 
-- 4)

data Pizza = Prepizza | Agregar Ingrediente Pizza deriving (Eq, Show)

data Ingrediente = Salsa | Queso | Jamon | AceitunasVerdes Int deriving (Eq, Show)


ingredientes :: Pizza -> [Ingrediente]
ingredientes Prepizza      = []
ingredientes (Agregar i p) = i : ingredientes p


tieneJamon :: Pizza -> Bool
tieneJamon Prepizza      = False
tieneJamon (Agregar i p) = esJamon i || tieneJamon p
				 
esJamon :: Ingrediente -> Bool
esJamon Jamon = True
esJamon _     = False
				
sacarJamon :: Pizza -> Pizza
sacarJamon Prepizza      = Prepizza
sacarJamon (Agregar i p) = if esJamon i
				then sacarJamon p 
				else Agregar i (sacarJamon p)



armarPizza :: [Ingrediente] -> Pizza
armarPizza []     = Prepizza
armarPizza (x:xs) = Agregar x (armarPizza xs)


duplicarAceitunas :: Pizza -> Pizza
duplicarAceitunas Prepizza      = Prepizza
duplicarAceitunas (Agregar i p) = Agregar (dupAceituna i) (duplicarAceitunas p)


dupAceituna :: Ingrediente -> Ingrediente
dupAceituna (AceitunasVerdes x) = (AceitunasVerdes (x*2))
dupAceituna i                   = i

sacar :: [Ingrediente] -> Pizza -> Pizza
sacar [] p     = p
sacar (x:xs) p = if pertenece x (ingredientes p)
			then sacar xs (sacarIng x p)
			else sacar xs p 

sacarIng :: Ingrediente -> Pizza -> Pizza
sacarIng i1 Prepizza       = Prepizza
sacarIng i1 (Agregar i2 p) = if esIgualI i1 i2 
				then sacarIng i1 p
				else Agregar i2 (sacarIng i1 p)

esIgualI :: Ingrediente -> Ingrediente -> Bool
esIgualI Salsa Salsa = True
esIgualI Jamon Jamon = True
esIgualI Queso Queso = True
esIgualI (AceitunasVerdes _) (AceitunasVerdes _) = True
esIgualI _ _         = False


cantJamon :: [Pizza] -> [(Int, Pizza)]
cantJamon []     = []
cantJamon (x:xs) = (contarJamon x, x) : cantJamon xs

contarJamon :: Pizza -> Int
contarJamon Prepizza      = 0
contarJamon (Agregar i p) = if esJamon i
				then 1 + contarJamon p
				else contarJamon p

mayorNAceitunas :: Int -> [Pizza] -> [Pizza]
mayorNAceitunas i []     = []
mayorNAceitunas i (x:xs) = if mayorNAceitunas' i x
				then x : mayorNAceitunas i xs
				else mayorNAceitunas i xs

mayorNAceitunas' :: Int -> Pizza -> Bool
mayorNAceitunas' i Prepizza        = False
mayorNAceitunas' i (Agregar ing p) = ((cantAcei ing > i) && esAceituna ing) || mayorNAceitunas' i p


esAceituna :: Ingrediente -> Bool
esAceituna (AceitunasVerdes x) = True
esAceituna _                   = False

cantAcei :: Ingrediente -> Int
cantAcei (AceitunasVerdes x) = x
cantAcei _                   = 0



--5)

data Objeto = Cacharro | Tesoro deriving (Eq, Show)
data Camino = Fin | Cofre [Objeto] Camino | Nada Camino deriving (Eq, Show)

hayTesoro :: Camino -> Bool
hayTesoro Fin 		   = False
hayTesoro (Cofre xs c) = hayTesoro' xs || hayTesoro c
hayTesoro (Nada c)     = hayTesoro c

hayTesoro' :: [Objeto] -> Bool
hayTesoro' []     = False
hayTesoro' (x:xs) = esTesoro x || hayTesoro' xs

esTesoro :: Objeto -> Bool
esTesoro Tesoro = True
esTesoro _      = False

pasosHastaTesoro :: Camino -> Int
pasosHastaTesoro Fin 	      = 0
pasosHastaTesoro (Nada c)     = 1 + pasosHastaTesoro c
pasosHastaTesoro (Cofre xs c) = if hayTesoro' xs
					then 0
					else 1 + pasosHastaTesoro c


hayTesoroEn :: Int -> Camino -> Bool
hayTesoroEn i Fin          = False
hayTesoroEn i (Nada c)     = if i < 1
				then False
				else hayTesoroEn (i-1) c
hayTesoroEn i (Cofre xs c) = if i > 0
				then hayTesoroEn (i-1) c
				else hayTesoro' xs


alMenosNTesoros :: Int -> Camino -> Bool
alMenosNTesoros i c = cantidadTesorosTot c > i

cantidadTesorosTot :: Camino -> Int
cantidadTesorosTot Fin           = 0
cantidadTesorosTot (Nada c)      = cantidadTesorosTot c
cantidadTesorosTot (Cofre xs c)  = cantidadTesoros xs + cantidadTesorosTot c

cantidadTesoros :: [Objeto] -> Int
cantidadTesoros []     = 0
cantidadTesoros (x:xs) = if esTesoro x 
				then 1 + cantidadTesoros xs
				else cantidadTesoros xs


cantTesorosEntre :: Int -> Int -> Camino -> Int
cantTesorosEntre i1 i2 c = cantidadTesorosTot (subConjunto i1 i2 c)

subConjunto :: Int -> Int -> Camino -> Camino
subConjunto i1 i2 Fin          = Fin
subConjunto i1 i2 (Nada c)     = if i1 < 1
					then if i2 < 1
						then Fin
						else Nada (subConjunto (i1-1) (i2-1) c)
					else (subConjunto (i1-1) (i2-1) c)

subConjunto i1 i2 (Cofre xs c) = if i1 <= 1 
					then if i2 < 1
						then Fin
						else Cofre xs (subConjunto (i1-1) (i2-1) c)
					else (subConjunto (i1-1) (i2-1) c)
--6)

data ListaNoVacia a = Unit a | Cons a (ListaNoVacia a)

length' :: ListaNoVacia a -> Int
length' (Unit a)    = 1
length' (Cons a ls) = 1 + length' ls

head' :: ListaNoVacia a -> a
head' (Unit a)      = a
head' (Cons a ls)   = a

tail' :: ListaNoVacia a -> ListaNoVacia a
tail' (Unit a)    = error "BOOM"
tail' (Cons a ls) = ls

minimo :: ListaNoVacia Int -> Int
minimo (Unit i)    = i
minimo (Cons i ls) = min i (minimo ls)

--data T a = A | B a | C a a | D (T a) | E a (T a)

--Responder los siguientes items:
--Cuáles son los casos base? ¿Cuáles los recursivos









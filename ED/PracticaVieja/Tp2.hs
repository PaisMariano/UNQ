data Pizza = Prepizza | Agregar Ingrediente Pizza deriving (Eq, Show)

data Ingrediente = Salsa | Queso | AceitunasVerdes Int | Jamon deriving (Eq , Show)

-- Pizza
				  

ingredientes :: Pizza -> [Ingrediente]
ingredientes Prepizza = []
ingredientes (Agregar i p) = i : ingredientes p

duplicarAceitunas :: Pizza -> Pizza
duplicarAceitunas Prepizza = Prepizza
duplicarAceitunas (Agregar ing ps) = Agregar (dupAceituna ing) (duplicarAceitunas ps)

dupAceituna :: Ingrediente -> Ingrediente
dupAceituna i = if esAceituna i 
					then dobleAcei i
					else i
					
dobleAcei :: Ingrediente -> Ingrediente
dobleAcei (AceitunasVerdes n) = AceitunasVerdes (n*2)

esAceituna :: Ingrediente -> Bool
esAceituna (AceitunasVerdes n) = True
esAceituna x = False

tieneJamon :: Pizza -> Bool
tieneJamon Prepizza = False
tieneJamon (Agregar ing ps) = esJamon ing || tieneJamon ps

esJamon :: Ingrediente -> Bool
esJamon Jamon = True
esJamon x = False

sacarJamon :: Pizza -> Pizza
sacarJamon Prepizza = Prepizza
sacarJamon (Agregar i p) = if esJamon i
								then sacarJamon p
								else Agregar i (sacarJamon p)

armarPizza :: [Ingrediente] -> Pizza
armarPizza [] = Prepizza
armarPizza (x:xs) = Agregar (x) (armarPizza xs)

quesos :: [Pizza] -> [Ingrediente]
quesos [] = []
quesos (x:xs) = if esQueso (ingrediente x)
				then ingrediente x : quesos xs
				else quesos xs

ingrediente :: Pizza -> Ingrediente
ingrediente Prepizza = error "No puede tomar una pizza sin ingredientes"
ingrediente (Agregar i p) = i
				
esQueso :: Ingrediente -> Bool
esQueso Queso = True
esQueso x = False

--sacar :: [Ingrediente] -> Pizza -> Pizza


sacarIngrediente :: Pizza -> Ingrediente -> Pizza
sacarIngrediente Prepizza i = Prepizza
sacarIngrediente (Agregar i p) ing = 
									if ing == ingrediente (Agregar i p)
										then Agregar ing (sacarIngrediente p ing)
										else sacarIngrediente p ing


--cantJamon :: [Pizza] -> [(Int, Pizza)]


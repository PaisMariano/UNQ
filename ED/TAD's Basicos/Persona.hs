module Persona(Persona, crearP, nombre, edad, decrecer) where

data Persona = MkP String Int

-- Pretty Printing
instance Show Persona where
  show (MkP n e) = 
  	"{ nombre: " ++ n ++ 
  	" , edad: " ++ show e ++ " }"

-- Invariantes de representacion
-- Sea un MkP n e
--- entonces n no es vacio
--- y la edad es >= 0

-- Interfaz
-- Prec.: el nombre no es vacio
-- y la edad >= 0
crearP :: String -> Int -> Persona
crearP n e = 
	if null n || e < 0
		then undefined
		else MkP n e

edad :: Persona -> Int
edad (MkP n e) = e

nombre :: Persona -> String
nombre (MkP n e) = n

decrecer :: Persona -> Persona
decrecer (MkP n e) = 
	if e == 0
		then error "edad es 0"
		else MkP n (e-1)
module Comunidad(
	Grupo, 
	Persona, 
	Comunidad, 
	crearComunidad, 
	agregar, 
	personas, 
	gruposDe, 
	estaEnElGrupo, 
	enMasGrupos, 
	personasEn
) where

import Map
import Set
import Maybe

type Persona = String
type Grupo = String

data Comunidad = 
	MkC (Map Persona (Set Grupo)) 
	    (Map Grupo (Set Persona)) 
	    (Maybe Persona)

-- Invariantes de Representacion:
-- Sea MkC m1 m2 mb
-- No hay personas con grupos vacios
-- Los grupos y personas de m1 están en m2
-- mb es la persona con más grupos de m1

-- O(1)
crearComunidad :: Comunidad
crearComunidad = MkC emptyM emptyM Nothing

agregar :: Persona -> Grupo -> Comunidad -> Comunidad
agregar p g (MkC m1 m2 mp) =
	let rm1 = addM1 p g m1
	    rm2 = addM2 p g m2
	    in MkC rm1 rm2 (maxM rm1)

-- O(n)
addM1 :: Persona -> Grupo -> Map Persona (Set Grupo) -> Map Persona (Set Grupo)
addM1 p g m = assocM m p (addS g (maybeToSet (lookupM m p)))

-- O(n)
addM2 :: Persona -> Grupo -> Map Grupo (Set Persona) -> Map Grupo (Set Persona)
addM2 p g m = assocM m g (addS p (maybeToSet (lookupM m g)))

-- O(1)
maybeToSet :: Maybe (Set a) -> Set a
maybeToSet Nothing  = emptyS
maybeToSet (Just s) = s


maxM :: Map Persona (Set Grupo) -> Maybe Persona
maxM m = maxM' (domM m) m

maxM' :: [Persona] -> Map Persona (Set Grupo) -> Maybe Persona
maxM' []     m = Nothing
maxM' (p:ps) m =
	let r = maxM' ps m
	    in case r of
	    	Nothing   -> Just p
	    	(Just p') -> if sizeG p m > sizeG p' m
	    		            then Just p
	    		            else Just p'

-- Prec.: la persona existe en el map
sizeG :: Persona -> Map Persona (Set Grupo) -> Int
sizeG p m = sizeS (fromJust (lookupM m p))

-- O(n)
personas :: Comunidad -> [Persona]
personas (MkC m1 m2 mp) = domM m1

-- O(n)
gruposDe :: Persona -> Comunidad -> Set Grupo
gruposDe p (MkC m1 m2 mp) = 
	case lookupM m1 p of
		Nothing -> emptyS
		(Just gs) -> gs

-- O(n)
estaEnElGrupo :: Persona -> Grupo -> Comunidad -> Bool
estaEnElGrupo p g (MkC m1 m2 mp) = 
	case lookupM m1 p of
		Nothing   -> False
		(Just gs) -> belongs p gs

-- O(1)
enMasGrupos :: Comunidad -> Maybe Persona
enMasGrupos (MkC m1 m2 mp) = mp

-- O(n)
personasEn :: Grupo -> Comunidad -> Set Persona
personasEn g (MkC m1 m2 mp) = 
	case lookupM m2 g of
		Nothing -> emptyS
		(Just ps) -> ps
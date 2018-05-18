module Comunidad(Grupo, Persona, Comunidad) where

import Map
import Set

type Persona = String
type Grupo = String
data Comunidad = 
	MkC (Map Persona (Set Grupo)) (Map Grupo (Set Persona)) (Maybe Persona)
	
-- Invariantes de Representacion:
-- Sea MkC m1 m2 mb
-- No hay personas con grupos vacios
-- Los grupos y personas de m1 están en m2
-- mb es la persona con más grupos de m1
-- COMO IMPLEMENTADOR (calcular orden, cualquier orden)

--O(1) es constante siempre tarda lo mismo crear una comunidad.
crearComunidad :: Comunidad
crearComunidad = MkC emptyM emptyM Nothing

--O(n^2) en conMasGrupos por cada elemento de la lista se hace lookupM para el tamaño
agregar :: Persona -> Grupo -> Comunidad -> Comunidad
agregar p g (MkC m1 m2 mp) = MkC (agregarMP p g m1) (agregarMG g p m2) (conMasGrupos m1)

agregarMP :: Persona -> Grupo -> Map Persona (Set Grupo) -> Map Persona (Set Grupo)
agregarMP p g m1    = assocM m1 p (addS g (maybeToSet(lookupM m1 p)))

agregarMG :: Grupo -> Persona -> Map Grupo (Set Persona)) -> Map Grupo (Set Persona))
agregarMG g p m2    = assocM m2 g (addS p (maybeToSet(lookupM m1 g)))

maybeToSet :: Maybe (Set a) -> Set a
maybeToSet Nothing  = emptyS
maybeToSet (Just m) = m

conMasGrupos :: Map Persona (Set Grupo) -> Maybe Persona
conMasGrupos m1     = maxM (domM m1) m1
						 
maxM :: [Persona] -> Map Persona (Set Grupo) -> Maybe Persona
maxM [] m1  = Nothing
maxM (x:xs) m1       = case maxM xs m1 of 
						Nothing   -> Just x 
						(Just x') -> if sizeG x m1 > sizeG x' m1
										then Just x
										else Just x'

--Precondicion: dicha persona existe en el map									
sizeG :: Persona -> Map Persona (Set Grupo) -> Int
sizeG p m1 = sizeS (fromJust(lookupM m1 p))

--O(n) recorre el map en domM
personas :: Comunidad -> [Persona]
personas (MkC m1 m2 mp) = personasM m1

personasM :: Map Persona (Set Grupo) -> [Persona]
personasM m1 = domM m1

--O(n) recorre el map en lookupM
gruposDe :: Persona -> Comunidad -> Set Grupo
gruposDe p (MkC m1 m2 mp) = gruposDeM p m1

gruposDeM :: Persona -> Map Persona (Set Grupo) -> Set Grupo
gruposDeM p m1 = maybeToSet(lookupM m1 p)

--O(n) recorre individualmente en lookupM y belongs.
estaEnElGrupo :: Persona -> Grupo -> Comunidad -> Bool
estaEnElGrupo p g (MkC m1 m2 mp) = estaEnElGrupoM g p m2

estaEnElGrupoM :: Grupo -> Persona -> Map Grupo (Set Persona) -> Bool
estaEnElGrupoM p g m2 = belongs p (maybeToSet(lookupM m2 g))

--O(1) es constante ya dispone del valor
enMasGrupos :: Comunidad -> Maybe Persona
enMasGrupos MkC (m1 m2 mb) = mb

--O(n) Recorre el map buscando el set
personasEn :: Grupo -> Comunidad -> Set Persona
personasEn g (MkC m1 m2 mb) = personasEnM g m2

personasEnM :: Grupo -> Map Grupo (Set Persona) -> Set Persona
personasEnM g m2 = maybeToSet(lookupM m2 g)

-- COMO USUARIO (calcular orden, cualquier orden)
grupos :: Comunidad -> Set Grupo
grupos c = losGrupos (personas c) c

losGrupos :: [Persona] -> Comunidad -> Set Grupo
losGrupos [] c     = emptyS
losGrupos (x:xs) c = unionS (gruposDe x c) (losGrupos xs c)

compartenAlgunGrupo :: Persona -> Persona -> Comunidad -> Bool
compartenAlgunGrupo p1 p2 c = intersectan p1 p2 c

intersectan :: Persona -> Persona -> Comunidad -> Bool
intersectan p1 p2 c = (sizeS (intersectionS (gruposDe p1 c) (gruposDe p2 c))) > 0


enTodosLosGrupos :: Persona -> Comunidad -> Bool
enTodosLosGrupos p c = enTodosLosGrupos' (setToList(gruposDe p))(grupos c)

enTodosLosGrupos' :: [Grupo] -> Set Grupo -> Bool
enTodosLosGrupos' [] g     = True
enTodosLosGrupos' (x:xs) g = (belongs x g) && (enTodosLosGrupos' xs g)

grupoMasGrande :: Comunidad -> Maybe Grupo
grupoMasGrande c =  compararGrupo (setToList(grupos c)) c 

compararGrupo :: [Grupo] -> Comunidad -> Maybe Grupo
compararGrupo [] c     = Nothing
compararGrupo (x:xs) c = maxM x c (compararGrupo xs c) 

maxM :: Grupo -> Comunidad -> Maybe Grupo -> Maybe Grupo
maxM g c mg     = case mg of
						Nothing -> Just g
						Just g' -> Just (elQueMasTiene g g' c)
						
elQueMasTiene :: Grupo -> Grupo -> Comunidad -> Grupo
elQueMasTiene g g' c   = if sizeS(personasEn g c) > sizeS(personasEn g' c)
							then g
							else g'
							
							
grupoPersona :: Comunidad -> Set (Grupo, Persona)
fusionar :: Comunidad -> Comunidad -> Comunidad
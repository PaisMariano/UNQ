module ImplementadorComunidad(Grupo, Persona, Comunidad, crearComunidad, agregar, personas, estaEnElGrupo, enMasGrupos, personasEn, gruposDe) where

import Map3
import Set1

type Persona = String
type Grupo = String

data Comunidad = MkC (Map Persona (Set Grupo)) --Tipo de representacion: Map persona (Set Grupo)

-- Invariantes de Representacion:
-- No hay personas con grupos vacios
-- Todas las personas son personas validas.


-- COMO IMPLEMENTADOR (calcular orden, cualquier orden)


--A:
--O(1)
crearComunidad :: Comunidad
crearComunidad = MkC emptyM


--B:
agregar :: Persona -> Grupo -> Comunidad -> Comunidad
agregar p g (MkC map) = MkC (agregarPersonaAlGrupo p g map) 

agregarPersonaAlGrupo :: Persona -> Grupo -> Map Persona (Set Grupo) -> Map Persona (Set Grupo)
agregarPersonaAlGrupo p g map = assocM map p (addS g (losGruposDe p map))

losGruposDe :: Persona -> Map Persona (Set Grupo) -> Set Grupo
losGruposDe p map = case lookUpM map p of
							Nothing -> emptyS
							Just gs -> gs    


--C:
personas :: Comunidad -> [Persona]
personas (MkC map) = domM map


--D:
gruposDe :: Persona -> Comunidad -> Set Grupo
gruposDe p (MkC map) = losGruposDe p map    

--E:
estaEnElGrupo :: Persona -> Grupo -> Comunidad -> Bool
estaEnElGrupo p g (MkC map) = belongS g (losGruposDe p map)


--F:
enMasGrupos :: Comunidad -> Maybe Persona 
enMasGrupos (MkC map) = quienEstaEnMasGrupos map (domM map)

quienEstaEnMasGrupos :: Map Persona (Set Grupo) -> [Persona] -> Maybe Persona
quienEstaEnMasGrupos map xs = case xs of
							[] -> Nothing
							ps -> Just (elQueEstaEnMasGrupos map ps) 

laPersonaConMasGrupos :: Map Persona (Set Grupo) -> Persona -> Persona -> Persona
laPersonaConMasGrupos map p1 p2 = if sizeS (losGruposDe p1 map) > sizeS (losGruposDe p2 map)
											then p1
											else p2

elQueEstaEnMasGrupos :: Map Persona (Set Grupo) -> [Persona] -> Persona
elQueEstaEnMasGrupos map [] = error "Undefined"
elQueEstaEnMasGrupos map [p] = p
elQueEstaEnMasGrupos map (p : ps) = laPersonaConMasGrupos map p (elQueEstaEnMasGrupos map ps) 											 


--G:
personasEn :: Grupo -> Comunidad -> Set Persona
personasEn g (MkC map) = lasPersonasDel g (domM map) map

lasPersonasDel :: Grupo -> [Persona] -> Map Persona (Set Grupo) -> Set Persona
lasPersonasDel g [] map = emptyS
lasPersonasDel g (p : ps) map = if belongS g (losGruposDe p map)
										then addS p (lasPersonasDel g ps map)
										else lasPersonasDel g ps map

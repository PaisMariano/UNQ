module Comunidad(Grupo, Persona, Comunidad, crearComunidad, agregar, personas, gruposDe, estaEnElGrupo, enMasGrupos, personasEn) where

import Map3
import Set2	
import Auxiliares

type Persona = String
type Grupo = String
type Popular = Maybe Persona
data Comunidad = MkC (Map Persona (Set Grupo)) (Map Grupo (Set Persona)) Popular

-- Invariantes de Representacion:
-- Sea MkC map1 map2 mP
-- No hay personas con grupos vacios
-- No hay grupos sin personas.
-- Los grupos y personas de map1 están en map2
-- mP es la persona con más grupos de map1
-- Todas las personas son personas validas. (No hay ninguna "")
-- Todas los grupos son grupos validos. (No hay ningun "")


--O(1)
crearComunidad :: Comunidad
crearComunidad = MkC emptyM emptyM Nothing


--O(n) o O(log(n)) dependiendo el costo de assocM, de addS y de lookUpM.
agregar :: Persona -> Grupo -> Comunidad -> Comunidad
agregar persona grupo (MkC mapP mapG mP) = MkC ((agregarGrupo persona grupo mapP) (agregarPersona persona grupo mapG)) (elMasPopular persona mP mapP)

agregarGrupo :: Persona -> Grupo -> Map Persona (Set Grupo)
--Dado una persona, un grupo y un map Persona (Set Grupo), agrega a los grupos de esa persona ese grupo. Sino existe esa persona, la crea con ese unico grupo.  
agregarGrupo persona grupo mapP = case lookUpM map persona of
												Nothing -> assocM mapP persona (singletonS grupo)  
												Just setGrupo -> assocM mapP persona (addS grupo setGrupo)

--O(1) o (n) dependiendo del costo del addS.
singletonS :: Eq a => a -> Set a --Usuario Set
singleton x = addS x emptyS

--O(n) o O(log(n)) dependiendo el costo del assocM, del addS y del lookUpM.
--Dada una persona, un grupo y un map de Grupo Set Persona, agrega esa persona a las personas miembros del grupo.
agregarPersona :: Persona -> Grupo -> Map Grupo (Set Persona)
agregarPersona persona grupo mapG = case lookUpM map grupo of
												Nothing -> assocM mapG grupo (singletonS persona)  
												Just setPersona -> assocM mapG grupo (addS persona setPersona)

elMasPopular :: Persona -> Maybe Persona -> Maybe Persona
elMasPopular persona mP mapP = case lookUpM mapP persona of
										Nothing -> mP
										Just setGrupos -> if sizeS (losGruposDe mP mapP) >= sizeS setGrupos
																	then mP
																	else Just persona 

losGruposDe :: Maybe Persona -> Map Persona (Set Grupo) -> Set Grupo
losGruposDe mP mapP = case mP of 
							Nothing -> emptyS
							Just persona ->   
									case lookUpM mapP persona of
										Nothing -> emptyS --Incumple invariante.
										Just setGrupo -> setGrupo


personas :: Comunidad -> [Persona]
personas (MkC mapP _ _) = domM mapP 


gruposDe :: Persona -> Comunidad -> Set Grupo
gruposDe persona (MkC mapP _ _) = case lookUpM mapP persona of
												Nothing -> emptyS
												Just setGrupo -> setGrupo


estaEnElGrupo :: Persona -> Grupo -> Comunidad -> Bool
estaEnElGrupo persona grupo (MkC mapP mapG mP) = case lookUpM mapG grupo of
															Nothing -> False --Incumple el invariante.
															Just setPersona -> belongS persona setPersona


enMasGrupos :: Comunidad -> Maybe Persona
enMasGrupos (MkC _ _ mP) = mP

personasEn :: Grupo -> Comunidad -> Set Persona
personasEn grupo (MkC _ mapG _ ) = case lookUpM mapG grupo of
										Nothing -> emptyS
										Just setPersona -> setPersona

-- COMO USUARIO (calcular orden, cualquier orden)


grupos :: Comunidad -> Set Grupo
grupos comunidad = dameLosGrupos (personas comunidad) comunidad


dameLosGrupos :: [Persona] -> Comunidad -> Set Grupo
dameLosGrupos [] comunidad = emptyS
dameLosGrupos (persona : personas) comunidad = unionS (gruposDe persona comunidad) (dameLosGrupos personas comunidad) 


compartenAlgunGrupo :: Persona -> Persona -> Comunidad -> Bool
compartenAlgunGrupo persona1 persona2 = sizeS (intersectionS (gruposDe persona1) (gruposDe persona2)) > 0


enTodosLosGrupos :: Persona -> Comunidad -> Bool
enTodosLosGrupos persona comunidad = estaEnTodosLosGrupos persona (setToList (grupos comunidad)) comunidad

estaEnTodosLosGrupos :: Persona -> [Grupo] -> Comunidad -> Bool
estaEnTodosLosGrupos persona [] comunidad = True
estaEnTodosLosGrupos persona (grupo : grupos) comunidad = estaEnElGrupo persona grupo comunidad && estaEnTodosLosGrupos persona grupos


grupoMasGrande :: Comunidad -> Maybe Grupo
grupoMasGrande comunidad = elGrupoMasGrande (setToList (grupos comunidad)) comunidad

elGrupoMasGrande :: [Grupo] -> Comunidad -> Maybe Grupo
elGrupoMasGrande [] comunidad = Nothing
elGrupoMasGrande (grupo : grupos) comunidad = elQueMasPersonasTiene grupo (elGrupoMasGrande comunidad)


elQueMasPersonasTiene :: Grupo -> Maybe Grupo -> Comunidad -> Maybe Grupo
elQueMasPersonasTiene grupo maybe comunidad = case maybe of 
										Nothing -> Just grupo
										Just grupo' -> Just (elQueMasMiembrosTiene grupo grupo' comunidad)    

elQueMasMiembrosTiene :: Grupo -> Grupo -> Comunidad -> Grupo
elQueMasMiembrosTiene grupo1 grupo2 = if sizes (personasEn grupo1) >=  sizes (personasEn grupo2)
																then grupo1
																else grupo2


grupoPersona :: Comunidad -> Set (Grupo, Persona)
grupoPersona comunidad = hacerPares (setToList(grupos comunidad)) (personas comunidad) comunidad

--O(n.n)
hacerPares :: [Grupo] -> [Persona] -> Comunidad -> Set (Grupo, Persona)
hacerPares [] _ comunidad = emptyS
hacerPares (grupo : grupos) personas comunidad = unionS (parGrupoPersona personas grupo comunidad) (hacerPares grupos personas comunidad) 

--O(n) dependiendo del costo de addS
parGrupoPersona :: [Persona] -> Grupo -> Comunidad -> Set (Grupo, Persona)
parGrupoPersona [] grupo comunidad = emptyS
parGrupoPersona (persona : personas) grupo comunidad = 
	let conjuntoGP = parGrupoPersona personas grupo comunidad
	in 
		if estaEnElGrupo persona grupo comunidad
					then addS (hacerPar grupo persona) conjuntoGP  
					else conjuntoGP  


fusionar :: Comunidad -> Comunidad -> Comunidad
fusionar comunidad1 comunidad2 = fusionarComunidades comunidad1 (comunidad2 personas comunidad2)

fusionarComunidades :: Comunidad -> Comunidad -> [Persona] -> Comunidad
fusionarComunidades comunidad1 comunidad2 [] = comunidad1
fusionarComunidades comunidad1 comunidad2 (persona2 : personas2) =  
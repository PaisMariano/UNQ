import ImplementadorComunidad
import Set2

-- COMO USUARIO (calcular orden, cualquier orden)

--A:
grupos :: Comunidad -> Set Grupo
grupos comunidad = todosLosGrupos (personas comunidad) comunidad 

todosLosGrupos :: [Persona] -> Comunidad -> Set Grupo
todosLosGrupos [] comunidad = emptyS
todosLosGrupos (p : ps) comunidad = unionS (gruposDe p comunidad) (todosLosGrupos ps comunidad)


--B:
compartenAlgunGrupo :: Persona -> Persona -> Comunidad -> Bool
compartenAlgunGrupo p1 p2 comunidad = not (isEmptyS (interseccionS (gruposDe p1 comunidad) (gruposDe p2 comunidad))) 


--C:
enTodosLosGrupos :: Persona -> Comunidad -> Bool
enTodosLosGrupos p comunidad = estaEnTodosLosGrupos p (setToList (grupos comunidad)) comunidad 

estaEnTodosLosGrupos :: Persona -> [Grupo] -> Comunidad -> Bool
estaEnTodosLosGrupos p  [] comunidad = True
estaEnTodosLosGrupos p (g : gs) comunidad =  estaEnElGrupo p g comunidad && estaEnTodosLosGrupos p gs comunidad


--D:
grupoMasGrande :: Comunidad -> Maybe Grupo
grupoMasGrande comunidad = elGrupoConMasMiembros comunidad (personas comunidad) (setToList(grupos comunidad))

elGrupoConMasMiembros :: Comunidad -> [Persona] -> [Grupo] -> Maybe Grupo
elGrupoConMasMiembros comunidad ps [] = Nothing
elGrupoConMasMiembros comunidad ps [g] = Just g
elGrupoConMasMiembros comunidad ps (g : gs) = maxCantMiembrosM comunidad ps g (elGrupoConMasMiembros comunidad ps gs)

maxCantMiembrosM :: Comunidad -> [Persona] -> Grupo -> Maybe Grupo -> Maybe Grupo
maxCantMiembrosM comunidad ps g Nothing = Just g
maxCantMiembrosM comunidad ps g (Just g') = Just (elQueMasTiene comunidad ps g g') 

--grupoMasGrande comunidad = elGrupoConMasMiembros comunidad (personas comunidad) (setToList (grupos comunidad)) 
--elGrupoConMasMiembros comunidad ps (g : gs) = elQueMasTiene comunidad (personas comunidad) g (elGrupoConMasMiembros comunidad  ps gs)

elQueMasTiene :: Comunidad -> [Persona] -> Grupo -> Grupo -> Grupo
elQueMasTiene comunidad ps g1 g2 = if cantidadMiembros comunidad g1 ps >  cantidadMiembros comunidad g2 ps
																		then g1
																		else g2							    

cantidadMiembros :: Comunidad -> Grupo -> [Persona] -> Int
cantidadMiembros comunidad g [] = 0
cantidadMiembros comunidad g (p : ps) = if (belongS g (gruposDe p comunidad)) 
														then 1 + cantidadMiembros comunidad g ps
														else cantidadMiembros comunidad g ps


grupoPersona :: Comunidad -> Set (Grupo, Persona)
grupoPersona comunidad = listToSet(todosLosMiembrosDeTodosLosGrupos comunidad (setToList (grupos comunidad)) (personas comunidad) )  

todosLosMiembros :: Comunidad -> Grupo -> [Persona] -> [(Grupo, Persona)]
todosLosMiembros comunidad g [] = []
todosLosMiembros comunidad g (p : ps) = if estaEnElGrupo p g comunidad
															then (g, p) : todosLosMiembros comunidad g ps
															else  todosLosMiembros comunidad g ps

todosLosMiembrosDeTodosLosGrupos :: Comunidad -> [Grupo] -> [Persona] -> [(Grupo, Persona)]
todosLosMiembrosDeTodosLosGrupos comunidad [] _ = []
todosLosMiembrosDeTodosLosGrupos comunidad (g : gs) ps = (todosLosMiembros comunidad g ps) ++ todosLosMiembrosDeTodosLosGrupos comunidad gs ps   

--fusionar :: Comunidad -> Comunidad -> Comunidad

listToSet :: Eq a => [a] -> Set a
listToSet [] = emptyS
listToSet (x : xs) = addS x (listToSet xs)
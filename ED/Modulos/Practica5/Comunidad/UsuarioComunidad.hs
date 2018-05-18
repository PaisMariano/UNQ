import Set
import Comunidad

-- O(n^2)
grupos :: Comunidad -> Set Grupo
grupos c = grupos' (personas c) c

-- O(n^2)
grupos' :: [Persona] -> Comunidad -> Set Grupo
grupos' [] c = emptyS
grupos' (p:ps) c = unionS (gruposDe p c) (grupos' ps c)

-- O(n^2)
compartenAlgunGrupo :: Persona -> Persona -> Comunidad -> Bool
compartenAlgunGrupo p1 p2 c = sizeS (intersectionS (gruposDe p1 c) (gruposDe p2 c)) > 0

-- O(n^2)
enTodosLosGrupos :: Persona -> Comunidad -> Bool
enTodosLosGrupos p c = enTodosLosGrupos' (setToList (grupos c)) p c

-- O(n^2)
enTodosLosGrupos' :: [Grupo] -> Persona -> Comunidad -> Bool
enTodosLosGrupos' [] p c = True
enTodosLosGrupos' (g:gs) p c = estaEnElGrupo p g c && enTodosLosGrupos' gs p c

-- O(n^2)
grupoMasGrande :: Comunidad -> Maybe Grupo
grupoMasGrande c = grupoMasGrande' (setToList (grupos c)) c

-- O(n^2)
grupoMasGrande' :: [Grupo] -> Comunidad -> Maybe Grupo
grupoMasGrande' [] c = Nothing
grupoMasGrande' (g:gs) c = 
	let m = grupoMasGrande' gs c
	    in case m of
	    	Nothing   -> Just g
	    	(Just g') -> if sizeP g c > sizeP g' c
	    		            then Just g
	    		            else Just g'

sizeP :: Grupo -> Comunidad -> Int
sizeP g c = sizeS (personasEn g c)
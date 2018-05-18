import Persona
import Practica1

crecer :: Persona -> Persona
crecer p = crearP (nombre p)
                  (edad p + 1)

crecerTodas :: Tree Persona -> Tree Persona
crecerTodas EmptyT = EmptyT 
crecerTodas (NodeT x t1 t2) = 
	NodeT (crecer x) 
	 (crecerTodas t1)
	 (crecerTodas t2)

-- NOOO, y menos el parcial
-- crecer (MkP n e) = ...
-- crecer (crearP n e) = ...
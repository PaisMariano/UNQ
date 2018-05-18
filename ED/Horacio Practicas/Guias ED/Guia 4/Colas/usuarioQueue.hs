--------------------------------------------------------------------------------------------------------------
-------------------------------------- Usuario Queue ---------------------------------------------------------
--------------------------------------------------------------------------------------------------------------

import Queue3
import Auxiliares

largoQ :: Queue a -> Int
largoQ cola = cuantosElemHastaElFinal cola

cuantosElemHastaElFinal :: Queue a -> Int
cuantosElemHastaElFinal cola = 
								if isEmptyQ cola
										then 0
										else 1 + cuantosElemHastaElFinal (deQueue cola)

atender :: Queue Persona -> [Persona]
atender cola = if isEmptyQ cola
					then []
					else firstQ cola : atender (deQueue  cola)


unirQ :: Queue a -> Queue a -> Queue a
unirQ cola1 cola2 = if(isEmptyQ cola2)
							then cola1
							else unirQ (queue (firstQ cola2) cola1 (deQueue cola2))




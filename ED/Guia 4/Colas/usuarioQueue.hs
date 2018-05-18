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
					else (firstQ cola) : atender (deQueue  cola)


unirQ :: Queue a -> Queue a -> Queue a
unirQ cola1 cola2 = if(isEmptyQ cola1)
							then cola2
							else unirQ (deQueue cola1) (queue (firstQ cola1) cola2)


balanceado :: String -> Bool --(desafío)
--Toma un string que representa una expresión aritmética, por ejemplo
--"(2 + 3) * 2", y verifica que la cantidad de paréntesis que abren se
--corresponda con los que cierran. Para hacer esto utilice una stack.
--Cada vez que encuentra un paréntesis que abre, lo apila. Si encuentra
--un paréntesis que cierra desapila un elemento. Si al terminar de
--recorrer el string se desapilaron tantos elementos como los que se
--apilaron, ni más ni menos, entonces los paréntesis están balaceados.
--Pista: recorra una stack pasada por parámetro a una subtarea.
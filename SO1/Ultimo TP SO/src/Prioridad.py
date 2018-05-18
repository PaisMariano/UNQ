'''
@author: Mariano Pais y Tatiana Molinari.
'''

class Prioridad(PCP):
    
    

    def __init__(self):
        self.politica="Prioridad"
        self.ready=[]                  

    def hayAlgo(self):
        return not self.ready==[]
        
    def darSiguiente(self):
        return ready.pop(0) "Saca el primer elemento de la lista"

    def agregarProceso(self, proceso, prioridad):
        ready.append((prioridad,proceso))
        "agrega la tupla prioridad proceso"

    def ordenar()
        self.ready= sorted(self.ready, key=lambda proceso: prioridad)

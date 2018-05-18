'''
@author: Mariano Pais y Tatiana Molinari.
'''
from PCP import *

class Prioridad(PCP):
   

    def __init__(self, cpu):
        self.politica="Prioridad"
        self.ready=[]
        self.cpu=cpu

    def hayAlgo(self):
        return not self.ready==[]

    def procesarSiguiente(self):
        return self.cpu.agregarProceso(self.ready.pop()[1])
        
    def darSiguiente(self):
        return ready.pop(0)[1] ##Saca el primer elemento de la lista

    def agregarProceso(self, proceso):
        p=proceso.prioridad
        self.ready.append((p,proceso))
        self.ordenar()
        ##"Agrega la tupla prioridad proceso

    def ordenar(self):
        self.ready= sorted(self.ready, key=lambda ready: ready[0])

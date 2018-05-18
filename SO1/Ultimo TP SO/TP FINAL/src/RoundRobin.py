from queue import Queue
import Proceso
from Tiempo import *
'''
@author: Mariano Pais y Tatiana Molinari.
'''

class RoundRobin():    

    def __init__(self, quantum, kernel, cpu):
        self.politica = "Round Robin"
        self.ready = Queue()
        self.tiempo = Tiempo(quantum, kernel)
        self.cpu=cpu
        
    def hayAlgo(self):
        return not self.ready.empty()
        
    def ejecutarSiguiente(self):
        return self.ready.get()

    def procesarSiguiente(self):
        return self.cpu.agregarProceso(self.ready.get())
    
    def agregarProceso(self, proceso):
        self.ready.put(proceso)
    
    def tieneQuantum(self):
        return True

    def arrancarTiempo(self):
        self.tiempo.comenzarTiempo()


    

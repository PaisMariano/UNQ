from queue import Queue
import Proceso
'''
@author: Mariano Pais y Tatiana Molinari.
'''

class RoundRobin():    

    def __init__(self, quantum, claseTiempo):
        self.politica = "Round Robin"
        self.ready = Queue()
        self.quantum = quantum

    def hayAlgo(self):
        return not self.ready.empty()
        
    def ejecutarSiguiente(self):
        return self.ready.get()

    def agregarProceso(self, proceso):
        self.ready.put(proceso)

    def getQuantum(self):
        return self.quantum
    
    
proc = "hola"
q = RoundRobin(5)
print(q.hayAlgo())
q.agregarProceso(proc)
print(q.ready)
p = q.darSiguiente
print(p)
print(q.quantum)

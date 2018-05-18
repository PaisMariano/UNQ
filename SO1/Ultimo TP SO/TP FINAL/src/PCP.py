from multiprocessing import Queue
import threading
import time
'''
@author: Mariano Pais y Tatiana Molinari.
'''

class PCP():    

    def __init__(self, cpu):
        self.politica="FIFO"
        self.ready=Queue()
        self.cpu = cpu


    def hayAlgo(self):
        
        return not self.ready.empty()
        
    def procesarSiguiente(self):
        return self.cpu.agregarProceso(self.ready.get())

    def agregarProceso(self, p):
        self.ready.put(p)

    def tieneQuantum(self):
        return False


    
        

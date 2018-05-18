from multiprosessing import Queue
'''
Created on 21/05/2011

@author: Mariano
'''

class PCP(object):
    
    

    def __init__(self):
        self.politica="FIFO"
        self.ready=Queue()                  

    def hayAlgo(self):
        return not ready.empty()
        
    def ejecutarSiguiente(self):
        return ready.get()

    def agregarProceso(self, p):
        ready.put(p)
    
        

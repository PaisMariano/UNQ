from multiprosessing import Queue
'''
@author: Mariano Pais y Tatiana Molinari.
'''

class PCP(Thread):
    
    

    def __init__(self, cpu):
        self.politica="FIFO"
        self.ready=Queue()
        self.runing= False
        self.cpu = cpu
        threading.Thread.__init__(self)

    def hayAlgo(self):
        return not self.ready.empty()
        
    def procesarSiguiente(self):
        return self.cpu.agregarProceso(self.ready.get())

    def agregarProceso(self, p):
        self.ready.put(p)

    def run(self):
        while(self.runing)
            if(self.hayAlgo)
                self.procesarSiguiente()            

    
    
        

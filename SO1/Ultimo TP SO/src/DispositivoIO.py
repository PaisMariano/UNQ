import timer
import threading
'''
@author: Mariano Pais y Tatiana Molinari.
'''

class DispositivoIO(threading.Thread):
    def __init__(self, nombre, memoria, pcp):
        self.corriendo = False
        self.colaIO = Queue()
        self.nombre = nombre
        self.memoria = memoria
        self.pcp = pcp
        threading.Thread.__init__(self)   

    def getNombre(self):
        return self.nombre
    
    def startUp(self):
        self.corriendo = True
        self.run()

    def enviarAColaReady(self, proceso):
        self.pcp.agregarProceso(proceso)
        
    def procesarInstruccion(self):
        procesoActual= self.colaEntradaSalida.get()
        pc = procesoActual.getPc()
        currentInst = self.memoria.obtenerInstruccion(procesoActual.getId(), pc)
        currentInst.ejecutar()
        procesoActual.setPc(pc+1)
        self.enviarAColaReady(procesoActual)

    def agregarProceso(self, proceso):
        self.colaIO.put(proceso)
        
    def run(self)
        while(self.corriendo && KernelState.RUNNING):
            if(not (self.colaIO.empty())):
              self.procesarInstruccion()
            timer.sleep(0.5)
            
            
    

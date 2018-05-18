import threading
'''
@author: Mariano Pais y Tatiana Molinari.
'''
import time
from multiprocessing import Queue
from KernelState import *

class DispositivoIO(threading.Thread):
    def __init__(self, nombre, mmu):
        threading.Thread.__init__(self)
        self.corriendo = False
        self.colaIO = Queue()
        self.nombre = nombre
        self.mmu = mmu
        self.pcp = None
           
    
    def setearPCP(self, pcp):
        self.pcp=pcp
        
    def getNombre(self):
        return self.nombre
    
   
        
    def startUp(self):
        self.corriendo = True
        self.run()
        print("El Dispositivo ha iniciado...")

    def enviarAColaReady(self, proceso):
 
        self.pcp.agregarProceso(proceso)
        
    def procesarInstruccion(self):
        procesoActual= self.colaIO.get()
        pc = procesoActual.getPc()
        currentInst = self.mmu.obtenerInstruccion(procesoActual.getId(), pc)
        currentInst.ejecutar()
        procesoActual.setPc(pc+1)
        self.enviarAColaReady(procesoActual)

    def agregarProceso(self, proceso):
        self.colaIO.put(proceso)
        
    def run(self):
        while(KernelState.RUNNING):
            while(not KernelState.KERNEL_MODE):
                if(not (self.colaIO.empty())):
                    self.procesarInstruccion()
                time.sleep(0.5)
            
            
    

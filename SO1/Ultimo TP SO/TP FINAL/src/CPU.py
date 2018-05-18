import signal
import threading
from KernelState import *
import time
from InstIO import *

'''
@author: Mariano Pais y Tatiana Molinari.
'''
class Signal:
    SALIR = 1
    TIMER = 2
    IO_INSTRUCCION = 3
    IO_TERMINO = 4
    NUEVO = 5
    MATAR_PROCESO = 6
    TERMINO_PROCESO = 7



class CPU(threading.Thread):
    def __init__(self, mmu, dispositivo, kernel):
        threading.Thread.__init__(self)
        self.corriendo = False
        self.procesoActual = None
        self.mmu = mmu
        self.dispositivo = dispositivo
        self.kernel = kernel
        self.pcActual = None
          
   
        
    def startUp(self):
        self.corriendo = True
        self.run()
        
    
    def agregarProceso(self, proceso):
        self.procesoActual = proceso
        
    def procesarPrograma(self):
                
        while(not KernelState.KERNEL_MODE and not self.procesoActual == None):
            
            currentInst = self.mmu.obtenerInstruccion(self.procesoActual.getId(), self.pcActual)
            if  isinstance(currentInst,InstIO):
                    self.kernel.interrupcion(Signal.IO_INSTRUCCION)
            elif(currentInst == None):
                self.kernel.interrupcion(Signal.TERMINO_PROCESO)
            else:
                currentInst.ejecutar()
                self.pcActual = self.pcActual + 1
            time.sleep(1.5)

     
    def getPcActual(self):
        return self.pcActual

    def setPcActual(self, pc):
        self.pcActual = pc
    
    def getProcesoActual(self):
        return self.procesoActual

    def setProcesoActual(self, proceso):
        self.procesoActual = proceso 
    
        
    def run(self):
        time.sleep(0.5)
        ##  El while controla que la cpu este corriendo      
        while ( KernelState.RUNNING):
            ## Pone el proceso actual, el programa actual y el pc a ejecutar!
            if (not self.procesoActual == None ):
                self.procesarPrograma()
            time.sleep(0.5)
            
        


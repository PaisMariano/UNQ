import signal
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
    def __init__(self, memoria, dispositivo, kernel):
        self.corriendo = False
        self.procesoActual = None
        self.memoria = memoria
        self.dispositivo = dispositivo
        self.kernel = kernel
        self.pcActual = None
        threading.Thread.__init__(self)   
    

    def startUp(self):
        self.corriendo = True
        self.run()
    
    def agregarProceso(self, proceso):
        self.procesoActual = proceso
        
    def procesarPrograma(self):
                
        while(KernelState.RUNNING):
            currentInst = self.memoria.obtenerInstruccion(procesoActual.getId(), pcActual)
            if  isinstance(currentInst,InstIO):
                    self.kernel.interrupcion(Signal.IO_INSTRUCCION)
            elif(currentInst == None):
                self.kernel.interrupcion(Signal.TERMINO_PROCESO)
            else:
                currentInst.ejecutar()
                self.pcActual = self.pcActual + 1

     
    def getPcActual(self):
        return self.pcActual

    def setPcActual(self, pc):
        return self.pcActual = pc
    
    def getProcesoActual(self):
        return self.procesoActual

    def setProcesoActual(self, proceso):
        self.procesoActual = proceso 
    
        
    def run(self):
        ##  El while controla que la cpu este corriendo      
        while (self.corriendo && KernelState.RUNNING):
            ## Pone el proceso actual, el programa actual y el pc a ejecutar!
            if (not self.procesoActual == None ):
                self.procesarPrograma()
            timer.sleep(0.5)
            
        


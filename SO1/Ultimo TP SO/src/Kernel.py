'''
@author: Mariano Pais y Tatiana Molinari.
'''
import Memoria
import PCP
import PCB
import Programa
import sys

class Kernel(object):
    
    def __init__(self, pcp):
        self.memoria = Memoria()
        self.cpu = CPU()
        self.pcp=pcp
        self.DispositivoIO = DispositivoIO()
   
    def start(self):
        print("El Kernel esta comenzando a iniciar...")
        if not KernelState.RUNNING:
            KernelState.RUNNING = True
            self.cpu = CPU(self, self.memoria)
            #self.timer = Timer(self)
            self.DispositivoIO.start()
            self.cpu.start()
        print("El Kernel ha iniciado.")

            
    def stop(self):       
        KernelState.RUNNING = False
        sys.exit(0)
        print("Pasando a modo Kernel.")
  

    def interrupcion(self, signal):
        "PARAR TODO Y QUE SOLO CORRA EL KERNEL"
        self.lock.acquire()
        KernelState.KERNEL_MODE = True
          
        try: 
            if signal is Signal.SALIR:
                print('Interrupccion - Se ha salido del proceso pid %s'%(self.cpu.getProcesoActual().getId())
                self.exit()
                self.reschedule()
                      #REESTART TIEMPO...

            elif signal is Signal.TIMER:
                print('Interrupcción - Se ha acabado el tiempo para este proceso.')
                procesoActual= self.cpu.procesoActual
                self.reschedule()
                self.enviarProcesoColaReady(procesoActual)
                      #REESTART TIEMPO...

            elif signal is Signal.IO_INSTRUCCION:
                print('Interrupcción - Instrucción Entrada-Salida')
                procesoActual= self.cpu.procesoActual
                self.reschedule()
                self.enviarProcesoAIO(procesoActual)
                      #REESTART TIEMPO...

            elif signal is Signal.MATAR_PROCESO:
                print('Interrupcción - Se ha matado el proceso ')
                self.interrupt(Signal.SALIR)

            elif signal is Signal.TERMINO_PROCESO:
                print('Interrupcción - Se ha concluido este proceso.')
                self.memoria.borrarProg(self.cpu.getProcesoActual().getId())
                self.cpu.setProcesoActual(None)
                self.reschedule()

            else: # SEÑAL EQUIVOCADA, SE SALE DEL PROCESO.
                self.interrupt(Signal.SALIR) 

        finally:
                KernelState.KERNEL_MODE = False
                self.lock.release()

    def enviarProcesoAIO(self,proceso):
       self.DispositivoIO.agregarProceso(proceso)

    def enviarProcesoColaReady(self, proceso):
        self.pcp.agregarProceso(proceso)
        
     def exit(self):
        self.cpu.pc = None
        self.memoria.borrarProg(self.cpu.procesoActual.getId())
        self.cpu.procesoActual = None
        
    def reschedule(self):
        if ( not self.cpu.getProcesoActual()== None ):
            self.cpu.getProcesoActual().setPc(self.cpu.getPcActual())

        if (self.pcp.hayAlgo()):
            self.pcp.ejecutarSiguiente()
            self.cpu.setPcActual(self.cpu.getProcesoActual().getPc())
        else:
            self.cpu.setProcesoActual(None)

    def ejecutar(self, prog):
        self.lock.acquire()
        proceso= Proceso(prog.getId())
        self.pcp.agregarProceso(proceso)
        self.lock.release()
##      Manda el nuevo proceso a la cola de ready'
        
    
    def getMemoria(self):
        return self.memoria
  

        

        

        

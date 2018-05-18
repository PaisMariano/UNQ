'''
@author: Mariano Pais y Tatiana Molinari.
'''
import time
import signal
from PCP import * 
from PCB import * 
from Programa import *
from DispositivoIO import *
from CPU import *
from KernelState import *
from InstIO import *
from InstCPU import *
from Proceso import *
from MMU import *
import sys


class Kernel(object):
    
    def __init__(self):
        self.memoria = Memoria()
        self.mmu = MMU(self, self.memoria)
        self.dispositivoIO = DispositivoIO("ENTRADA/SALIDA", self.mmu)
        self.cpu = CPU(self.mmu, self.dispositivoIO, self)
        self.pcp=PCP(self.cpu)
        self.dispositivoIO.setearPCP(self.pcp)
        self.lock = threading.RLock()
        self.tablaDePaginas = {}
        
   
    def start(self):
        print("El Kernel esta comenzando a iniciar...")
        if not KernelState.RUNNING:
            KernelState.RUNNING = True
            self.cpu.start()
            self.dispositivoIO.start()
            if(self.pcp.tieneQuantum()):
                self.pcp.tiempo.start()
        print("El Kernel ha iniciado...")

            
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
                print('Interrupccion - Se ha salido del proceso pid %s'%(self.cpu.getProcesoActual().getId()))
                self.exit()
                self.reschedule()
                if(self.pcp.tieneQuantum() and (not (self.cpu.getProcesoActual()== None))):
                      self.pcp.arrancarTiempo()                      

            elif signal is Signal.TIMER:
                time.sleep(0.5)
                print('Interrupcción - Se ha acabado el tiempo para este proceso.')
                procesoActual= self.cpu.procesoActual
                self.reschedule()
                self.enviarProcesoColaReady(procesoActual)
                if(self.pcp.tieneQuantum() and not self.cpu.getProcesoActual()== None):
                      self.pcp.arrancarTiempo()

            elif signal is Signal.IO_INSTRUCCION:
                print('Interrupcción - Instrucción Entrada-Salida')
                procesoActual= self.cpu.procesoActual
                self.reschedule()
                self.enviarProcesoAIO(procesoActual)
                if(self.pcp.tieneQuantum() and not self.cpu.getProcesoActual()== None):
                      self.pcp.arrancarTiempo()

            elif signal is Signal.MATAR_PROCESO:
                print('Interrupcción - Se ha matado el proceso ')
                self.interrupt(Signal.SALIR)

            elif signal is Signal.TERMINO_PROCESO:
                print('Interrupcción - Se ha concluido este proceso.')
                self.mmu.borrarProg(self.cpu.getProcesoActual().getId())
                self.cpu.setProcesoActual(None)
                self.reschedule()
                if(self.pcp.tieneQuantum() and not self.cpu.getProcesoActual()== None):
                      self.pcp.arrancarTiempo()

            else: # SEÑAL EQUIVOCADA, SE SALE DEL PROCESO.
                self.interrupt(Signal.SALIR) 

        finally:
                KernelState.KERNEL_MODE = False
                self.lock.release()

    def enviarProcesoAIO(self,proceso):
       self.dispositivoIO.agregarProceso(proceso)

    def enviarProcesoColaReady(self, proceso):
        self.pcp.agregarProceso(proceso)

    def cargarEnMemoria(self, prog):
        print("Envia orden Kernel (cargar en memoria el prog) ")
        time.sleep(0.2)
        self.mmu.cargarEnMemoria(prog)
        

        
    def exit(self):
        self.cpu.pc = None
        self.mmu.borrarProg(self.cpu.procesoActual.getId())
        self.cpu.procesoActual = None
        
    def reschedule(self):
        if ( not self.cpu.getProcesoActual()== None ):
            self.cpu.getProcesoActual().setPc(self.cpu.getPcActual())

        if (self.pcp.hayAlgo()):
            self.pcp.procesarSiguiente()
            sigProceso=self.cpu.getProcesoActual()
            if(not sigProceso==None):
                self.cpu.setPcActual(self.cpu.getProcesoActual().getPc())
            
            
        else:
            self.cpu.setProcesoActual(None)

    def ejecutar(self, prog):
        self.lock.acquire()
        proceso = Proceso(prog.getId())
        self.pcp.agregarProceso(proceso)
        self.lock.release()
##      Manda el nuevo proceso a la cola de ready.
        
    
    def getMemoria(self):
        return self.memoria


    ##de aca en mas lo que agrego de memoria
    
    def ponerPaginaDeTablas(self, ids , listaDePaginas):
        self.tablaDePaginas[ids] = listaDePaginas
        print(self.tablaDePaginas)
        
    def getTablaDePaginas(self, ids):
        return self.tablaDePaginas.get(ids)

        

        

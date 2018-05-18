import threading
import time
from KernelState import *
from CPU import *

class Tiempo(threading.Thread):
    def __init__(self, quantum, kernel):
        self.quantum = quantum
        self.currentTime = 0
        self.stop = False 
        self.kernel = kernel
        threading.Thread.__init__(self)


    def comenzarTiempo(self): #Esto deberia ser cambiado al iniciar un proceso
        self.stop = False           # y al terminarlo para avisar'

    def dameTiempoStop(self):
        return self.stop
    
    def run(self):
        
        while (KernelState.RUNNING):    #aca va el repetidor del thread
            
            while (self.currentTime < self.quantum and not self.stop and not KernelState.KERNEL_MODE): #sale si quantum o si lo paran
                self.currentTime = self.currentTime + 1
                time.sleep(1.0)
            
            if (self.currentTime == self.quantum):
                self.currentTime = 0
                self.stop = True 
                self.kernel.interrupcion(Signal.TIMER) #Envia interrupcion al llegar al quantum

            


    def resetearValores(self):
        self.currentTime = 0
        self.stop = True


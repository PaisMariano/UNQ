import threading
import time

'''
@author: Mariano Pais y Tatiana Molinari.
'''

class Tiempo(threading.Thread):
    def __init__(self, quantum, kernel):
        self.quantum = quantum
        self.currentTime = 0
        self.stop = 0
        threading.Thread.__init__(self)

    def stopTiempo(self):
        self.stop = 1
    def dameTiempoStop(self):
        return self.stop
    
    def run(self):
        while (self.currentTime < self.quantum and self.dameTiempoStop = 0) #sale si quantum o si lo paran
            self.currentTime =  self.currentTime + 1
            time.sleep(0.1)
            
        if (self.currentTime = self.quantum)
            Kernel.interrupcion(Signal.TIMER) #Envia interrupcion al llegar al quantum


from PCB import *
from FCFS import *
from multiprocessing import Queue
import threading
import time

class ShortTimePlanifier:

    def __init__(self, cpuManager, politic=FCFS()):
        self.cpuManager=cpuManager
        self.politic=politic
        self.threadPlanifier = ThreadPlanifier(self)
        self.running = False         #Estado controlador propio
      
    def executeNextPCB(self):
        """Dependiendo de la politica de planificación, el CPUManager envia el PCB a la CPU"""
        nextPCB=self.politic.getNext(self.cpuManager.queueReady) 
        self.cpuManager.switchToCPU(nextPCB, self.politic.getQuantum())

    def hasPCB(self):
        """Pregunta si la cola de listos del CPUManager no está vacia"""
        return not self.cpuManager.queueReady.empty()

    def getRunning(self):
        return self.running
    
    def isRunning(self):
        return self.getRunning

    def setRunning(self, newState):
        self.running = newState
    
    def startUp(self):
        self.setRunning(True)
        self.threadPlanifier.start()

    def shutDown(self):
        self.setRunning(False)


class ThreadPlanifier(threading.Thread):
    def __init__(self, stp):
        threading.Thread.__init__(self)
        self.stp=stp

    def run(self):
        """Mientras el planificador de corto plazo este corriendo y si la cola de listos no este vacia, ejecuta su función"""
        while self.stp.isRunning():
            if(self.stp.hasPCB()):
                self.stp.executeNextPCB()
            time.sleep(1)

from multiprocessing import Queue
from CPU import *
import threading
import time

class CPUThread(threading.Thread):
    def __init__(self,cpu,cpuNumber,cpuQueue):
        threading.Thread.__init__(self)
        self.cpuQueue = cpuQueue
        self.cpu = cpu
        self.cpuNumber = cpuNumber

    def getCPUQueue(self):
        return self.cpuQueue

    def getCPU(self):
        return self.cpu
    
    def getCPUNumber(self):
        return self.cpuNumber

    def run(self):
        """Mientras la cpu este activa, va a tomar pcbs de su cola(si los hay), para ejecutarlos"""
        while self.cpu.getActive():
            if (not self.getCPUQueue().empty()):
                pairPCBQuantum = self.getCPUQueue().get()
                pcb = pairPCBQuantum[0]
                quantum = pairPCBQuantum[1]
                print("@ La CPU número: ", self.getCPUNumber(), "ha tomado el pcb del programa ", pcb.getProgram().getName())
                self.getCPU().execute(pcb,quantum)   
            time.sleep(1)

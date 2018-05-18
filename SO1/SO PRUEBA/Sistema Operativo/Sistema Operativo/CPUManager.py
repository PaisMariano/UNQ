from multiprocessing import Queue
from CPU import *
from CPUThread import *

class CPUManager:

    def __init__(self,queueReady,deviceManager,resultQueue,waitingProcess):
        self.queueReady = queueReady
        self.deviceManager = deviceManager
        self.resultQueue = resultQueue
        self.cpuQueue = Queue()                #Cola de procesos de CPU
        self.cpu = CPU(deviceManager,queueReady,resultQueue,waitingProcess)
        self.cpuThreads = []                   #Lista de threads simuladores de varios CPUs

    def getCPU(self):
        return self.cpu

    def getCPUQueue(self):
        return self.cpuQueue

    def getCPUThreads(self):
        return self.cpuThreads

    def addCPUs(self,cant):
        """ Agrega tantos CPUThreads como se le pase por parametro(simulando de esta manera a muchos cpus)"""
        for cpuNumber in range(cant):
            self.getCPUThreads().append(CPUThread(self.getCPU(),cpuNumber,self.getCPUQueue()))

        #Prints indicadores
        print("      **         - Consta de ", cant, "CPUs           **")
        print("      **                                       **")
        print("      *******************************************")

    def switchToCPU(self, pcb, quantum):
        """Envia el pcb con el quamtum correspondiente a la CPUQueue"""
        self.getCPUQueue().put((pcb,quantum))
		
    def startUp(self):
        for cpuThread in self.getCPUThreads():
            cpuThread.start()

    def shutDown(self):
        self.cpu.shutDown()
        

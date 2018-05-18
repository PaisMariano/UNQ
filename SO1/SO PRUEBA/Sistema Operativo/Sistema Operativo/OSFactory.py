from multiprocessing import Queue
from CPUManager import *
from DeviceManager import *
from RoundRobin import *
from OS import *

class OSFactory():
       
    def createOSRR(self, queueReady, resultQueue, quantum, numberCPU, ioDevicesDictionary, waitingProcess):
        """Genera un Sistema Operativo con política de planificación RoundRobin a partir de los parámetros dados"""
        scheduler = RoundRobin(quantum)
        return self.createOS(queueReady, resultQueue,scheduler, numberCPU, ioDevicesDictionary, waitingProcess)
    
    def createOS(self, queueReady, resultQueue, scheduler, numberCPU, ioDevicesDictionary, waitingProcess ):
        """Genera un Sistema Operativo a partir de los parámetros dados"""
        dm = DeviceManager(queueReady,resultQueue)
        dm.addDevices(ioDevicesDictionary)

        cpum = CPUManager(queueReady,dm,resultQueue,waitingProcess)
        cpum.addCPUs(numberCPU)
    
        os = OS(scheduler,cpum,dm,waitingProcess)
        return os

from multiprocessing import Queue
from DeviceThread import *

class Device:

    def __init__(self,deviceType,queueReady,resultQueue,quantity):
        self.deviceType = deviceType        #Tipo de dispositivo(ej:Impresora,etc)
        self.deviceThreads = []
        self.queueReady = queueReady
        self.resultQueue = resultQueue
        self.deviceQueue = Queue()
        self.isActive = True                #Variable controladora del arranque y corte del dispositivo
        self.addDevicesUnits(quantity)

    def getIsActive(self):
        return self.isActive

    def getDeviceType(self):
        return self.deviceType

    def setIsActive(self, newState):
        self.isActive = newState

    def getResultQueue(self):
        return self.resultQueue
 
    def getDeviceQueue(self):
        return self.deviceQueue

    def getQueueReady(self):
        return self.queueReady

    def getDeviceThreads(self):
        return self.deviceThreads

    def addDevicesUnits(self,quantity):
        """Genera tantos threads de un dispositivo correspondiente como lo indique su cantidad
           Simulando de esta manera la existencia de muchos dispositivos"""
        for devNumber in range(quantity):
            self.getDeviceThreads().append(DeviceThread(self,devNumber,self.getDeviceQueue(),self.getQueueReady()))

    def addToQueueDev(self,pcb):
        """Agrega un PCB a su cola de dispositivo"""
        self.getDeviceQueue().put(pcb)

    def switchToReady(self,pcb):
        """Agrega el PCB correspondiente a la cola de listos"""
        self.getQueueReady().put(pcb)

    def execute(self,pcb):
        """Ejecuta la instrucción correspondiente del PCB, aumenta el PC del PCB y pone el PCB en la cola de listos"""
        self.getResultQueue().put(pcb.getProgram().getInstructions()[pcb.getPC()])  #Agrega la instrucción ejecutada a una cola de resultados para un chequeo de funcionamiento posterior
        pcb.getProgram().getInstructions()[pcb.getPC()].execute(self,pcb) 
        pcb.setPC(pcb.getPC()+1)
        self.switchToReady(pcb)

    def startUp(self):
        """Arranca sus threads propios"""
        for devThread in self.getDeviceThreads():
            devThread.start()

    def shutDown(self):
        """Se apaga a si mismo"""
        self.setIsActive(False)
        
    

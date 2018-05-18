from multiprocessing import Queue
from LongTimePlanifier import *
from ShortTimePlanifier import *
import time

class OS:
    """Sistema Operativo"""
    def __init__(self,politic,cpuManager,deviceManager, waitingProcess):
        self.pcbt= Queue()
        self.politic = politic
        self.cpuManager = cpuManager
        self.deviceManager = deviceManager
        self.longTimePlanifier= LongTimePlanifier(cpuManager.queueReady)
        self.shortTimePlanifier= ShortTimePlanifier(cpuManager,politic)
        self.waitingProcess = waitingProcess
                
    def startUp(self):
        #Prints indicadores
        print("")
        print("-------------El Sistema Operativo ha arrancado -------------")
        print("")
        """Hace correr a  sus componentes"""
        self.shortTimePlanifier.startUp()
        self.deviceManager.startUp()
        self.cpuManager.startUp()

    def execute(self,prog):
        """Envia el PCB indicado al planificador de largo plazo"""
        pcb = PCB(prog)
        self.longTimePlanifier.switchToReady(pcb)

    def shutDown(self):
        """Le dice a sus componentes que se apaguen"""
        self.cpuManager.shutDown()
        self.deviceManager.shutDown()
        self.shortTimePlanifier.shutDown()
        #Prints indicadores
        print("")
        print("-------------El Sistema Operativo se ha apagado ------------")


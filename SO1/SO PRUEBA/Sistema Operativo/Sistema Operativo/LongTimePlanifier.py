from PCB import *

class LongTimePlanifier:

    def __init__(self,queueReady):
        self.queueReady=queueReady
    
    def switchToReady(self,pcb):
        """Encola el PCB determinado a la cola de listos"""
        self.queueReady.put(pcb)   
        

from Program import *
import uuid

class PCB:
    def __init__(self,prog):
        self.id = uuid.uuid1()    #Identificador propio del PCB
        self.prog=prog            
        self.pc=0
        self.state = "Ready"      #Estado del PCB

    def getId(self):
        return self.id

    def getPC(self):
        return self.pc

    def getState(self):
        return self.state

    def getProgram(self):
        return self.prog

    def setState(self, newState):
        self.state = newState

    def setPC(self, newPC):
        self.pc = newPC
    
    def setReady(self):
        self.setState("Ready") 

    def setWaiting(self):
        self.setState("Waiting")

    def setTerminated(self):
        self.setState("Terminated")

    def isWaiting(self):
        return self.getState() == "Waiting"

    def isTerminated(self):
        return self.getState() == "Terminated"
        

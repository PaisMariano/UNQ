from PCB import *
from InstCPU import *

class InstFork(InstCPU):
    """Instrucción FORK(disparadora de procesos hijos)"""
    def __init__(self,textCPU,progToExecute):
        InstCPU.__init__(self,textCPU,-1)
        self.progToExecute = progToExecute
        self.time=-1

    def execute(self,cpu,pcbParent):
        """Simula su ejecusión, creando un PCB para el proceso hijo, seteando su estado a 'espera'"""
        print("@CPU: Se está ejecutado la instrucción ", self.getText())
        childPCB = PCB(self.progToExecute)
        pcbParent.setWaiting()
        cpu.forkChildPCB(childPCB,pcbParent)

    def getText(self):
        return self.textInst

    def setText(self,textInst):
        self.textInst = texInst

    def getProgToExcecute(self):
        return self.progToExcecute

    def getTime(self):
        return self.time

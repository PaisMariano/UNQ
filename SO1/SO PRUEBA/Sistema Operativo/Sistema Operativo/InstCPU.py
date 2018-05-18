from Instruction import *

class InstCPU(Instruction):
    """Instrucción de CPU"""
    def __init__(self,textCPU,time):
        Instruction.__init__(self,textCPU,time)

    def execute(self,cpu,pcb):
        """Simula su ejecución"""
        Instruction.execute(self,cpu,pcb)
        print("@CPU: Se ha ejecutado la instrucción ", self.getText())

    def getText(self):
        return self.textInst
    
    def setText(self,textInst):
        self.textInst = textInst

    def getTime(self):
        return self.time

    def setTime(self, newTime):
        self.time = newTime
        

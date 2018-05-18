from Instruction import *

class InstIO(Instruction):
    """Instrucción de E/S"""
    def __init__(self,textIO,time,device):
        Instruction.__init__(self,textIO,time)
        self.device = device      #Describe el dispositivo propio de la instrucción
        
    def execute(self,cpu,pcb):
        """Simula su ejecución"""
        Instruction.execute(self,cpu,pcb)
        print("@E/S(",self.getDevice(),"): Ha ejecutado la instrucción ", self.getText())

    def getText(self):
        return self.textInst

    def setText(self,textInst):
        self.textInst = textInst

    def getTime(self):
        return self.time

    def setTime(self,newTime):
        self.time = newTime

    def getDevice(self):
        return self.device

    def setdevice(self,newDevice):
        self.device = newDevice

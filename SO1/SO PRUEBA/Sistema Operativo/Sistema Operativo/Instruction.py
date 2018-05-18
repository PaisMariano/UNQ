import time
from multiprocessing import Queue

class Instruction:
    def __init__(self,text,time):
        self.textInst=text
        self.time=time

    def execute(self,cpu,pcb):
        time.sleep(self.time)

    def getText(self):
        return self.textInst

    def setText(self,textInst):
        self.textInst = textInst

    def getTime(self):
        return self.time

    def setTime(self,newTime):
        self.time = newTime

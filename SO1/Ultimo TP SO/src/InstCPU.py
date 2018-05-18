'''
@author: Mariano Pais y Tatiana Molinari.
'''

from Instruction import *

class InstCPU(Instruction):
    
    def __init__(self,textCPU,time):
        Instruction.__init__(self,textCPU,time)

    def ejecutar(self,cpu,pcb):
        Instruction.execute(self,cpu,pcb)
        print(" La CPU ejecutó la instrucción ", self.getText())

     def getTexto(self):
        return self.textInst

    def setTexto(self,textoInst):
        self.textoInst = textoInst

    def getTiempo(self):
        return self.tiempo

    def setTiempo(self,nuevoTiempo):
        self.tiempo = nuevoTiempo
        

'''
@author: Mariano Pais y Tatiana Molinari.
'''
import time
from Instruccion import *

class InstCPU(Instruccion):
    
    def __init__(self, textCPU, time):
        Instruccion.__init__(self, textCPU, time)

    def ejecutar(self):
        print(" La CPU ejecutó la instrucción ", self.getTexto())
        time.sleep(self.tiempo)

    def getTexto(self):
         return self.textoInst

    def setTexto(self,textoInst):
        self.textoInst = textoInst

    def getTiempo(self):
        return self.tiempo

    def setTiempo(self,nuevoTiempo):
        self.tiempo = nuevoTiempo
        

from Instruccion import *
import time

'''
@author: Mariano Pais y Tatiana Molinari.
'''

class InstIO(Instruccion):

    def __init__(self,textoEO,tiempo,dispositivo):
        Instruccion.__init__(self,textoEO,tiempo)
        self.dispositivo = dispositivo 
        
    def ejecutar(self):
       
        print("El dipositivo de E/S(",self.getDispositivo().getNombre(),"): ejecutó la instrucción ", self.getTexto())
        time.sleep(1.5)
    def getTexto(self):
        return self.textoInst

    def setTexto(self,textoInst):
        self.textoInst = textoInst

    def getTime(self):
        return self.time

    def setTime(self,nuevoTiempo):
        self.tiempo = nuevoTiempo

    def getDispositivo(self):
        return self.dispositivo

    def setDispositivo(self,nuevoDispositivo):
        self.dispositivo = nuevoDispositivo

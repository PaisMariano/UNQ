from Instruction import *

'''
@author: Mariano Pais y Tatiana Molinari.
'''

class InstIO(Instruction):

    def __init__(self,textoEO,tiempo,dispositivo):
        Instruction.__init__(self,textoES,tiempo)
        self.dispositivo = dispositivo 
        
    def ejecutar(self,cpu,pcb):
       
        print("El sipositivo de E/S(",self.getDispositivo().getNombre(),"): ejecutó la instrucción ", self.getText())

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

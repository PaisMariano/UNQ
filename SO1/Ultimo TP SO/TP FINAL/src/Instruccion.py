import time
'''
@author: Mariano Pais y Tatiana Molinari.
'''
 

class Instruccion:
    def __init__(self,texto,tiempo):
        self.textoInst=texto
        self.tiempo=tiempo

    def ejecutar(self,cpu,pcb):
        tiempo.sleep(self.tiempo)
        print(self.texto)

    def getTexto(self):
        return self.textInst

    def setTexto(self,textoInst):
        self.textoInst = textoInst

    def getTiempo(self):
        return self.tiempo

    def setTiempo(self,nuevoTiempo):
        self.tiempo = nuevoTiempo

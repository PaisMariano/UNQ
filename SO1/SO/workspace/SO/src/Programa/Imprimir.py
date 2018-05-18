'''
Created on 26/08/2010

@author: Publico
'''
import Instruccion

class Imprimir(Instruccion.Instruccion):
    def __init__(self, texto, salida):
        self.texto = texto
        self.salida = salida
    def run(self):
        self.salida.mostrar(self.texto)
    
        
        
'''
@author: Mariano Pais y Tatiana Molinari.
'''

class Programa(object):
    

    def __init__(self, ids, nombre):
        self.instrucciones = []
        self.nombre=nombre
        self.id =ids
        self.numeroInsts=0
    
    def agregarInstruccion(self, ins):
        self.instrucciones = self.instruccion.add(ins)
        self.numeroInsts = self.numeroInts + 1
        
    def getNombre(self):
        return self.nombre
    
    def getId(self):
        return self.id

    def getInstruccion(self, num):
        return self.instrucciones.pop(num)

    def numeroInstrucciones(self):
        return self.numeroInsts
        
    

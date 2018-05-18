'''
@author: Mariano Pais y Tatiana Molinari.
'''

class Proceso(object):
       

    def __init__(self, ids, prioridad):
        self.id=ids
        self.pc=0
        self.prioridad=prioridad
        self.estado="Iniciado"
        
    def getId(self):
       return self.id

    def getPc(self):
        return self.pc

    def setPc(self, pc):
        self.pc=pc

    def setEstado(self, estado):
        self.estado = estado

    def getEstado(self):
        return self.estado
        

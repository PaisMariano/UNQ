'''
@author: Mariano Pais y Tatiana Molinari.
'''



class Memoria(object):


    def __init__(self):
        self.pcbt  = {}
        
    def agregarProg(self, prog):
        self.pcbt = self.pcbt[prog.id]=prog

    def borrarProg(self, ids):
        self.pcbt[ids] == None
        
    def buscarProg(self, ids):
       return self.pcbt[ids]

    def obtenerInstruccion(self, ids, pc):
        programa =  self.buscarProg(ids)
        if(pc < programa.numeroInstrucciones()):
            return programa.getInstruccion(pc)
        else:
            return None
        
        
        
        

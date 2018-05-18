import time
'''
@author: Mariano Pais y Tatiana Molinari.
'''

class Programa(object):
    

    def __init__(self, ids, nombre, prioridad, instrucciones):
        self.instrucciones = instrucciones
        self.instruccionesAux = instrucciones
        self.nombre=nombre
        self.id =ids
        self.prioridad=prioridad
        self.numeroInsts= len(instrucciones)
        self.agregarInstruccion(None)
    
    def agregarInstruccion(self, ins):
        self.instrucciones.append(ins)
        self.numeroInsts = self.numeroInsts + 1
        
    def getNombre(self):
        return self.nombre
    
    def getId(self):
        return self.id

    def getInstruccion(self, num):
        if(num<self.numeroInsts):
            
            return self.instrucciones[num]
        else:
            return None

    ##de aca en adelante metodos para Paginacion

    def numeroInstrucciones(self):
        return self.numeroInsts

    ##Devuelve cuatro paginas correspondientes al programa
    
    def dameCuatroInstrucciones(self):

        listCuatroInst = []
        j = 0
        while ((j < 4) and (self.instruccionesAux != [None])):
            listCuatroInst.append(self.instruccionesAux.pop(0))
            print("¡¡¡SE GRABO LA INSTRUCCION CORRECTAMENTE!!!")
            ##print(self.instruccionesAux)
            j = j + 1
            time.sleep(0.2)
            ##print(listCuatroInst)
        return listCuatroInst
    
    

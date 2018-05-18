import time

'''
@author: Mariano Pais y Tatiana Molinari.
'''
import signal


class Memoria(object):


    def __init__(self):
        self.pcbt  = {0: None, 1: "hola" , 2:None, 3:"hola", 4:None, 5:None, 6:"hola", 7:None, 8:None, 9:None, 10:None}

    def borrarProg(self, ids):
        self.pcbt[ids] == None

    def obtenerInstruccion(self, marco, corrimiento):
        ##busca en el pcbt cuando encuentra busca dentro de la lista de instrucciones
        inst = None
        time.sleep(0.2)
        try:
            inst = self.pcbt[marco][corrimiento]
        except IndexError:
            print("Termino de ejecutar proceso...")# or pass, do nothing just ignore that row...
        return inst


    ##de aca en mas para Paginacion

    def agregarPrograma(self, prog):       ##agrega programa en base al programa pasado por parametro generando los marcos en memoria
        i = 0
        listaMarcoPaginas = []
        contPaginas = 1
        cantTotal = self.calcularCantPaginas(prog)
        cantidadInstrucciones = self.calcularCantInstrucciones(prog)
        print("La cantidad de paginas del programa es: " , cantTotal)
        time.sleep(0.2)
        print("La cantidad de marcos en memoria es de: ", len(self.pcbt))
        while (i <= len(self.pcbt) and (contPaginas <= cantTotal)):
            if self.pcbt[i] is None:
                self.pcbt[i] = prog.dameCuatroInstrucciones()
                listaMarcoPaginas.append(i)
##                print(self.pcbt)
                contPaginas = contPaginas + 1
            i = i + 1
            if (i is len(self.pcbt)):
                print("NO HAY MEMORIA SUFICIENTE INTENTE LUEGO O CANCELE...")
            
        return listaMarcoPaginas
            ##pregunta por capacidad de memoria si es menor y si el cont
            ##no es menor a la cantidad total de instrucciones
        

    def calcularCantPaginas(self, programita): ##averigua la cantidad de paginas en base a las instrucciones del programa
        cantPaginas = 0
        val = programita.numeroInstrucciones() / 4
        if(float(val) > int(val)):
            cantPaginas = int(val) + 1
        return cantPaginas
    
    def calcularCantInstrucciones(self, prog):
        return prog.numeroInstrucciones()
        
        

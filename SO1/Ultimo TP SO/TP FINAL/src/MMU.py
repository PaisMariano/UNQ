

'''
@author: Mariano Pais y Tatiana Molinari.
'''

from Kernel import *
from Memoria import *

class MMU(object):


    def __init__(self, kern, mem):
        self.kernel = kern
        self.memoria = mem      
        self.listMarcoPaginas = []

        ##agrega el programa a memoria y devuelve los numeros de marco para generar la tabla de pags
    def cargarEnMemoria(self, prog):
        print("MMU se encarga de tomar el prog y proceder...")
        time.sleep(0.2)
        self.listMarcoPaginas = self.memoria.agregarPrograma(prog)
        print("Se a agregado en memoria al programa correctamente...")
        time.sleep(0.2)
        self.kernel.ponerPaginaDeTablas(prog.getId() , self.generarTablaPaginas()) ##genera tabla de paginas con (id, tablapagina)
        

    def generarTablaPaginas(self): ##genera tabla de paginas para el kernel
        tabla = {}
        i = 0
        
        while (i <= len(self.listMarcoPaginas)):
            tabla[i] = self.listMarcoPaginas.pop(0) ## i seria la pagina y listMarPags.pop(i) seria la direccion en la lista de marcos
            print("Se agrego a la tabla de paginacion del proceso", i,  tabla.get(i))
            time.sleep(0.2)
            i = i + 1
        return tabla                      

        
    def borrarProg(self, ids):
        i = 0
        tabla = len(self.kernel.getTablaDePaginas(ids).keys())
        print(tabla)
        procesoActual = self.kernel.getTablaDePaginas(ids).get(i)
        while ((procesoActual < tabla) and (procesoActual is not None)):
            self.memoria.pcbt[self.kernel.getTablaDePaginas(ids).get(i)] = None
            i = i + 1

    def obtenerInstruccion(self, ids, pc):
        
        tupla = self.calculadorDePagina(pc)
        pagina = tupla[0]
        time.sleep(0.2)
        corrimiento = tupla[1]
        marco = self.kernel.getTablaDePaginas(ids).get(pagina) ##Devuelve el marco de la pagina para encontrarlo en memoria
        if (self.memoria.obtenerInstruccion(marco, corrimiento) != None):
            return self.memoria.obtenerInstruccion(marco, corrimiento)
        else:
            self.kernel.interrupcion(Signal.TERMINO_PROCESO)
           
        
 ##Calcula Corrimiento y pagina del proceso para encontrar instruccion siguiente.
        
    def calculadorDePagina(self, pc):
        corrimiento = float(pc/4) - int(pc/4)
        if (pc % 4 != 0 or pc is 0):
            pagina = int(pc/4)
        else:
            pagina = int(pc/4) - 1

        if (corrimiento == 0):
            corrimiento = 0
        elif (corrimiento == 0.25):
            corrimiento = 1
        elif (corrimiento == 0.50):
            corrimiento = 2
        elif (corrimiento == 0.75):
            corrimiento = 3
        
        return (pagina, corrimiento)


            
        
        

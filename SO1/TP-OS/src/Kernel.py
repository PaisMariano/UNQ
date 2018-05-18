'''
Created on 21/05/2011

@author: Mariano
'''
import Memoria
import PCP
import PCB
import Programa

class Kernel(object):
    
    def __init__(self):
        self.memoria = Memoria()
        self.pcb
        self.cpu
        self.pcp
        self.corriendo = False
        '''GENERAR CONSTRUCTORES'''
        
    def start(self):
        print("Kernel ha iniciado...")
        self.setCorriendo(True)
            
    def stop(self):
        print("Kernel ha terminado...")
        self.setCorriendo(False)
    
    def ejecutar(self, prog):
        proceso= Proceso(prog.getId())
        self.pcp.agregarProceso(proceso) 'Manda el nuevo proceso a la cola de ready'
        
    
    def setCorriendo(self, Boolean):
        self.corriendo = Boolean
    
    def getCorriendo(self):
        return self.corriendo
        
        
        
    def 
        
        
        

        

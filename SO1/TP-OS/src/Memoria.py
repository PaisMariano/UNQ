'''
Created on 21/05/2011

@author: Mariano
'''
from multiprocessing import Queue



class Memoria(object):



    def __init__(self):
        self.memoria  = {}
        
    def agregarProg(self, prog):
        self.memoria = self.memoria[prog.id]=prog
        
    def buscarProg(self, id):
       return self.memoria[id]
        
        
        
        

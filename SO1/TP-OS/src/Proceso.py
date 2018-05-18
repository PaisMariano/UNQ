'''
Created on 21/05/2011

@author: Mariano
'''

class Proceso(object):
       

    def __init__(self, ids):
        self.id=ids
        self.pc=0
        self.estado
        
    def getId(self):
       return self.id

    def getPc(self):
        return self.pc

    def setPc(self, pc):
        self.pc=pc

        
        

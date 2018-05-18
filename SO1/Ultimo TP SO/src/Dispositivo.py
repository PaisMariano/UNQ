'''
@author: Mariano Pais y Tatiana Molinari.
'''
import threading

class DispositivoES(threading.Thread):
    def __init__(self, nombre):
        self.corriendo = False
        self.colaInstrucciones = Queue()
        self.nombre = nombre
        threading.Thread.__init__(self)   

    def startUp(self):
        self.corriendo = True
        self.run()

    def run(self)
        while(self.corriendo)
    

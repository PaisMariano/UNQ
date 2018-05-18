from threading import Thread
import time
from threading import Semaphore

lista = [1,2,3,"hola","chau",2,4,5,65,67,77,7,7,6,4,52,154,4,4,3,362,225,3,23,32,23,23] # Ini Lista.


class ThreadSafeList():
    def __init__(self, list = []):
        self.semaphore = Semaphore(1)
        self.list = list

class BorrarLista2(Thread):
    def __init__(self, l1):
        Thread.__init__(self)     # línea necesaria
        self.lista = l1

    def run(self):
        while (len(self.lista) > 0):
            time.sleep(1)
            self.lista.pop(0)
            print(self.lista)
                 


        
class BorrarLista1(Thread):
    def __init__(self, l1):
        Thread.__init__(self)     # línea necesaria
        self.lista = l1

    def run(self):
         while (len(self.lista) > 0):
            time.sleep(1)
            self.lista.pop(0)            
            print(self.lista)
           

c1 = BorrarLista1(lista)
c2 = BorrarLista2(lista)


c1.start()
c2.start()




# c3 = Consumidor("Pepe")
# c3.start()





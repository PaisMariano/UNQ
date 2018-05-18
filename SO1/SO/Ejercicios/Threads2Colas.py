from threading import Thread
import time

lista = [1,2,3,"hola","chau"] # Ini Lista.

class Semaforito:
    def __init__(self):
        Thread.__init__(self)
        self.flag = 1
        self.turno = 0
    def adquirir(self, id):
        if (self.flag == 0 or self.turno != id):
            time.sleep(1)
            self.adquirir(id)
        else:
            self.flag = 0
    def releer(self, id):
        self.flag = 1
        self.turno = (id + 1) % 2
        

class Imprimir(Thread):
    def __init__(self, l2):
        Thread.__init__(self)     # línea necesaria
        self.lista = l2

    def run(self):
        
        while (len(self.lista) > 0):
            semaforito.adquirir(0)
            print(self.lista)
            time.sleep(1)
            semaforito.releer(0)            

class PrintList(Thread):
    def __init__(self, l3):
        Thread.__init__(self)     # línea necesaria
        self.lista = l3
        
    def run(self):
        
        semaforito.adquirir(1)
        for x in self.lista:
            time.sleep(1)
            print(x)
        semaforito.releer(1)
        
class BorrarLista(Thread):
    def __init__(self, l1):
        Thread.__init__(self)     # línea necesaria
        self.lista = l1

    def run(self):
         while (len(self.lista) > 0):
            semaforito.adquirir(2)
            self.lista.pop(0)
            time.sleep(1)
            print(self.lista)
            semaforito.releer(2)


c2 = Imprimir(lista)
c3= PrintList(lista)
c1 = BorrarLista(lista)

c3.start()
c1.start()
c2.start()




# c3 = Consumidor("Pepe")
# c3.start()





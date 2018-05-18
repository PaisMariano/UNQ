from threading import Thread
import time

lista = [1,2,3,"hola","chau"] # Ini Lista.

class Imprimir(Thread):
    def __init__(self, l2):
        Thread.__init__(self)     # línea necesaria
        self.lista = l2

    def run(self):
        cont = 0
        while (cont < 5):
            print(self.lista)
            time.sleep(2)
            cont = cont + 1

class BorrarLista(Thread):
    def __init__(self, l1):
        Thread.__init__(self)     # línea necesaria
        self.lista = l1

    def run(self):
        cont = 0
        while (cont < 10):
            self.lista.pop(0)
            time.sleep(4)
            print(self.lista)
            cont = cont + 1



c2 = Imprimir(lista)
c1 = BorrarLista(lista)

c2.start()
c1.start()

# c3 = Consumidor("Pepe")
# c3.start()





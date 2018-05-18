from threading import Thread
import time


class Consumidor(Thread):
    def __init__(self, aName):
        Thread.__init__(self)     # línea necesaria
        self.name = aName

    def run(self):
        cont = 0
        while (cont < 10):
            print(self.name)
            print(self.name)
            time.sleep(1)
            print(self.name)

            cont = cont + 1


c2 = Consumidor("Mariana")
c1 = Consumidor("Mariano")

c1.start()
c2.start()

c3 = Consumidor("Pepe")
c3.start()





import time

class Animal:
    def __init__(self, peso, color):
        self.peso = peso
        self.color = color

x = Animal(55, "Marron")
print(x.peso,"," , x.color)

class Persona:
    def __init__(self, nombre, apellido, dni, peso, colorOjos, altura, edad, fechaDeNac, nacionalidad):
            self.nombre = nombre
            self.apellido = apellido
            self.dni = dni
            self.peso = peso
            self.colorOjos = colorOjos
            self.altura = altura
            self.edad = edad
            self.fechaDeNac = fechaDeNac
            self.nacionalidad = nacionalidad

    def decimeNombreApellidoDni(self):
        if self.nombre != "":
            print(self.nombre, self.apellido, self.dni)
    def decimeTuNacionalidad(self):
        if self.nacionalidad != "":
            print(self.nacionalidad)


Pepe = Persona("Pepe", "Gomez", "31600200", "90", "Marrones", "190", "27", "25-04-1983", "Cubano")
Pepe.decimeNombreApellidoDni()
Pepe.decimeTuNacionalidad()


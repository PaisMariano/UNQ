class Program:
    def __init__(self,name):
        self.name=name
        self.instructions = []     #Lista de instrucciones

    def getName(self):
        return self.name

    def getInstructions(self):
        return self.instructions
    
    def addInstruction(self,inst):
        """Agrega un instrucción a su lista de instrucciones"""
        self.instructions.append(inst)

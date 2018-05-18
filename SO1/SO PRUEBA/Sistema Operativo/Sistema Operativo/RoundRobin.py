class RoundRobin:
    """Política de planificación"""
    def __init__(self,q):
        self.quantum=q

    def getNext(self,queueReady):
        """retorna el siguiente CPU de la cola de listos"""
        return queueReady.get()

    def getQuantum(self):
        return self.quantum

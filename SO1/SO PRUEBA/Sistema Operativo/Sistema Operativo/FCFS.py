class FCFS:
    """Politica de planificación"""
    def getNext(self,queueReady):
        return queueReady.get()
 
    def getQuantum(self):
        return -1

from InstIO import *
from DeviceManager import *

class CPU:
    def __init__(self,deviceManager,queueReady,resultQueue,waitingProcess):
        self.deviceManager = deviceManager
        self.queueReady = queueReady
        self.resultQueue = resultQueue
        self.waitingProcess = waitingProcess
        self.isActive = True

    def setActive(self, newState):
        self.isActive = newState

    def getActive(self):
        return self.isActive

    def switchToDeviceManager(self,pcb):
        """Envia el pcb al DeviceManager """
        self.deviceManager.switchToDevice(pcb)

    def terminoProceso(self,pcb):
        """Me dice si un PCB terminó su ejecución"""
        return len(pcb.getProgram().getInstructions())<=pcb.getPC()
    
    def execute(self,pcb,quantum):
        """Comienza con la ejecución de un determinado PCB"""
        if not pcb.isWaiting() and not self.terminoProceso(pcb):  #Chequea estados
            if(quantum == -1):     #indicador de ejecución FCFS
                salioDeCPU = False
                while (not self.terminoProceso(pcb) and not salioDeCPU):  #Mientras el proceso no haya terminado su ejecución y no haya salido de CPU
                    salioDeCPU = self.processInstruction(pcb)   #procesa la instrucción indicandome si la ejecutó o si salió de CPU             
            else:
                self.executeWithQuantum(pcb,quantum)

        isTerminated = self.terminoProceso(pcb)
        if(isTerminated and(not pcb.isTerminated())): #Chequea estado del PCB
            pcb.setTerminated()                       #Actualiza su estado
            if(self.hasParentWaiting(pcb)):           #Si tiene un PCB padre en espera lo despierta
                self.wakeUpParent(pcb)
                
            else: print("@CPU: El PCB del programa", pcb.getProgram().getName()," ha terminadó su ejecución")

    def processInstruction(self,pcb):
        """Procesa la instrucción correspondiente del PCB"""
        currentInstruction=pcb.getProgram().getInstructions()[pcb.getPC()]
        if isinstance(currentInstruction,InstIO):  #Chequea el tipo de instrucción
            self.switchToDeviceManager(pcb)
            return True             #Indica que salió de CPU
        else:
            currentInstruction.execute(self,pcb)  #Ejecuta la instrucción
            pcb.setPC(pcb.getPC()+1)              #Aumenta el PC 
            if(pcb.isWaiting()):                  #Chequea estado
                return True
            else:
                self.resultQueue.put(currentInstruction)
                return False

    def executeWithQuantum(self,pcb,quantum):
        """Comienzo de ejecución con politica de planificación Round Robin"""
        quantumSaved = quantum
        estaEnReadyOEnIO = False
        while (not self.terminoProceso(pcb) and not estaEnReadyOEnIO and quantum>0): #Cheque estados
            if self.surpassQuantum(pcb,quantumSaved):  #Si no le alcanza el quantum manda el PCB a la cola de listos y resetea su quantum
                self.switchToReady(pcb)
                self.resetQuantum(quantum)
                estaEnReadyOEnIO = True
            else:                                  #Ejecuta la instrucción
                timeInst = pcb.getProgram().getInstructions()[pcb.getPC()].getTime()
                quantumSaved = quantumSaved - timeInst
                estaEnReadyOEnIO = self.processInstruction(pcb)

    def surpassQuantum(self,pcb,quantum):
        """Me dice si una determinada instricción se puede ejecutar con el quantum indicado"""
        return pcb.getProgram().getInstructions()[pcb.getPC()].getTime() > quantum

    def switchToReady(self,pcb):
        """Encola un PCB a la cola de listos"""
        self.queueReady.put(pcb)

    def resetQuantum(self,originalQuantum):
        """Restablece el quntum con el parámetro"""
        self.quantum=originalQuantum

    def forkChildPCB(self,childPCB,pcbParent):
        """Indica el PCB padre que tiene un PCB hijo, y pone en la cola de listos al PCB hijo"""
        self.waitingProcess[childPCB.getId()] = pcbParent
        print("@CPU: Se ha puesto el PCB padre en la cola de espera")
        self.queueReady.put(childPCB)
        print("@CPU: Se ha puesto el PCB hijo en la cola de listos")

    def hasParentWaiting(self,pcb):
        """Me dice si un determinado PCB tiene a un PCB padre en espera"""
        return pcb.getId() in self.waitingProcess.keys()
    
    def wakeUpParent(self, pcb):
        """Saca a un determinado PCB de la cola de espera, le cambia su estabo y lo pone en la cola de listos"""
        pcbToWake = self.waitingProcess.pop(pcb.id)
        pcbToWake.setReady()
        self.switchToReady(pcbToWake)
        print("@CPU: El PCB padre del programa", pcb.getProgram().getName()," ha sido encolado a la cola de listos")

    def shutDown(self):
        self.setActive(False)
    

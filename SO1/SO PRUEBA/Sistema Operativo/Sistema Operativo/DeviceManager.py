from Device import *

class DeviceManager:
    def __init__(self, queueReady,resultQueue):
        self.queueReady = queueReady
        self.resultQueue = resultQueue
        self.devices = {}          #Map de dispositivos

    def getResultQueue(self):
        return self.resultQueue

    def getDevices(self):
        return self.devices

    def getQueueReady(self):
        return self.queueReady

    def addDevices(self,deviceDictionary):
        """deviceDictionary es un  map donde la key es el nombre del dispositivo y el valor la cantidad del mismo.
            Agrega la cantidad dada del dispositivo especificado"""
        for deviceType,quantity in deviceDictionary.items():
            self.addDevice(deviceType,quantity)

    def addDevice(self,deviceType,quantity):
        """Genera un dispositivo y lo agrega a su map de dispositivos"""
        newDevice = Device(deviceType,self.getQueueReady(),self.getResultQueue(),quantity)
        self.getDevices()[deviceType] = newDevice
        
        #Prints indicadores
        print("      ************Información del SO*************")
        print("      **                                       **")
        print("      **        - Consta de ", quantity, deviceType,"        **")

    def findDevice(self,pcb):
        """Busca un dispositivo que satisfaga al PCB"""
        return self.getDevices()[pcb.getProgram().getInstructions()[pcb.getPC()].getDevice()]

    def switchToDevice(self,pcb):
        """Agrega el pcb a la cola del disposivo correspondiente"""
        device = self.findDevice(pcb)
        if (device is None):
            raise Exception("No existe el Device!!!")
        device.addToQueueDev(pcb)
                
    def startUp(self):
        """Le dice a todos los dispositivos que están en el map que arranquen"""
        for deviceType,device in self.getDevices().items():
            device.startUp()

    def shutDown(self):
        """Le dice a todos los dispositivos que están en el map que se apaguen"""
        for deviceType,device in self.getDevices().items():
            device.shutDown()
            
            



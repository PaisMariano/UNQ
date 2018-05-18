from multiprocessing import Queue
import threading
import time
from Device import *

class DeviceThread(threading.Thread):
    def __init__(self,device,devNumber,deviceQueue,queueReady):
        threading.Thread.__init__(self)
        self.device = device
        self.devNumber = devNumber
        self.deviceQueue = deviceQueue
        self.queueReady = queueReady

    def getDevice(self):
        return self.device

    def getDeviceQueue(self):
        return self.deviceQueue

    def run(self):
        while self.getDevice().getIsActive():
            if (not self.getDeviceQueue().empty()):
                self.getDevice().execute(self.getDeviceQueue().get())
            time.sleep(1)
 

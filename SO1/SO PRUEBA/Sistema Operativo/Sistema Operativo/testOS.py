from multiprocessing import Queue
from Program import *
from CPU import *
from InstCPU import *
from InstIO import *
from InstFork import *
from PCB import *
from LongTimePlanifier import *
from ShortTimePlanifier import *
import time
import unittest
from OS import *
from OSFactory import *

class TestOS(unittest.TestCase):
   
    def setUp(self):
        self.pa= Program("Notepad")
        self.pb= Program("WinRAR")
        self.pc= Program("Mozilla")

        self.ia1= InstCPU("Inst1",3)
        self.ia2= InstCPU("Inst2",4)
        self.ia3= InstCPU("Inst3",5)
        self.ia4= InstIO("Inst4",1,"Printer")

        self.ib1= InstIO("Inst5",2,"Printer")
        self.ib2= InstCPU("Inst6",2)
        self.ib3= InstCPU("Inst7",3)
        self.ib4= InstIO("Inst8",4,"Printer")
        
        self.ic1= InstIO("Inst9",1,"Printer")
        self.ic2= InstCPU("Inst10",2)
        self.ic3= InstCPU("Inst11",3)
        self.ic4= InstIO("Inst12",1,"Printer")

        self.fork = InstFork("FORK",self.pc)

        self.pa.addInstruction(self.ia1)
        self.pa.addInstruction(self.ia2)
        self.pa.addInstruction(self.ia3)
        self.pa.addInstruction(self.ia4)
        self.pb.addInstruction(self.fork)
        self.pb.addInstruction(self.ib1)
        self.pb.addInstruction(self.ib2)
        self.pb.addInstruction(self.ib3)
        self.pb.addInstruction(self.ib4)
        self.pc.addInstruction(self.ic1)
        self.pc.addInstruction(self.ic2)
        self.pc.addInstruction(self.ic3)
        self.pc.addInstruction(self.ic4)

    def testOSWithRoundRobinA(self):
        print("")
        print("")
        # arrange
        factory = OSFactory()
        self.queueReady=Queue()
        self.resultQueue=Queue()
        self.waitingProcess={}
        ioDictionary = {}
        ioDictionary["Printer"]=6
        self.os = factory.createOSRR(self.queueReady,self.resultQueue,5,1, ioDictionary,self.waitingProcess)

        # act
        self.os.startUp()
        self.os.execute(self.pa)
        time.sleep(2)
        self.os.execute(self.pc)
        time.sleep(30)
        self.os.shutDown()

        time.sleep(15)

        # assert
        self.assertEqual("Inst1",self.resultQueue.get().textInst)
        self.assertEqual("Inst9",self.resultQueue.get().textInst)
        self.assertEqual("Inst2",self.resultQueue.get().textInst)
        self.assertEqual("Inst10",self.resultQueue.get().textInst)
        self.assertEqual("Inst11",self.resultQueue.get().textInst)
        self.assertEqual("Inst3",self.resultQueue.get().textInst)
        self.assertEqual("Inst12",self.resultQueue.get().textInst)
        self.assertEqual("Inst4",self.resultQueue.get().textInst)


    def testOSWithRoundRobinB(self):
        print("")
        print("")
        # arrange
        factory = OSFactory()
        self.queueReady=Queue()
        self.resultQueue=Queue()
        self.waitingProcess={}
        ioDictionary = {}
        ioDictionary["Printer"]=6
        self.os = factory.createOSRR(self.queueReady,self.resultQueue,6,1, ioDictionary,self.waitingProcess)

        # act
        self.os.startUp()
        self.os.execute(self.pb)
        time.sleep(1)
        self.os.execute(self.pa)
        time.sleep(38)
        self.os.shutDown()

        time.sleep(15)

        # assert
        self.assertEqual("Inst1",self.resultQueue.get().textInst)
        self.assertEqual("Inst9",self.resultQueue.get().textInst)
        self.assertEqual("Inst2",self.resultQueue.get().textInst)
        self.assertEqual("Inst10",self.resultQueue.get().textInst)
        self.assertEqual("Inst11",self.resultQueue.get().textInst)
        self.assertEqual("Inst12",self.resultQueue.get().textInst)
        self.assertEqual("Inst3",self.resultQueue.get().textInst)
        self.assertEqual("Inst4",self.resultQueue.get().textInst)
        self.assertEqual("Inst5",self.resultQueue.get().textInst)
        self.assertEqual("Inst6",self.resultQueue.get().textInst)
        self.assertEqual("Inst7",self.resultQueue.get().textInst)
        self.assertEqual("Inst8",self.resultQueue.get().textInst)

        

    def testOSWithFCFSA(self):
        print("")
        print("")
        # arrange
        factory = OSFactory()
        self.queueReady=Queue()
        self.resultQueue=Queue()
        self.waitingProcess={}
        ioDictionary = {}
        ioDictionary["Printer"]=6
        self.os = factory.createOS(self.queueReady,self.resultQueue,FCFS(),1, ioDictionary,self.waitingProcess)

        # act
        self.os.startUp()
        self.os.execute(self.pb)
        time.sleep(25)
        self.os.execute(self.pa)
        time.sleep(25)
        self.os.shutDown()

        # assert
        self.assertEqual("Inst9",self.resultQueue.get().textInst)
        self.assertEqual("Inst10",self.resultQueue.get().textInst)
        self.assertEqual("Inst11",self.resultQueue.get().textInst)
        self.assertEqual("Inst12",self.resultQueue.get().textInst)
        self.assertEqual("Inst5",self.resultQueue.get().textInst)
        self.assertEqual("Inst6",self.resultQueue.get().textInst)
        self.assertEqual("Inst7",self.resultQueue.get().textInst)
        self.assertEqual("Inst8",self.resultQueue.get().textInst)
        self.assertEqual("Inst1",self.resultQueue.get().textInst)
        self.assertEqual("Inst2",self.resultQueue.get().textInst)
        self.assertEqual("Inst3",self.resultQueue.get().textInst)
        self.assertEqual("Inst4",self.resultQueue.get().textInst)

    def testOSWithFCFSB(self):
        print("")
        print("")
        # arrange
        factory = OSFactory()
        self.queueReady=Queue()
        self.resultQueue=Queue()
        self.waitingProcess={}
        ioDictionary = {}
        ioDictionary["Printer"]=6
        self.os = factory.createOS(self.queueReady,self.resultQueue,FCFS(),1, ioDictionary,self.waitingProcess)

        # act
        self.os.startUp()
        self.os.execute(self.pa)
        time.sleep(14)
        self.os.execute(self.pc)
        time.sleep(8)
        self.os.shutDown()

        # assert
        self.assertEqual("Inst1",self.resultQueue.get().textInst)
        self.assertEqual("Inst2",self.resultQueue.get().textInst)
        self.assertEqual("Inst3",self.resultQueue.get().textInst)
        self.assertEqual("Inst4",self.resultQueue.get().textInst)
        self.assertEqual("Inst9",self.resultQueue.get().textInst)
        self.assertEqual("Inst10",self.resultQueue.get().textInst)
        self.assertEqual("Inst11",self.resultQueue.get().textInst)
        self.assertEqual("Inst12",self.resultQueue.get().textInst)


    
suite = unittest.TestLoader().loadTestsFromTestCase(TestOS)
unittest.TextTestRunner(verbosity=2).run(suite)

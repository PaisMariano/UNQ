'''
Quick and dirty kernel simulator.

Created on Apr 14, 2011

@author: frepond
'''

import signal
import sys
import threading
import time

KERNEL_MODE = 0
RUNNING = 0

class Signal:
    EXIT = 1
    TIMER = 2
    IO_REQ = 3
    IO_END = 4
    NEW = 5
    KILL = 9
    
class State:
    READY = 0
    WAITING = 0

class Prog:
    def __init__(self, code=[], name=''):
        self.name = name
        self.code = code
        
    def __repr__(self):
        return 'Prog "%s" %s' % (self.name, self.code)
    
class Instr:
    CPU = 0
    IO = 1
    burst = 1
    
    def __init__(self, opcode=CPU, burst=1):
        self.opcode = opcode
        self.burst = burst
        
    def __repr__(self):
        if self.opcode == Instr.CPU:
            return 'CPU %d' % (self.burst)
        elif self.opcode == Instr.IO:
            return 'IO %d' % (self.burst)
 
class  PCB:
    inst = 0
    remaining_burst = 0
    prog = 0
    state = State.READY
    
class Memory:
    memory = {}
    
    def load(self, pid, prog):
        self.memory[pid] = prog
        
    def unload(self, pid):
        del self.memory[pid]

    def read(self, pc):
        pid = pc[0]
        instr_number = pc[1]
        process = self.memory[pid]
        
        if process == None or instr_number >= len(process.code) :
            return None
        else:   
            return process.code[instr_number]
    
    def __repr__(self):
        return 'memory%s'%(self.memory)
        

class CPU(threading.Thread):
    pc = None # pid, instr number, remaining burst
    
    def __init__(self, kernel, memory):
        threading.Thread.__init__(self)
        self.memory = memory
        self.kernel = kernel
        
    def run(self):
        global KERNEL_MODE
        global RUNNING
        
        while RUNNING: # CPU while system is running
            if self.pc is not None:
                instr = self.memory.read(self.pc)
                
                if instr is None:
                    self.kernel.interrupt(Signal.EXIT)
                elif instr.opcode is Instr.CPU:
                    self.pc = self.pc[0], self.pc[1], instr.burst
                        
                    while not KERNEL_MODE and self.pc[2] > 0: # executing
                        print('[cpu] %s - %s' % (instr, self.pc))
                        time.sleep(0.5) 
                        self.pc = self.pc[0], self.pc[1], self.pc[2] - 1
                        
                    if self.pc[2] == 0:
                        self.pc = self.pc[0], self.pc[1] + 1, self.pc[2] 
                elif instr.opcode is Instr.IO:
                    print('[cpu] %s - %s' % (instr, self.pc))
                    self.pc = self.pc[0], self.pc[1] + 1, self.pc[2]
                    self.kernel.interrupt(Signal.IO_REQ)
                else:
                    self.kernel.interrupt(Signal.KILL)
            else:
                time.sleep(0.1) # idle

class Kernel:
    ready = []
    memory = Memory()
    pcbt = {}
    cpu = None
    pid_counter = 0
    current_pid = None
    lock = threading.RLock()
    
    def  start(self):
        global RUNNING
        
        print('[kernel] starting...')
        
        if not RUNNING:
            RUNNING = 1
            self.cpu = CPU(self, self.memory)
            self.cpu.start()
            print('[kernel] started.')
        
    def stop(self):
        global RUNNING
        
        RUNNING = 0
        sys.exit(0)
    
    def interrupt(self, signal):
        global KERNEL_MODE
        self.lock.acquire()
        
        KERNEL_MODE = 1
        
        try: 
            if signal is Signal.EXIT:
                print('[signal] exit pid %s'%(self.current_pid))
                self.exit()
                self.reschedule()
            elif signal is Signal.TIMER:
                print('[signal] timer')
                self.reschedule()
            elif signal is Signal.IO_REQ:
                print('[signal] io_req')
                self.io()
                self.reschedule()
            elif  signal is Signal.KILL:
                print('[signal] kill')
                self.interrupt(Signal.EXIT)
            elif signal is Signal.NEW:
                print('[signal] new')
                if self.idle():
                    self.reschedule()
            else: # wrong signal, process terminated
                self.interrupt(Signal.EXIT) 
        finally:
            KERNEL_MODE = 0
            self.lock.release()
    
    def run(self, prog): # TODO: not synchronized
        self.lock.acquire()
        
        try:
            pid = self.pid_counter
            self.pid_counter = self.pid_counter + 1
            self.memory.load(pid, prog)
            self.ready.append(pid)
            self.pcbt[pid] = pid, 0, 0
        finally:
            self.lock.release()
        
        print('[kernel.run] pid %d: %s'%(pid, prog))
        
        self.interrupt(Signal.NEW)
        
    def reschedule(self):
        print('[kernel.sch] ready%s'%(self.ready))
        print('[kernel.sch] %s'%(self.memory))
        
        if self.cpu.pc is not None: # save pcb if necesary
            self.pcbt[self.current_pid] = self.cpu.pc
        
        if len(self.ready) > 0:  # schedule next process
            self.current_pid = self.ready.pop(0) # not efficient on lists but this is quick & dirty anyway!
            self.cpu.pc = self.pcbt[self.current_pid]
            
            print('[kernel.sch] scheduled pid %d'%(self.current_pid))
        else:
            self.set_idle()
            
    def exit(self):
        self.cpu.pc = None
        del self.pcbt[self.current_pid]
        self.memory.unload(self.current_pid)
        self.current_pid = None
        
    def io(self): # do nothing by now
        self.ready.append(self.current_pid)
        
    def idle(self):
        if self.current_pid is None:
            return True
        else:
            return False
    
    def set_idle(self):
        self.current_pid = None

def signal_handler(signal, frame):
    global RUNNING
        
    print("\n", "You pressed Ctrl+C!")
        
    RUNNING = 0
    sys.exit(0)


def main():
    prog = Prog([Instr(), Instr(Instr.CPU, 2), Instr(Instr.IO, 5), Instr(Instr.CPU, 4)], 'test.c')
    prog1 = Prog([Instr(Instr.IO, 5), Instr(Instr.CPU, 2), Instr(Instr.IO, 2), Instr(Instr.CPU, 4)], 'test1.c')

    kernel = Kernel()
    
    kernel.start()
    kernel.run(prog)
    kernel.run(prog1)
    
    # time.sleep(5)
    
    kernel.run(prog)
    kernel.run(prog)
    
    signal.signal(signal.SIGINT, signal_handler)
    signal.pause()

main()

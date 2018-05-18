from Kernel import *
from Memoria import *
from PCP import * 
from RoundRobin import *
from Prioridad import * 
from Programa import *
from DispositivoIO import *
from CPU import *
from KernelState import *
from InstIO import *
from InstCPU import *
from Proceso import *

class TesteadorKernel(object):

    def testKernelFIFO(self):
        k= Kernel()
        io= InstIO("Eo 1 del proceso nro 1",1.5,k.dispositivoIO)
        io2= InstIO("Eo 2 del proceso nro 1",1.5,k.dispositivoIO)
        io3= InstIO("Eo 3 del proceso nro 1",1.5,k.dispositivoIO)
        cpu = InstCPU("cpu 1 del proceso nro 1", 2.1)
        cpu2 = InstCPU("cpu 2 del proceso nro 1", 2.1)
        cpu3 = InstCPU("cpu 3 del proceso nro 1", 2.1)
        lista1=[io, cpu, cpu2, cpu3, cpu4, cpu5]

        ios= InstIO("Eos 1 del proceso nro 2",1.5,k.dispositivoIO)
        io2s= InstIO("Eos 2 del proceso nro 2",1.5,k.dispositivoIO)
        io3s= InstIO("Eos 3 del proceso nro 2",1.5,k.dispositivoIO)
        cpus = InstCPU("cpus 1 del proceso nro 2", 2.1)
        cpu2s = InstCPU("cpus 2 del proceso nro 2", 2.1)
        cpu3s = InstCPU("cpus 3 del proceso nro 2", 2.1)
        lista2=[ios, cpus, cpu2s, io2s, io3s, cpu3s]

        iose= InstIO("Eos 1 del proceso nro 3",1.5,k.dispositivoIO)
        io2se= InstIO("Eos 2 del proceso nro 3",1.5,k.dispositivoIO)
        io3se= InstIO("Eos 3 del proceso nro 3",1.5,k.dispositivoIO)
        cpuse = InstCPU("cpus 1 del proceso nro 3", 2.1)
        cpu2se = InstCPU("cpus 2 del proceso nro 3", 2.1)
        cpu3se = InstCPU("cpus 3 del proceso nro 3", 2.1)
        lista3=[io2se, cpuse, cpu2se, io2se, io3se, cpu3se]

        prog= Programa(123, "Programa 1", 2,lista1)
        prog2= Programa(456, "Programa 2", 3,lista2)
        prog3= Programa(789, "Programa 3", 6,lista3)

        k.agregarProg(prog)
        k.agregarProg(prog2)
        k.enviarProcesoColaReady(Proceso(prog2.id, prog2.prioridad))
        k.agregarProg(prog3)
        k.enviarProcesoColaReady(Proceso(prog3.id, prog3.prioridad))

        k.cpu.procesoActual=Proceso(prog.id, prog.prioridad)
        k.cpu.pcActual=0

        k.start()

    def testKernelPrioridad(self):
        k= Kernel()
        p=Prioridad(k.cpu)
        k.pcp=p
        k.dispositivoIO.pcp=p
        

        io= InstIO("Eo 1 del proceso nro 1",1.5,k.dispositivoIO)
        io2= InstIO("Eo 2 del proceso nro 1",1.5,k.dispositivoIO)
        io3= InstIO("Eo 3 del proceso nro 1",1.5,k.dispositivoIO)
        cpu = InstCPU("cpu 1 del proceso nro 1", 2.1)
        cpu2 = InstCPU("cpu 2 del proceso nro 1", 2.1)
        cpu3 = InstCPU("cpu 3 del proceso nro 1", 2.1)
        l=[io, cpu, cpu2, io2, io3, cpu3]

        ios= InstIO("Eos 1 del proceso nro 2",1.5,k.dispositivoIO)
        io2s= InstIO("Eos 2 del proceso nro 2",1.5,k.dispositivoIO)
        io3s= InstIO("Eos 3 del proceso nro 2",1.5,k.dispositivoIO)
        cpus = InstCPU("cpus 1 del proceso nro 2", 2.1)
        cpu2s = InstCPU("cpus 2 del proceso nro 2", 2.1)
        cpu3s = InstCPU("cpus 3 del proceso nro 2", 2.1)
        l2=[ios, cpus, cpu2s, io2s, io3s, cpu3s]

        iose= InstIO("Eos 1 del proceso nro 3",1.5,k.dispositivoIO)
        io2se= InstIO("Eos 2 del proceso nro 3",1.5,k.dispositivoIO)
        io3se= InstIO("Eos 3 del proceso nro 3",1.5,k.dispositivoIO)
        cpuse = InstCPU("cpus 1 del proceso nro 3", 2.1)
        cpu2se = InstCPU("cpus 2 del proceso nro 3", 2.1)
        cpu3se = InstCPU("cpus 3 del proceso nro 3", 2.1)
        l3=[io2se, cpuse, cpu2se, io2se, io3se, cpu3se]

##        iosed= InstIO("Eos 1 del proceso nro 4",1.5,k.dispositivoIO)
##        io2sed= InstIO("Eos 2 del proceso nro 4",1.5,k.dispositivoIO)
##        io3sed= InstIO("Eos 3 del proceso nro 4",1.5,k.dispositivoIO)
##        cpused= InstCPU("cpus 1 del proceso nro 4", 2.1)
##        cpu2sed= InstCPU("cpus 2 del proceso nro 4", 2.1)
##        cpu3sed = InstCPU("cpus 3 del proceso nro 4", 2.1)
##        l4=[cpused, cpu2sed, io2sed, io3sed, cpu3sed]

        prog= Programa(123, "Programa 1", 1,l)
        prog2= Programa(456, "Programa 2", 8,l2)
        prog3= Programa(789, "Programa 3", 6,l3)
##        prog4= Programa(1011, "Programa 4", 2,l4)

        k.agregarProg(prog)
        k.agregarProg(prog2)
        k.enviarProcesoColaReady(Proceso(prog2.id, prog2.prioridad))
        k.agregarProg(prog3)
        k.enviarProcesoColaReady(Proceso(prog3.id, prog3.prioridad))
##        k.agregarProg(prog4)
##        k.enviarProcesoColaReady(Proceso(prog4.id, prog4.prioridad))

        k.cpu.procesoActual=Proceso(prog.id, prog.prioridad)
        k.cpu.pcActual=0

        k.pcp.ordenar()

        k.start()

    def testKernelRoundRobin(self):
        k= Kernel()
        rr=RoundRobin(5,k,k.cpu)
        k.pcp=rr
        k.dispositivoIO.pcp=rr
        

        io= InstIO("Eo 1 del proceso nro 1",1.5,k.dispositivoIO)
        io2= InstIO("Eo 2 del proceso nro 1",1.5,k.dispositivoIO)
        io3= InstIO("Eo 3 del proceso nro 1",1.5,k.dispositivoIO)
        cpu = InstCPU("cpu 1 del proceso nro 1", 1.5)
        cpu2 = InstCPU("cpu 2 del proceso nro 1", 1.5)
        cpu3 = InstCPU("cpu 3 del proceso nro 1", 1.5)
        cpu4 = InstCPU("cpu 4 del proceso nro 1", 1.5)
        cpu5 = InstCPU("cpu 5 del proceso nro 1", 1.5)
        cpu6 = InstCPU("cpu 6 del proceso nro 1", 1.5)
        l=[io, cpu, cpu2, cpu3, cpu4, cpu5]

        ios= InstIO("Eos 1 del proceso nro 2",1.5,k.dispositivoIO)
        io2s= InstIO("Eos 2 del proceso nro 2",1.5,k.dispositivoIO)
        io3s= InstIO("Eos 3 del proceso nro 2",1.5,k.dispositivoIO)
        cpus = InstCPU("cpus 1 del proceso nro 2", 2.1)
        cpu2s = InstCPU("cpus 2 del proceso nro 2", 2.1)
        cpu3s = InstCPU("cpus 3 del proceso nro 2", 2.1)
        l2=[ios, cpus, cpu2s, io2s, io3s, cpu3s]

        iose= InstIO("Eos 1 del proceso nro 3",1.5,k.dispositivoIO)
        io2se= InstIO("Eos 2 del proceso nro 3",1.5,k.dispositivoIO)
        io3se= InstIO("Eos 3 del proceso nro 3",1.5,k.dispositivoIO)
        cpuse = InstCPU("cpus 1 del proceso nro 3", 2.1)
        cpu2se = InstCPU("cpus 2 del proceso nro 3", 2.1)
        cpu3se = InstCPU("cpus 3 del proceso nro 3", 2.1)
        l3=[io2se, cpuse, cpu2se, io2se, io3se, cpu3se]



        prog= Programa(123, "Programa 1", 1,l)
        prog2= Programa(456, "Programa 2", 8,l2)
        prog3= Programa(789, "Programa 3", 6,l3)


        k.cargarEnMemoria(prog)
        k.cargarEnMemoria(prog2)
        k.enviarProcesoColaReady(Proceso(prog2.id, prog2.prioridad))
        k.cargarEnMemoria(prog3)
        k.enviarProcesoColaReady(Proceso(prog3.id, prog3.prioridad))

        k.cpu.procesoActual=Proceso(prog.id, prog.prioridad)
        k.cpu.pcActual=0
    
        
        k.start()
        

tfifo = TesteadorKernel()
tfifo.testKernelRoundRobin()

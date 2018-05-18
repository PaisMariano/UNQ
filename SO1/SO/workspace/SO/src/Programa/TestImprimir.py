'''
Created on 26/08/2010

@author: Publico
'''
import unittest
from Imprimir import Imprimir
from Pantalla import Pantalla

class TestImprimir(unittest.TestCase):

    def testMostrado(self):
        p = Pantalla()
        impr = Imprimir("HOLA", p)
        impr.run()
        self.assertTrue(p.mostrado("HOLA"))

suite = unittest.TestLoader().loadTestsFromTestCase(TestImprimir)
unittest.TextTestRunner(verbosity=2).run(suite)
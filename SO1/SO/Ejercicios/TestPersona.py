from Persona import Persona
import unittest

class TestPersona(unittest.TestCase):
    
    def testCambiarNombre(self):
        pablo = Persona("Martin","Mario","Maria")
        pablo.CambiarNombre("Pablo")
        self.assertEqual("Pablo", pablo.nombre)
        
    def testPadreEsNulo(self):
        Roberto = Persona("Roberto", None, None)
        self.assertEqual(None, Roberto.padre)
    def testMadreEsNulo(self):
        Martina = Persona("Martina", "Paula", "Paula")
        self.assertEqual("Paula", Martina.madre)
    def testLargoNombre(self):
        Pepe = Persona("Pepe", None, None)
        self.assertTrue(len(Pepe.nombre) == 4)
    def testPenPepe(self):
        Pepe = Persona("Pepe", None, None)
        self.assertIn("e" , Pepe.nombre)
    def testPadreNuloYMadreNoNula(self):
        try:            
            Pepe = Persona("Pepe",None,"Maria")
            self.assertTrue(False)
        except HijoAmorfo:
            self.assertTrue(True)

suite = unittest.TestLoader().loadTestsFromTestCase(TestPersona)
unittest.TextTestRunner(verbosity=2).run(suite)

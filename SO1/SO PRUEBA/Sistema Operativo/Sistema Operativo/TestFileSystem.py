import unittest
from FileSystem import *
from Dir import *
from File import *
from Disk import *
from FAT import * 

class TestFileSystem(unittest.TestCase):

    def setUp(self):
        self.rootDir = Dir("ROOT")
        self.fs = FileSystem(self.rootDir)        

    def testMd(self):
        fs.md("SubDir1")
        self.assertTrue("SubDir1" in (fs.current.subDirs.keys()))
        self.assertTrue(fs.current.subDirs.get("SubDir1").getName(),"SubDir1")
        fs.md("SubDir2")
        self.assertTrue("SubDir2" in (fs.current.subDirs.keys()))
        self.assertTrue(fs.current.subDirs.get("SubDir2").getName(),"SubDir2")

    def testCd(self):
        fs.md("SubDir1")    #CREO UN SUBDIRECTORIO DESDE MI DIRECTORIO ACTUAL (ROOT)
        fs.cd("SubDir1")    #ACCEDO AL DIRECTORIO "SubDir1"
        self.assertTrue(fs.current.getName(),"SubDir1")    #EL DIRECTORIO ACTUAL DEBE SER "SubDir1"
"""
    def testToRoot(self):
        fs.md("SubDir1")    #CREO UN SUBDIRECTORIO DESDE MI DIRECTORIO ACTUAL (ROOT)
        fs.cd("SubDir1")    #ACCEDO AL DIRECTORIO "SubDir1"
        fs.toRoot()         #REGRESO AL DIRECTORIO RAIZ
        self.assertTrue(fs.current.getName(),fs.root.getName())    #EL DIRECTORIO ACTUAL DEBE SER EL DIRECTORIO RAIZ
"""

disk = Disk("C",5,10)
fat = FAT(disk,0)
fat.writeDisk("anduvooooo")
print(fat.table)
for i in range(len(disk.clusters)-1):
    print(disk.clusters[i].data)

suite = unittest.TestLoader().loadTestsFromTestCase(TestFileSystem)
unittest.TextTestRunner(verbosity=2).run(suite)

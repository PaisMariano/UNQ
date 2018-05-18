
import grt

# NOTE: If you're using this in a module, it should be imported as 
# from wb import *


class DefineModule(dict):
    def __init__(self, name, implements=None, author="", version= "", description= ""):
        """Define a GRT module. Must be called before any function declaration as
        wbmodule = DefineModule('modname')
        """

        self.name= name
        self.author= author
        self.version= version
        self.description= description
    
        # List of functions exported by the module (automatically updated by @declare)
        self.functions= []
        # List of interfaces implemented by the module
        self.implements= implements or []
    
        self._pluginList= grt.List(grt.OBJECT, "app.Plugin")

        
        
    def __getitem__(self, name):
        return getattr(self, name)


    ##
    ## Decorators for Writing Modules and Plugins
    ##
    def plugin(self, name, caption= "", type="normal", input= [], groups= [], pluginMenu= None):
        """Decorator to declare a Plugin, used in addition to @wbexport
        Usage:
        @wbmodule.plugin("db.utils.mangleNames", caption="Mangle Names", input= [wbinputs.currentCatalog()], groups=["Menu/Catalog"])
        @wbmodule.export(grt.INT, grt.classes.db_Catalog)
        def mangleNames(catalog):
           return 1
        """
        
        def setup_plugin(fn):    
            # make sure getPluginInfo() is in the function list
            if "getPluginInfo" not in [x[0] for x in self.functions]:
              self.functions.append(("getPluginInfo", 
                                              ((grt.LIST, (grt.OBJECT, "app.Plugin")),
                                              []),
                                              lambda: self._pluginList))
              if "PluginInterface" not in self.implements:
                  self.implements.append("PluginInterface")
            
            plug= grt.classes.app_Plugin()
            plug.name= name
            plug.caption= caption
            plug.pluginType= type
            plug.moduleName= self.name
            plug.moduleFunctionName= fn.func_code.co_name
            for i in input:
              i.owner= plug
              plug.inputValues.append(i)
            for g in groups:
              plug.groups.append(g)
            if pluginMenu:
              plug.groups.append("Menu/"+pluginMenu)
            plug.rating= 100
            plug.showProgress= 0
            self._pluginList.append(plug)
            
            return fn
        
        return setup_plugin
    
    
    
    
    def export(self, returntype, *argtypes):
        """Decorator to declare an exported Module function.
        Usage:
        @wbmodule.export(grt.INT, grt.classes.db_Table, (grt.LIST, grt.STRING))
        def dostuff(arg1, arg2):
          return 1
        
        Declares the function dostuff as returning an integer and having the 1st arg a db.Table and
        the 2nd a list of strings.
        """
        typenames= [grt.INT,grt.DOUBLE,grt.STRING,grt.LIST,grt.DICT, grt.OBJECT]
        def set_types(fn):
            if len(argtypes) != fn.func_code.co_argcount:
              raise TypeError("module function declaration with wrong # of type names")
            arglist= []
            for i in range(len(argtypes)):
              arg= argtypes[i]
              
              if type(arg) == tuple:
                containertype, contenttype= arg
                if containertype not in [grt.LIST, grt.DICT]:
                  raise TypeError("argument %i has invalid specification"%i)
                if contenttype not in typenames and contenttype not in grt.classes:
                  raise TypeError("argument %i has invalid specification"%i)
                
                if contenttype in grt.classes:
                  contenttype= (grt.OBJECT, contenttype.__name__.replace("_", "."))
                  
                arg= (containertype, contenttype)
              elif arg in (grt.INT, grt.DOUBLE, grt.STRING, grt.LIST, grt.DICT):
		pass
              elif (type(arg) == str and arg not in typenames) and arg not in grt.classes:
                raise TypeError("%s not a valid GRT type specification"%str(arg))
              else:
                arg= (grt.OBJECT, arg.__name__.replace("_", "."))
            
              arglist.append((fn.func_code.co_varnames[i], arg))
            signature= (returntype, arglist)
        
            self.functions.append((fn.func_code.co_name, signature, fn))
            return fn
        return set_types
  
  

#
# Plugin input type helpers and predefined types.
#


class _wbinputs:
  def currentCatalog(self):
    arg= grt.classes.app_PluginObjectInput()
    arg.objectStructName= "db.Catalog"
    return arg
    
  def currentDiagram(self):
    arg= grt.classes.app_PluginObjectInput()
    arg.objectStructName= "workbench.physical.Diagram"
    return arg

  def objectOfClass(self, className):
    assert type(className) == str
    arg= grt.classes.app_PluginObjectInput()
    arg.objectStructName= className
    return arg
    
wbinputs= _wbinputs()


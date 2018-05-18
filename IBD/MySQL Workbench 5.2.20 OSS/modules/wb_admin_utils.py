import os
import weakref
import platform

from grt import modules
from mforms import Utilities, newLabel, newBox, newTextEntry, newTextBox, newButton, Form, newTreeView
import mforms

write_log = False
logfile = "wbadebug.log"
debug_level = os.getenv("DEBUG_ADMIN")
if debug_level is not None:
  debug_level = int(debug_level)
else:
  debug_level = 0

print "Debug level -", debug_level

def dprint(*args):
  if debug_level:
    import traceback
    tb = traceback.extract_stack(None,3)[-2]
    msg = os.path.split(tb[0])[1] + ':' + tb[2] + '():' + str(tb[1]) + " " + " ".join([type(s) is str and s or str(s) for s in args])
    print msg
    if write_log:
      f = open(logfile, "a")
      f.write(msg)
      f.write("\n")
      f.close()

def dprint_ex(level, *args):
  if level <= debug_level:
    import traceback
    tb = traceback.extract_stack(None,3)[-2]
    msg = os.path.split(tb[0])[1] + ':' + tb[2] + '():' + str(tb[1]) + " " + " ".join([type(s) is str and s or str(s) for s in args])
    print msg
    if write_log:
      f = open(logfile, "a")
      f.write(msg)
      f.write("\n")
      f.close()

#-------------------------------------------------------------------------------
def get_db_connection(server_instance_settings):
  if server_instance_settings.connection:
    db_connection = MySQLConnection(server_instance_settings.connection)
    ignore_error = False
    error_location = None
    the_error = None
    try:
      db_connection.connect()
    except MySQLError, exc:
     # errors that probably just mean the server is down can be ignored (ex 2013)
     # errors from incorrect connect parameters should raise an exception
     # ex 1045: bad password
      if exc.code in (1045,):
        raise exc
      elif exc.code in (2013,):
        ignore_error = True
      error_location = exc.location
      the_error = str(exc)

      if not ignore_error:
        if Utilities.show_warning("Could not connect to MySQL Server at %s" % error_location,
                "%s\nYou can continue but some functionality may be unavailable." % the_error,
                "Continue Anyway", "Cancel", "") != mforms.ResultOk:
          raise MySQLError("", 0, "")
    return db_connection
  else:
    Utilities.show_warning("WB Admin", "Server instance has no database connection specified.\nSome functionality will not be available.", "OK", "", "")


  return None




def weakcb(object, cbname):
    """Create a callback that holds a weak reference to the object. When passing a callback
    for mforms, use this to create a ref to it and prevent circular references that are never freed.
    """
    def call(ref, cbname):
        callback = getattr(ref(), cbname, None)
        if callback is None:
            print "Object has no callback %s"%cbname
        else:
            return callback()

    return lambda ref=weakref.ref(object): call(ref, cbname)


not_running_warning_label_text = "There is no connection to the MySQL Server.\nThis functionality requires an established connection to a running MySQL server to work."
def not_running_warning_label():
    warning = newLabel(not_running_warning_label_text)
    warning.set_style(mforms.BigStyle)
    warning.set_text_align(mforms.MiddleCenter)
    warning.show(False)
    return warning

def no_ssh_warning_label(server_instance_settings):
    if server_instance_settings.serverInfo["remoteAdmin"]:
        warning = newLabel("There is no SSH connection to the server.\nTo use this functionality, the server where MySQL is located must have a SSH server running\nand you must provide its login information in the server profile.")
    else:
        warning = newLabel("SSH based Remote Administration is disabled.\nTo use this functionality, the server where MySQL is located must have a SSH server running\nand you must enable remote administration in the server profile, providing login details for it.")
    warning.set_style(mforms.BigStyle)
    warning.set_text_align(mforms.MiddleCenter)
    return warning



class MySQLError(Exception):
    def __init__(self, msg, code, location):
        Exception.__init__(self, msg)
        self.code = code
        self.location = location


def escape_sql_string(s):
    return s.replace("\\", "\\\\").replace("'", "\\'").replace("`", "\\`")

def escape_sql_identifier(s):
    return s.replace("`", "\\`")


class QueryError(Exception):
  not_connected_errors = (2006, 2013, 2026, 2055, 2048)
  def __init__(self, msg, error):
    self.msg = msg
    self.error = error

  def __str__(self):
    return self.msg + ". Error:" + str(self.error)

  def is_connection_error(self):
    code = 0
    try:
      code = int(self.error)
    except ValueError, e:
      pass
    return code in self.not_connected_errors

  def is_error_recoverable(self):
    return self.error != 2006 # Probably add more errors here

class ConnectionTunnel:
    def __init__(self, info):
        self.tunnel = modules.DbMySQLQuery.openTunnel(info)
        if self.tunnel > 0:
            self.port = modules.DbMySQLQuery.getTunnelPort(self.tunnel)
        else:
            self.port = None
    
    def __del__(self):
        if self.tunnel > 0:
            modules.DbMySQLQuery.closeTunnel(self.tunnel)


class MySQLResult:
    def __init__(self, result):
        self.result = result


    def __del__(self):
        if self.result:
            modules.DbMySQLQuery.closeResult(self.result)


    def nextRow(self):
        return modules.DbMySQLQuery.resultNextRow(self.result)

    
    def stringByName(self, name):
        return modules.DbMySQLQuery.resultFieldStringValueByName(self.result, name)


    def intByName(self, name):
        return modules.DbMySQLQuery.resultFieldIntValueByName(self.result, name)



class MySQLConnection:
    def __init__(self, info):
        self.connect_info = info
        self.connection = 0
	self.server_down = 0


    def __del__(self):
        self.disconnect()

    
    def connect(self):
        self.server_down = False
        if not self.connection:
            self.connection = modules.DbMySQLQuery.openConnection(self.connect_info)
            if self.connection < 0:
                self.connection = 0
                code = modules.DbMySQLQuery.lastErrorCode()
                if code in (2003,):
                        self.server_down = True
                raise MySQLError(modules.DbMySQLQuery.lastError(), modules.DbMySQLQuery.lastErrorCode(), "%s@%s" % (self.connect_info.parameterValues["userName"], self.connect_info.parameterValues["hostName"]))

    def ping(self):
        self.executeQuery("SELECT 1")
        return True

    
    def disconnect(self):
        if self.connection:
            modules.DbMySQLQuery.closeConnection(self.connection)
            self.connection = 0

    
    @property
    def is_connected(self):
        return self.connection > 0
    

    def execute(self, query):
      if self.connection:
        dprint(query)
        result = modules.DbMySQLQuery.execute(self.connection, query)
        if result < 0:
          error = modules.DbMySQLQuery.lastErrorCode()
          raise QueryError("Error executing '%s':\n%s" % (query, error), error)

        return result != 0
      else:
        raise QueryError("Connection to MySQL server is currently not established", -1)


    def executeQuery(self, query):
      if self.connection:
        result = modules.DbMySQLQuery.executeQuery(self.connection, query)
        if result < 0:
          error = modules.DbMySQLQuery.lastErrorCode()
          raise QueryError("Error executing '%s':\n%s"%(query, error), error)

        return MySQLResult(result)
      else:
        raise QueryError("Connection to MySQL server is currently not established", -1)



def run_filter_debugger(loginInfo, serverInfo, build_filters, apply_filters):
  form = Form(None, mforms.FormSingleFrame)

  close = newButton()
  close.set_text("Close")
  test = newButton()
  test.set_text("Test")
  clr = newButton()
  clr.set_text("Clear output")
  button_box = newBox(True)
  button_box.set_spacing(8)
  button_box.add(close, False, True)
  button_box.add(clr, False, True)
  
  top_box = newBox(False)
  top_box.set_padding(12)
  top_box.set_spacing(8)

  panel_box = newBox(True)
  
  panel_box.set_spacing(12)
  panel_box.set_padding(8)

  input_area = newTextBox(mforms.BothScrollBars)
  input_box = newBox(False)
  input_box.add(newLabel("Input:"), False, True)
  input_box.add(input_area, True, True)

  output_area = newTextBox(mforms.BothScrollBars)
  output_box = newBox(False)
  output_box.add(newLabel("Output:"), False, True)
  output_box.add(output_area, True, True)

  panel_box.add(input_box, True, True)
  panel_box.add(output_box, True, True)

  filter_box = newBox(True)

  filter_lbl = newLabel("Filter:")
  filters = newTextEntry()

  filter_box.add(filter_lbl, False, True)
  filter_box.add(filters, True, True)
  filter_box.add(test, False, True)
  
  top_box.add(filter_box, False, True)
  top_box.add(panel_box, True, True)
  top_box.add(button_box, False, True)
  
  form.set_content(top_box)
  form.set_size(400, 400)

  def clr_action(output_area):
    output_area.clear()

  def close_action():
    form.close()

  def test_action(filters_entry, input_area, output_area, build_filters, apply_filters):
    (script, filters) = build_filters("dummy_executable | " + filters_entry.get_string_value())

    def add_text(x):
      output_area.append_text(x)

    (filtered_text, filters_code) = apply_filters(input_area.get_string_value(), filters, add_text)

    retcode = 0
    if filters_code is not None:
      if retcode is not None:
        retcode = int(retcode) and filters_code
      else:
        retcode = filters_code

    output_area.append_text("retcode = " + str(retcode) + "\n")

  close.add_clicked_callback(close_action)
  clr.add_clicked_callback(lambda : clr_action(output_area))
  test.add_clicked_callback(lambda : test_action(filters, input_area, output_area, build_filters, apply_filters))

  form.relayout()
  form.center()
  form.run_modal(close, None)

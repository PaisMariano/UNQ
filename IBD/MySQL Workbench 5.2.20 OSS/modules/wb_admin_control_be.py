import platform
import subprocess
import re
import os
import sys
import tempfile
import Queue
from wb_admin_ssh import WbAdminSSH, ConnectionError, ConnectCanceled, SSHDownException
import wb_admin_utils
from wb_admin_utils import dprint, dprint_ex
import threading
from wb_admin_utils import MySQLConnection, MySQLError
from mforms import Utilities

WIN_REG_QUERY_PROGRAMFILES = 'reg query HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion /v "ProgramFilesDir"'
WIN_REG_QUERY_PROGRAMFILES_x86 = 'reg query HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion /v "ProgramFilesDir (x86)"'

WIN_PROGRAM_FILES_VAR = "%ProgramFiles%"
WIN_PROGRAM_FILES_X86_VAR = "%ProgramFiles(x86)%"
WIN_PROGRAM_FILES_X64_VAR = "%ProgramW6432%"
#-------------------------------------------------------------------------------
def check_file_is_in_dir(directory, filename):
  ret = (False, None)
  #list all files in a directory
  dirlist = None
  try:
    dirlist = os.listdir(directory)
    # Check if file is not in the list
    for f in dirlist:
      if f == filename:
        ret = (True, None)
  except OSError, e:
    ret = (False, e.errno)

  return ret

#-------------------------------------------------------------------------------
def can_write_to_dir(directory):
  ret = (False, None)

  try:
    dirlist = os.listdir(directory)
    filename = "wbtestfile"
    cnt = 1
    while True:
      if filename + str(cnt) + ".bak" not in dirlist:
        break
      cnt += 1
    filename = os.path.join(directory, filename + str(cnt) + ".bak")
    fp = open(filename, "w")
    fp.close()
    os.remove(filename)
    ret = (True, None)
  except (IOError, OSError), e:
    ret = (False, e.errno)

  return ret

#-------------------------------------------------------------------------------
def splitpath(path):
  path_tuple = None

  idx = path.rfind('/')
  if idx == -1:
    idx = path.rfind('\\')

  if idx >= 0:
    path_tuple = (path[:idx + 1], path[1 + idx:])
  else:
    path_tuple = ('', path)

  return path_tuple

#-------------------------------------------------------------------------------
def wba_arithm(linenr, line, op, value):
  fv = line
  # We shoould have get two numbers
  try:
    fv = float(line.strip(" \r\t\n,.:"))
    value = float(value)
    if (op == "/"):
      if value != 0:
        fv /= value
    elif (op == "*"):
      fv *= value
    elif (op == "+"):
      fv += value
    elif (op == "-"):
      fv -= value
  except ValueError, e:
    fv = line

  return (str(fv), 0) # text and status. 0 - success

#-------------------------------------------------------------------------------
def wba_token(linenr, line, sep, nrs):
  tokens = filter(lambda s: len(s) > 0, line.split(sep))
  out = ""
  l = len(tokens)
  for nr in nrs:
    if nr < l and nr >= 0:
      out += tokens[nr] + sep
  return (out.strip(sep), 0)

#-------------------------------------------------------------------------------
def wba_filter(linenr, line, pattern):
  if line.find(pattern) >= 0:
    return (line, 0)
  return ("", 1)

#-------------------------------------------------------------------------------
def wba_line(linenr, line, expected_linenr):
  if linenr == expected_linenr:
    return (line, 0)
  return ("", 1)

#-------------------------------------------------------------------------------
def parse_wba_token(text):
  f = None

  p = text[9:].strip(" |\r\n\t()").split(",")
  args = []
  try:
    args = map(lambda x: int(x) ,p[1:])
    f = (wba_token, (p[0].strip(" ").strip("'"), tuple(args)))
  except ValueError, e:
    print "Wrong filter format: ", text, ". Required format is wba_token('pattern_symbol', # of token, optional # of tokens)"
    f = None

  return f

#-------------------------------------------------------------------------------
def parse_wba_filter(text):
  f = None

  if len(text) > 11:
    p = text.strip(" |\r\n\t")[11:][:-1]
    f = (wba_filter, (p,))

  return f

#-------------------------------------------------------------------------------
def parse_wba_line(text):
  f = None

  try:
    if len(text) > 8:
      p = int(text[8:].strip(" |\r\n\t()"))
      f = (wba_line, (p,))
  except ValueError, e:
    print str(e), " in filter line ", script
    f = None

  return f

#-------------------------------------------------------------------------------
def parse_wba_arithm(text):
  f = None

  if len(text) > 10:
    p = text[10:].strip(" |\r\n\t()").split(",")
    f = (wba_arithm, tuple(p))

  return f

#-------------------------------------------------------------------------------
filter_parsers = [("wba_token", parse_wba_token), ("wba_filter", parse_wba_filter), ("wba_line", parse_wba_line), ("wba_arithm", parse_wba_arithm)]

#-------------------------------------------------------------------------------
def build_filters(script):
  filters = []
  text = script
  leave = False

  if text is None:
    return (text, filters)

  while not leave:
    filter_was_parsed = False
    idx = text.rfind('|')
    if idx >= 0:
      raw_filter = text[idx:].strip(" \r\t\n|")
      for (pattern, parser) in filter_parsers:
        if raw_filter.find(pattern) == 0:
          parsed_filter = parser(raw_filter)
          if parsed_filter is not None:
            filters.insert(0, parsed_filter)
            filter_was_parsed = True
            break
          else:
            text = script
            filters = []
            leave = True
            break

      if filter_was_parsed:
        text = text[:idx]
      else:
        leave = True
    else:
      leave = True

  return (text, filters)


#-------------------------------------------------------------------------------
def empty_dbg(x):
  pass

def apply_filters(raw_text, filters, dbg = None):
  if dbg is None:
    dbg = empty_dbg

  if raw_text is None:
    return (None, 1)

  out = ""
  code = None
  lines = raw_text.split("\n")

  for f in filters:
    filter_status_code = 1
    new_lines = []
    dbg(f[0].__name__ + " " + str(f[1:]) + "\n")
    for i,line in enumerate(lines):
      line = line.strip("\r")
      orig_line = line
      (line, cur_code) = f[0](i, line, *f[1])
      dbg("   " + str(i) + " '" + orig_line + "' -> '" + line + "'. cur_code = " + str(cur_code) + "\n")
      if len(line) > 0:
        new_lines.append(line)

      if cur_code == 0:
        filter_status_code = 0

    lines = new_lines

    if code is None:
      code = filter_status_code
    elif code == 0:
      code = filter_status_code
    dbg(f[0].__name__ + " exec code = " + str(code) + "\n-------------\n")

  dbg("Filtered text:\n")
  for line in lines:
    if len(line) > 0:
      out += line + '\n'
      dbg(line + '\n')

  dbg("Filters execution code = " + str(code) + "\n===================\n")
  return (out, code) # return last code from filters

def run_filter_debugger(loginInfo, serverInfo):
  wb_admin_utils.run_filter_debugger(loginInfo, serverInfo, build_filters, apply_filters)

#-------------------------------------------------------------------------------
if platform.system() == 'Windows':
    def run_cmd(script, sudo = 0, password = None):
      import os
      out_str =""
      retcode = 1

      if sudo == 1:
        try:
          from ctypes import c_int, WINFUNCTYPE, windll
          from ctypes.wintypes import HWND, LPCSTR, UINT
          prototype = WINFUNCTYPE(c_int, HWND, LPCSTR, LPCSTR, LPCSTR, LPCSTR, UINT)
          scriptparts = script.partition(" ")
          cmdname = scriptparts[0]
          cmdparams = scriptparts[2]
          paramflags = (1, "hwnd", 0), (1, "operation", "runas"), (1, "file", cmdname), (1, "params", cmdparams), (1, "dir", None), (1, "showcmd", 0)
          SHellExecute = prototype(("ShellExecuteA", windll.shell32), paramflags)
          ret = SHellExecute()
          retcode = 1
          if ret > 32:
            retcode = 0
          return ("", retcode)
        except:
          pass
      else:
        try:
          child = os.popen(script)
          out_str = child.read()
          retcode = child.close()
        except:
          import traceback
          traceback.print_exc()
          retcode = 1
      if retcode != 1:
        retcode = 0
      return (out_str, retcode)
else:
    import pexpect

    def run_cmd(script, sudo = 0, password = None):
        script = script.strip(" ")
        if script is None or len(script) is 0:
            return ('',None)

        temp_file = tempfile.NamedTemporaryFile()

        script = script + " > " + temp_file.name + " 2>&1; echo CMDRESULT$? >> " + temp_file.name

        result = ('', None)
        
        if "'" in script:
          raise Exception("WBA: Internal error, unexpected character in script to be executed")

        if not sudo:
          result = pexpect.run("/bin/bash -c '" + script + "'", withexitstatus=True)
        else:
          child = pexpect.spawn("/bin/bash -c '"+script+"'") # script should already have sudo prefix
          try:
              child.expect('assword', timeout=10)
              if password is not None:
                  child.write(password + '\n')
          except pexpect.TIMEOUT:
              #though we are not able to get the expected output, the password is fed anyway
              if password is not None:
                child.write(password + '\n')
          except pexpect.EOF:
              #Nothing we can do, client is terminatd for some reason, try to read anything available
              dprint_ex(2,"Pipe from sudo is closed.", script)

          text = ""

          if child.isalive():
              should_quit_read_loop = False
              while not should_quit_read_loop and child.isalive():
                  try:
                      current_text = child.read_nonblocking(256, 30)
                      if current_text.find('EnterPasswordHere') >= 0:
                        try:
                          child.close()
                        except:
                          pass
                        temp_file.close()
                        return ("Error! Incorrect password for sudo", 1)
                      else:  
                        text += current_text
                  except pexpect.TIMEOUT:
                      pass
                  except pexpect.EOF:
                      should_quit_read_loop = True
          else:
              #Try to read
              text = child.read()

          child.close();

        text = temp_file.read()
        temp_file.close()

        idx = text.rfind("CMDRESULT")
        if (idx is not -1):
          retcode = int(text[idx+9:].strip(" \r\t\n"))
          result = (text[0:idx], retcode)

        return result



#-------------------------------------------------------------------------------
class SSH:
  ssh = None
  mtx = threading.RLock()

  def __init__(self, settings):
    self.ssh = WbAdminSSH()
    loginInfo = settings.loginInfo
    serverInfo = settings.serverInfo

    try:
      self.ssh.wrapped_connect(settings)
      dprint_ex(1, "SSH: Connecting status - ", self.ssh.is_connected())
    except ConnectCanceled, e:
      self.ssh = None
    except SSHDownException, e:
      self.ssh = None
      Utilities.show_warning('SSH connect failed', '\nCheck if SSH daemon/server is up on the remote side.', "Ok", "", "")

  def __del__(self):
    dprint_ex(2, "Closing SSH connection")
    if self.ssh is not None:
      self.ssh.close()

  def run_cmd(self, cmd, sudo = 0, pwd = None):
    output   = None
    retcode  = None
    if self.ssh is not None:
      self.mtx.acquire()
      try:
        (output, retcode) = self.ssh.exec_cmd(cmd, sudo, pwd)
      finally:
        self.mtx.release()
    
    return (output, retcode)

  def file_exists(self, path):
    ret = None
    if self.ssh is not None:
      ret = self.ssh.file_exists(path)
    return ret

  def get(self, source, dest):
    ret = None
    if self.ssh is not None:
      ret = self.ssh.get(source, dest)
    return ret

  def put(self, local, remote):
    ret = None
    if self.ssh is not None:
      ret = self.ssh.put(local, remote)
    return ret

  def is_connected(self):
    ret = False
    if self.ssh is not None:
      ret = self.ssh.is_connected()
    return ret

#-------------------------------------------------------------------------------
class SQLQueryExecutor:
  dbconn = None
  mtx    = threading.RLock()

  def __init__(self, dbconn):
    dprint_ex(1, "Constructing SQL query runner, dbconn", dbconn)
    self.dbconn = dbconn

  def is_connected(self):
    return self.dbconn is not None and self.dbconn.is_connected

  def close(self):
    if self.is_connected():
      self.dbconn.disconnect()
    self.dbconn = None

  def exec_query(self, query):
    result = None
    self.mtx.acquire()
    try:
      if self.is_connected():
        result = self.dbconn.executeQuery(query)
    finally:
      self.mtx.release()
    return result

  def execute(self, query):
    result = None
    self.mtx.acquire()
    try:
      if self.is_connected():
        result = self.dbconn.execute(query)
    finally:
      self.mtx.release()
    return result


#-------------------------------------------------------------------------------
# Handling object should have corresponding method if the object wants to receive 
# events. For event shutdown method name must be shutdown_event
class EventManager:
  valid_events = ['server_started_event', 'server_stopped_event', 'shutdown_event']

  def __init__(self):
    self.events = {}
    self.defer = False
    self.deferred_events = []

  def add_event_handler(self, event_name, handler):
    event_name += "_event"
    if hasattr(handler, event_name):
      handlers_list = None

      if event_name in self.events:
        handlers_list = self.events[event_name]
      else:
        handlers_list = []
        self.events[event_name] = handlers_list

      handlers_list.append(handler)
      dprint_ex(2, "Added ", handler.__class__, "for event", event_name)
    else:
      print "Error! ", handler.__class__, " does not have method", event_name

  def defer_events(self):
    self.defer = True

  def continue_events(self):
    self.defer = False
    for ev_name in self.deferred_events:
      self.event(ev_name)
    self.deferred_events = []

  def event(self, name):
    if self.defer:
      self.deferred_events.append(name)
      return

    name += "_event"
    if name not in self.valid_events:
      print "EventManager: invalid event", name
    elif name in self.events:
      dprint_ex(3, "Found event", name, "in list")
      for obj in self.events[name]:
        if hasattr(obj, name):
          dprint_ex(3, "Passing event", name, "to", obj.__class__)
          getattr(obj, name)()
    else:
      dprint_ex(3, "Found valid but unrequested event", name, "in list")

#-------------------------------------------------------------------------------
class MyCtrl:
    def __init__(self, server_instance_settings, output_callback = lambda x: sys.stdout.write(x), disable_remote_admin=False, connect_sql=True):
      self.events   = EventManager()
      self.defer_events() # continue events should be called when all listeners are registered, that happens later in the caller code
                          # Until then events are piled in the queue
      self.is_local = None
      self.ssh      = None
      self.sql      = None
      self.temp_file = None
      self.running = True
      self.lck = threading.RLock()
      self.task_queue = Queue.Queue(512) # Queue which serialise UI calls from threads
      self.version = "Unknown"
      self.settings = server_instance_settings
      self.remote_admin_enabled = int(self.settings.serverInfo["remoteAdmin"]) != 0 and not disable_remote_admin
      self.cmd_output_encoding = ""
      self.last_running_check = None
      self.target_shell_variables = {}
      self.usesudo = self.settings.serverInfo['sys.usesudo']
      self.usesudostatus = self.settings.serverInfo['sys.usesudostatus']
      self.sudo_prefix = self.settings.serverInfo['sys.sudo']

      self.output = output_callback
      if not self.is_local_server():
        if self.remote_admin_enabled:
          import socket
          import paramiko
          self.ssh = SSH(self.settings)

      if self.is_windows():
        result, code = self.exec_cmd("chcp", False)
        if code == 0:
            result = result.strip(" .").split()
            if len(result) > 0:
              self.cmd_output_encoding = "cp" + result[-1]
        else:
            self.output("Unable to determine codepage from local shell: %s"%result)

        result, code = self.exec_cmd("echo %PROCESSOR_ARCHITECTURE%", False)
        ProgramFilesVar = None
        x86var = None
        if result != "x86\n":#we are on x64 win in x64 mode
            self.output("x64 on x64")
            x86var = WIN_PROGRAM_FILES_X86_VAR
            ProgramFilesVar = WIN_PROGRAM_FILES_VAR
        else:
            result, code = self.exec_cmd("echo %PROCESSOR_ARCHITEW6432%", False)
            if result == "%PROCESSOR_ARCHITEW6432%\n":#we are on win 32
                self.output("x32 on x32")
                x86var = WIN_PROGRAM_FILES_VAR
                ProgramFilesVar = WIN_PROGRAM_FILES_VAR
            else:#32bit app on x64 win
                self.output("x32 on x64")
                x86var = WIN_PROGRAM_FILES_VAR
                ProgramFilesVar = WIN_PROGRAM_FILES_X64_VAR

        result, code = self.exec_cmd("echo "+ ProgramFilesVar, False)
        if code == 0:
            self.target_shell_variables["%ProgramFiles%"] = result.strip("\n")
        else:
            self.output("Unable to fetch ProgramFiles value in local Windows machine: %s"%result)

        # this one only exists in 64bit windows
        result, code = self.exec_cmd("echo "+ x86var, False)
        if code == 0:
            self.target_shell_variables["%ProgramFiles(x86)%"] = result.strip("\n")
        else:
            self.output("Unable to fetch ProgramFiles(x86) value in local Windows machine: %s"%result)

      if connect_sql and self.server_is_stopped_for_sure():
          self.connect_sql()


    #---------------------------------------------------------------------------
    def __del__(self):
      if self.temp_file is not None:
        try:
          os.remove(self.temp_file)
        except:
          pass
        self.temp_file = None

      if self.sql:
        self.sql.close()
        self.sql = None

    #---------------------------------------------------------------------------
    def add_me_for_event(self, event, obj):
      self.events.add_event_handler(event, obj)

    #---------------------------------------------------------------------------
    def event(self, name):
      self.events.event(name)

    #---------------------------------------------------------------------------
    def defer_events(self):
      self.events.defer_events()

    #---------------------------------------------------------------------------
    def continue_events(self):
      self.events.continue_events()

    #---------------------------------------------------------------------------
    def get_server_version(self):
      if type(self.version) is str:
        self.version = self.version.lower()

      if self.version is not None and type(self.version) is not tuple and self.version != "unknown":
        version = ""
        res = re.search('(\d+\.\d+\.*\d*)*', self.version)
        if len(res.groups()) > 0:
          match = res.groups()[0]
          if res is not None and match is not None:
            version = match.strip(' ')

        converted = True
        try:
          v = tuple([int(x) for x in version.split('.')])
        except ValueError:
          converted = False
        if converted:
          self.version = v
          print "get_server_version: parsed", self.version
      else:
        self.version = (5,1)

      return self.version

    #---------------------------------------------------------------------------
    def get_config_file_path(self):
      path = self.settings.serverInfo['sys.config.path'] or ""
      return self.expand_path_variables(path.strip(" \r\t\n\b"))

    #---------------------------------------------------------------------------
    def connect_sql(self):
      if self.sql is None or not self.sql.is_connected():
        self.sql = SQLQueryExecutor(wb_admin_utils.get_db_connection(self.settings))
        if self.sql.is_connected():
          result = self.exec_query("select version() as version")
          if result and result.nextRow():
            self.version= result.stringByName("version")
            dprint_ex(1, "Got MySQL version -", self.version)
          dprint("Created SQL connection to MySQL server. Server version is", self.version, ", conn status = ", self.is_sql_connected())
        else:
          print "Failed to connect to MySQL server"

    #---------------------------------------------------------------------------
    def disconnect_sql(self):
      dprint_ex(3, "Enter")
      if self.sql:
        self.sql.close()
      self.sql = None
      self.version = "unknown"
      dprint_ex(3, "Leave")

    #---------------------------------------------------------------------------
    def is_sql_connected(self):
      ret = False
      if self.sql:
        ret = self.sql.is_connected()
      dprint_ex(2, "ret = ", ret)
      return ret

    #---------------------------------------------------------------------------
    def stop(self):
      self.events.event('shutdown')
      self.running = False
      self.disconnect_sql()
      dprint_ex(1, "Handled shutdown event")

    def set_output(self, cb):
      self.output = cb

    #---------------------------------------------------------------------------
    def start_server(self, usesudo, password):
      dprint_ex(2, "Enter")
      serverInfo = self.settings.serverInfo
      script = serverInfo["sys.mysqld.start"]
      self.output("Trying to start server...")
      result = self.exec_cmd(script, usesudo, password)
      self.output(result[0])
      dprint_ex(2, "Leave")
      return result

    #---------------------------------------------------------------------------
    def stop_server(self, usesudo, password):
      dprint_ex(2, "Enter")
      serverInfo = self.settings.serverInfo
      script = serverInfo["sys.mysqld.stop"]
      self.output("Trying to stop server...")
      result = self.exec_cmd(script, usesudo, password)
      self.output(result[0])
      #self.output("Server stop" + "ped" if result[1] == 0 else " failed")
      dprint_ex(2, "Leave")
      return result

    #---------------------------------------------------------------------------
    def fetch_file(self, fname):
      # Despite name this method returns file name. In case of local file, it simply returns fname
      # In case of remote file, the remote file is fetched ro local box and name of local file is returned
      # As a local file we have a temp file
      fname = self.expand_path_variables(fname) # expand stuff like %ProgramFiles% in windows

      name = fname
      if not self.is_local_server():
        dprint("Checking temp file ", self.temp_file)
        # clean up if file exists from previous fetch
        if self.temp_file is None:
          temp_file = tempfile.mkstemp()
          os.close(temp_file[0])
          self.temp_file = temp_file[1]
          name = self.temp_file
          dprint("Creating local temp file '", name, "' for remote file ", fname)
        else:
          dprint("Truncating local temp file '", name, "' for remote file ", fname)
          f = open(self.temp_file, "w")
          f.close()
        name = self.temp_file

      if self.ssh is not None:
        dprint_ex(1, "Fetching from remote '" + fname + "' to local file " + name)
        self.ssh.get("'" + fname + "'", name)

      return name

    #---------------------------------------------------------------------------
    def upload_file(self, temp_file_name):
      temp_file = open(temp_file_name)
      # Check if dir, where config file will be stored is writable
      dest_file = self.get_config_file_path()
      (dirname, filename) = splitpath(dest_file)
      dprint("Check if dir, " + dirname  + ", where config file will be stored is writable")
      if self.is_windows():
        temp_file.seek(0)
        cmd = "cmd /C copy \"" + dest_file + "\" \"" + dest_file + ".bak\""
        # We can skip wrapping of command here as windows ssh service has elevated privileges
        self.ssh.run_cmd(cmd, 0, None)
        result = self.ssh.run_cmd("cmd /C echo %temp%", 0, None)
        if result[1] == 0:
          temp_path = result[0].strip(" \r\t\n")
          if temp_path[1] == ":":
            temp_path = temp_path[2:].replace("\\", "/")
            temp_path += "/workbench-temp-file.ini"
            dprint("Uploading file " + temp_file.name + " to " + temp_path)
            if self.ssh.put(temp_file.name, temp_path):
              temp_path = "\"" + result[0].strip(" \r\t\n") + "\\workbench-temp-file.ini\""
              self.ssh.run_cmd("cmd /C copy " + temp_path + " \"" + dest_file + "\"", 0, None)
          else:
            dprint("Temp directory path '" + temp_path + " is not in expected form. The expected for is something like 'C:\Windows\Temp'")
        else:
          dprint("Failed to obtain temp directory path from remote windows box. " + result[0])
      else:
        result = self.exec_cmd("touch " + dirname.strip(" \r\t\n") + "/workbench-temp-file", False)
        def upload_file_action(self, sudo = 0, pwd = None):
          if self.ssh is not None:
            temp_file.seek(0)
            # Get home dir
            (homedir, status) = self.ssh.run_cmd("echo ~")
            if type(homedir) is str or type(homedir) is unicode:
              homedir = homedir.strip(" \r\t\n")
              dprint_ex(2, "Got home dir", homedir)
              if homedir == "":
                homedir = "~"
            else:
              homedir = "~"

            out = "/bin/cat > " + homedir + "/.wba.temp <<WBAHereDoc\n"

            for line in temp_file:
              out += line

            out += "\nWBAHereDoc\n"

            cmd = "/bin/cp " + dest_file + " " + dest_file + ".bak"
            cmd2 = "/bin/cp " + homedir + "/.wba.temp " + dest_file
            cmd3 = "/bin/rm " + homedir + "/.wba.temp"

            cmd = self.wrap_command(cmd)
            cmd2 = self.wrap_command(cmd2)

            self.ssh.run_cmd(cmd, sudo, pwd)
            self.ssh.run_cmd(out, 0, None)
            self.ssh.run_cmd(cmd2, sudo, pwd)
            self.ssh.run_cmd(cmd3, 0, None)

        if not result[1] == 0:
          system = self.settings.serverInfo['sys.system']
          accepted, password = Utilities.find_or_ask_for_password("Administrator/sudo Passsword Required",
                                                        "sudo@%s" % self.settings.loginInfo['ssh.hostName'], "root",
                                                        False)
          if accepted:
              upload_file_action(self, 1, password)
        else:
          upload_file_action(self, 0, None)
          self.exec_cmd("/bin/rm " + dirname.strip(" \r\t\n") + "/workbench-temp-file")
          pass
      temp_file.close()

    #---------------------------------------------------------------------------
    def wrap_command(self, cmd, sudo = None):
      wcmd = cmd

      if not self.is_windows():
        if sudo is None: # If sudo is None, then use values from settings
          sudo = self.usesudo

        if sudo == 1 and self.sudo_prefix != "":
          wcmd = self.sudo_prefix + " \"" + wcmd + "\""
      else:
        wcmd = "cmd.exe /C \"" + cmd + "\""

      return wcmd

    #---------------------------------------------------------------------------
    def server_is_stopped_for_sure(self):
        # return True if the server is stopped. If there is no access to server, it returns False
        if self.is_local_server() or (self.ssh and self.ssh.is_connected()):
            return self.is_running()
        return False

    #---------------------------------------------------------------------------
    def is_running(self, silent = False):
        ret = False
        serverInfo = self.settings.serverInfo
        script = serverInfo["sys.mysqld.status"]
        usesudo = self.usesudostatus
        password = None

        if usesudo == 1:
          if not self.is_windows():
            accepted, password = Utilities.find_or_ask_for_password("Administrator/sudo Password Required",
                                "localhost", "root", False)
          else:
            usesudo = 0

        result = self.exec_cmd(script, usesudo, password)

        if result[0] is None and self.is_local_server() == False and self.ssh.is_connected() == False:
          # Handle special case when ssh is down, but sql connection is up and running
          if self.is_sql_connected():
            result = ("", 0) # Simulate success if sql is up

        control_event = None
        if result[1] == 0:
          if not silent:
            self.output("Checked server status: Server is running.")

          if self.last_running_check is None:
            control_event = 'server_started'
          elif self.last_running_check == False:
            control_event = 'server_started'

          self.last_running_check = True
        else:
          if not silent:
            self.output("Checked server status: Server is stopped.")

          if self.last_running_check is None:
            control_event = 'server_stopped'
          elif self.last_running_check == True:
            control_event = 'server_stopped'

          self.last_running_check = False

        if control_event is not None:
          self.uitask(self.event, control_event)

        return result[1] == 0

    #---------------------------------------------------------------------------
    def is_admin_available(self):
        return self.is_local_server() or self.is_ssh_connected()

    #---------------------------------------------------------------------------
    def is_local_server(self):
        if self.is_local is None:
          host = self.settings.loginInfo['ssh.hostName'].strip(" \n\r\t")
          self.is_local = host == "localhost" or host == "" or host == "127.0.0.1" or host == "0"

        return self.is_local

    #---------------------------------------------------------------------------
    def is_ssh_connected(self):
      ret = False
      if self.ssh is not None:
        ret = self.ssh.is_connected()
        dprint_ex(2, "ssh is connected ? =", ret)
      else:
        dprint_ex(2, "SSH is None")
      return ret

    #---------------------------------------------------------------------------
    def is_windows(self):
        system = self.settings.serverInfo['sys.system']
        return system.strip(" \r\t\n").lower() == "windows"

    #---------------------------------------------------------------------------
    def expand_path_variables(self, path):
      """
      Expand some special variables in the path, such as %ProgramFiles% and %ProgramFiles(x86)% in 
      Windows. Uses self.target_shell_variables for the substitutions, which should have been
      filled when the ssh connection to the remote host was made.
      """
      if self.is_windows():
        for k, v in self.target_shell_variables.iteritems():
          path = path.replace(k, v)
      return path

    #---------------------------------------------------------------------------
    def exec_cmd(self, script, sudo, password = None):
      (script, filters) = build_filters(script)

      if self.is_local_server():
        result = run_cmd(self.wrap_command(script, sudo), sudo, password)
      else:
        result = ("Check SSH connection.", 1)
        if self.ssh is not None:
          result = self.ssh.run_cmd(self.wrap_command(script, sudo), sudo, password)

      (filtered_text, filters_code) = apply_filters(result[0], filters)

      dprint_ex(3, "execute: ", script, " = ", filtered_text)

      retcode = result[1]
      if filters_code is not None:
        if retcode is not None:
          retcode = int(retcode) or filters_code
        else:
          retcode = filters_code

      dprint_ex(3, "Execute:", script, ", retcode =", retcode, ", result[1] =", result[1], " filters_code =", filters_code)
      return (filtered_text, retcode)

    #---------------------------------------------------------------------------
    def exec_query(self, q):
      ret = None
      if self.sql is not None:
        try:
          ret = self.sql.exec_query(q)
        except wb_admin_utils.QueryError, e:
          print "ctrl_be: Query Error", e
          if e.is_connection_error():
            dprint_ex(1, "Loss of connection to mysql server was detected.")
            self.disconnect_sql()
            if e.is_error_recoverable():
              dprint_ex(1, "Error is recoverable. Reconnecting to MySQL server.")
              self.connect_sql()
      else:
        dprint("sql connection is down")

      return ret

    #---------------------------------------------------------------------------
    def exec_sql(self, q):
      ret = None
      if self.sql is not None:
        try:
          ret = self.sql.execute(q)
        except wb_admin_utils.QueryError, e:
          print "ctrl_be: Query Error", e
          if e.is_connection_error():
            dprint_ex(1, "Loss of connection to mysql server was detected.")
            self.disconnect_sql()
            if e.is_error_recoverable():
              dprint_ex(1, "Error is recoverable. Reconnecting to MySQL server.")
              self.connect_sql()
      else:
        dprint("sql connection is down")

      return ret

    #---------------------------------------------------------------------------
    def uitask(self, task, *args):
      self.task_queue.put((task, args))

    #---------------------------------------------------------------------------
    def process_ui_task_queue(self):
      while not self.task_queue.empty():
        task = self.task_queue.get()
        task[0](*task[1])
        self.task_queue.task_done()

    #---------------------------------------------------------------------------
    def get_server_variable(self, var_name):
      result = self.exec_query("show variables like '%s%%'" % var_name)
      if result is not None:
        if result.nextRow():
          return result.stringByName("Value")
      return ""

    #---------------------------------------------------------------------------
    def copy_file(self, source, dest, sudo, password = None):
        if self.is_windows():
          cmd = "cmd /C copy /Y \"" + source + "\" \"" + dest + "\""
          return run_cmd(cmd, sudo, password)
        else:
          cp = self.wrap_command("cp " + source + " " + dest, sudo)
          return run_cmd(cp, sudo, password)


# === Unit tests ===
if __name__ == "__main__":
    test_nr = 0

    #-------------    
    if run_cmd("echo 'Test'", 0, "")[1] is not None:
        print "Test", test_nr, " - Ok"
    else:
        print "Test", test_nr, " - Fail"
    test_nr += 1
    
    #-------------    
    if run_cmd("", 1, "")[1] is None:
        print "Test", test_nr, " - Ok"
    else:
        print "Test", test_nr, " - Fail"
    test_nr += 1

    #-------------    
    import getpass
    password = getpass.getpass("Enter password: ")

    if run_cmd("", 1, password)[1] is None:
        print "Test", test_nr, " - Ok"
    else:
        print "Test", test_nr, " - Fail"
    test_nr += 1

    #-------------    
    if run_cmd("echo Test", 1, password)[1] == 0:
        print "Test", test_nr, " - Ok"
    else:
        print "Test", test_nr, " - Fail"
    test_nr += 1

    #-------------    
    if run_cmd("/bin/false", 1, password)[1] == 1:
        print "Test", test_nr, " - Ok"
    else:
        print "Test", test_nr, " - Fail"
    test_nr += 1

    #-------------    
    result = run_cmd("echo 'Test\ message'", 0, None)
    if result[1] == 0 and result[0].strip("\r\n ") == "Test message":
        print "Test", test_nr, " - Ok"
    else:
        print "Test", test_nr, " - Fail"
    test_nr += 1


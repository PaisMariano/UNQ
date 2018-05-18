if __name__ != "__main__":
  import wb_admin_utils
  from wb_admin_utils import dprint, dprint_ex

import os
import errno
import stat
import mforms
import time
import traceback

try:
    import paramiko
    import socket
except:
    import traceback
    traceback.print_exc()
    # temporary workaround
    paramiko = None
    socket = None


#===============================================================================
class ConnectionError(Exception):
  pass
  

#===============================================================================
class ConnectCanceled(Exception):
  pass

#===============================================================================
class SSHDownException(Exception):
  pass

#===============================================================================
#
#===============================================================================
class WbAdminSFTP:
  def __init__(self, sftp):
    self.sftp = sftp

  #-----------------------------------------------------------------------------
  def pwd(self):
    ret = None
    if self.sftp:
      try:
        ret = self.sftp.getcwd()

        if ret is None:
          ret = '/'
      except IOError, e:
        print e


    return ret

  #-----------------------------------------------------------------------------
  def ls(self, path):
    ret = ((),())
    if self.sftp:
      fnames = ()
      fattrs = ()
      try:
        fnames = self.sftp.listdir(path)
        fattrs = self.sftp.listdir_attr(path)
      except IOError, e:
        print e
        ret = (('Failed to read directory content',),())

      if len(fnames) > 0 and len(fnames) == len(fattrs):
        dirs = []
        rest = []
        for i in range(0, len(fnames)):
          attr = fattrs[i]
          if stat.S_ISDIR(attr.st_mode):
            dirs.append((attr.filename))
          elif stat.S_ISREG(attr.st_mode):
            rest.append((attr.filename))
          else:
            rest.append((attr.filename))

        dirs.sort()
        rest.sort()
        ret = (tuple(dirs), tuple(rest))
    return ret

  #-----------------------------------------------------------------------------
  def cd(self, path):
    ret = False
    if self.sftp:
      try:
        self.sftp.chdir(path)
        ret = True
      except IOError, e:
        ret = False

    return ret

  #-----------------------------------------------------------------------------
  def close(self):
    if self.sftp:
      self.sftp.close()

#===============================================================================
#
#===============================================================================
class WbAdminSSH:
  def wrapped_connect(self, settings):
    dprint_ex(2, "Enter")
    self.client = None

    loginInfo = settings.loginInfo
    serverInfo = settings.serverInfo

    host = loginInfo['ssh.hostName']
    usekey = int(loginInfo['ssh.useKey'])
    pwd = None # It is ok to keep pwd set to None even if we have it in server settings
               # it will be retrived later
    port = loginInfo['ssh.port']

    if port is not None and port.strip(" \t") == "":
      port = None

    if usekey == 1:
      # We need to check if keyfile needs password. For some reason paramiko does not always
      # throw exception to request password
      key_filename = loginInfo['ssh.key']
      f = None
      try:
        f = open(key_filename, 'r')
      except IOError, e:
        f = None # set file handle to None indicating that open failed

      keycont = None # Will hold contents of the keyfile
      if f is not None:
        keycont = f.read()
        f.close()
      else:
        usekey = 0 # Reset usekey to 0 so paramiko will not use non-existent key file
        key_filename = None

      accepted = None

      if usekey == 0:
        # We need password for password ssh auth as keyfile is missing. Retrieve password or ask for it
        accepted, pwd = mforms.Utilities.find_or_ask_for_password("Specified SSH key file is missing. Remote SSH Login (%s)" % serverInfo['sys.system'], "ssh@%s:%s" % (host,port or 22), loginInfo['ssh.userName'], False)
      elif keycont is not None:
        if 'ENCRYPTED' in keycont:
          # Retrieve password or ask for it
          accepted, pwd = mforms.Utilities.find_or_ask_for_password("Unlock SSH Private Key", "ssh_keyfile@%s"%key_filename, loginInfo['ssh.userName'], False)
        else:
          accepted = True

      if not accepted:
        raise ConnectCanceled()

      self.connect(host, port, loginInfo['ssh.userName'], pwd, usekey, key_filename)
    else:
      if pwd is None:
        accepted, pwd = mforms.Utilities.find_or_ask_for_password("Remote SSH Login (%s)" % serverInfo['sys.system'], "ssh@%s:%s" % (host,port or 22), loginInfo['ssh.userName'], False)

      if accepted:
        self.connect(host, port, loginInfo['ssh.userName'], pwd, None, None)
      else:
        raise ConnectCanceled()
    dprint_ex(2, "Leave")

  def connect(self, host, port, user, pwd, usekey = 0, key = None):
    if port == None or port == 0:
      port = 22

    if not paramiko:
        raise Exception("Non-local administration not available at this moment") 

    if key and key.startswith("~"):
      key = os.path.expanduser(key)

    self.client = paramiko.SSHClient()
    self.client.load_system_host_keys()

    # TODO: Check if file with 
    self.client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    try:
      if 'timeout' in paramiko.SSHClient.connect.func_code.co_varnames:
        self.client.connect(hostname = host, port = int(port), username = user, password = pwd, pkey = None, key_filename = key, timeout = 10)
      else:
        self.client.connect(hostname = host, port = int(port), username = user, password = pwd, pkey = None, key_filename = key)
      dprint_ex(1, "Connected via ssh to ", host, " client = ", self.client)
    except socket.error, exc:
      self.client = None
      raise SSHDownException()
      #if exc.args[0] == 61: # connection refused
      #  raise ConnectionError("Could not establish SSH connection: %r.\nMake sure the SSH daemon is running and is accessible." % exc)
      #else:
      #  raise ConnectionError("Could not establish SSH connection: %r.\nMake sure the SSH daemon is running and is accessible." % exc)
    except paramiko.PasswordRequiredException, exc:
      if pwd is not None:
        raise ConnectionError("Could not unlock private keys. %s" % exc)
      else:
        raise exc
    except paramiko.SSHException, exc:
      raise ConnectionError("Could not establish SSH connection: %s." % exc)
    except Exception, exc:
      raise ConnectionError("Could not establish SSH connection. %s." % exc)

  def is_connected(self):
    return self.client is not None

  def file_exists(self, path):
    ret = False
    if self.client is None:
      raise Exception("wb_admin_ssh: SSH client not connected. file_exists failed")

    sftp = self.client.open_sftp()
    try:
      sftp.stat(path)
      ret = True
      sftp.close()
    except IOError, e:
      sftp.close()
      ret = False
    except:
      sftp.close()
      raise

    return ret

  def stat(self, path):
    ret = None
    sftp = self.client.open_sftp()
    try:
      ret = sftp.stat(path)
      sftp.close()
    except IOError, e:
      ret = None
      sftp.close()
    except:
      ret = None
      sftp.close()
      
    return ret

  def get(self, source, dest):
    if source is not None:
      source = source.strip("'\"")

    ret = False
    try:
      sftp = self.client.open_sftp()
      sftp.get(source, dest)
      ret = True
      sftp.close()
    except IOError, e:
      print "WbAdminSSH.get of file '" + source + "' failed: " + str(e)

    return ret

  def put(self, source, dest):
    ret = False
    try:
      sftp = self.client.open_sftp()
      sftp.put(source, dest)
      ret = True
      sftp.close()
    except:
      print "WbAdminSSH.put failed"

    return ret

  def exec_cmd(self, cmd, cmd_has_sudo = 0, pwd = None, output_handler = None, read_size = 128, get_channel_cb = None):
    out = ""
    ret = None
    # For some reason we have bool in pwd
    if type(pwd) is unicode:
      pwd = str(pwd)

    if type(pwd) is not str:
      pwd = None

    if self.client is not None:
      bufsize = -1
      transport = self.client.get_transport()
      chan = None
      try:
        chan = transport.open_session() # There should be timeout someday. The patch was sent.
        chan.setblocking(True)
        chan.settimeout(10)
        if (cmd_has_sudo):
          chan.get_pty()

        chan.exec_command(cmd)

        stdin = chan.makefile('wb', bufsize)
        stdout = chan.makefile('rb', bufsize)
        stderr = chan.makefile_stderr('rb', bufsize)

        if get_channel_cb is not None:
          dprint_ex(3, "Getting channel via passed cb", get_channel_cb)
          get_channel_cb(chan)

        if (cmd_has_sudo > 0):
          time.sleep(1)
          dprint_ex(3, "Sending password")
          stdin.write(pwd)
          stdin.write("\n")
          stdin.flush()

        def reader(self, ssh_session):
          out = ""
          loop = True
          while loop:
            try:
              chunk = ssh_session.recv(read_size)
              if chunk is not None and chunk != "":
                out += chunk
              else:
                loop = False
            except socket.timeout:
              loop = False

          return out

        out = ""

        if output_handler is None:
          out = reader(self, chan)
        else:
          output_handler(chan)

        if chan.exit_status_ready():
          ret = chan.recv_exit_status()
        else:
          dprint_ex(4, "Read from the peer is done, but status code is not available")

      except paramiko.SSHException, e:
        print str(e)
        traceback.print_exc()
      except Exception, e:
        print "Exception in SSH", str(e)
        traceback.print_exc()
      except:
        print "Unknown exception in ssh"

      if chan is not None:
        chan.close()

    if out is not None and pwd is not None:
      out = out.replace(pwd, "")
    dprint_ex(4, "SSH.exec_cmd(cmd =", cmd, ", output =", out, ". Retcode =", ret, ")")
    return (out, ret)

  def getftp(self):
    self.sftp = WbAdminSFTP(self.client.open_sftp())
    return self.sftp

  def close(self):
    dprint_ex(2, " ")
    if self.client is not None:
      self.client.close()


# === Unit tests ===
if __name__ == "__main__":
  import threading
  import time

  class Settings:
    def __init__(self):
      self.loginInfo = {}
      self.serverInfo = {}

      self.loginInfo['ssh.hostName'] = ''
      self.loginInfo['ssh.useKey']   = 0
      self.loginInfo['ssh.userName'] = ''
      self.loginInfo['ssh.port'] = ''

  settings = Settings()

  wbassh = WbAdminSSH()
  wbassh.wrapped_connect(settings)
  ftp = wbassh.getftp()

  print ftp.pwd()
  print ftp.ls('.')
  ftp.cd('OpenVPN')
  print ftp.pwd()
  print ftp.ls('.')

  wbassh.close()
  quit()

  class Test:
    def __init__(self):
      self.chan = None
      self.running = [True]

    def save_channel(self, c):
      print "Saving channel", c
      self.chan = c

    def cpu(self, text):
      text = text.strip(" \r\t\n")
      value = None
      try:
        value = int(text)
      except ValueError:
        value = None
      if value is not None:
        print "CPU", value

    def mem(self, text):
      text = text.strip(" \r\t\n")
      value = None
      try:
        value = int(text)
      except ValueError:
        value = None
      if value is not None:
        print "Mem", value

    def reader(self, ssh_session):
      what = ""
      out = ""
      timeouts = 12
      while self.running[0]: # running is passed in list via "refernce"
        try:
          ch = ssh_session.recv(1)
          timeouts = 12
          if ch == "C":
            what = self.cpu
          elif ch == "M":
            what = self.mem
          elif ch == "\r" or ch == "\n":
            if what is not None:
              what(out)
            what = None
            out = ""
            pass
          elif ch in "0123456789. ":
            out += ch
          else:
            what = None
            out = ""
        except socket.timeout:
          timeouts -= 1
          if timeouts <= 0:
            ssh_session.close()
            raise Exception("Can't read from remote Windows script")




  ts = Test()

  t = threading.Thread(target = wbassh.exec_cmd, args=("cmd /C cscript //NoLogo \"C:\Program Files\MySQL\MySQL Server 5.1\mysql_system_status.vbs\" /DoStdIn", None, False, ts.reader, 1, ts.save_channel))
  t.setDaemon(True)
  t.start()

  time.sleep(10)

  t.join()
  wbassh.close()

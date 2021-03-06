#  (c) 2009-2010 Sun Microsystems, Inc.
#
#  This library is free software; you can redistribute it and/or
#  modify it under the terms of the GNU Lesser General Public
#  License as published by the Free Software Foundation; either
#  version 2 of the License, or (at your option) any later version.
#
#  This library is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
#  Lesser General Public License for more details.
#
#  You should have received a copy of the GNU Lesser General Public
#  License along with this library; if not, write to the
#  Free Software Foundation, Inc., 59 Temple Place - Suite 330,
#  Boston, MA 02111-1307, USA.

from wb import DefineModule
import grt
import os
import tempfile
import time

from mforms import Utilities, ResultOk, AppView, newSectionBox, App
import mforms

import wb_admin_monitor
import wb_admin_configuration
import wb_admin_utils
import wba_ssh_ui
import wb_admin_control_be
from wb_admin_utils import MySQLConnection, MySQLError, dprint_ex

# define this Python module as a GRT module
ModuleInfo = DefineModule(name= "WbAdmin", author= "Sun Microsystems Inc.", version="1.0")

class DBError(Exception):
    pass

tab_references = []




##def get_db_connection(server_instance_settings):
#  if server_instance_settings.connection:
#    db_connection = MySQLConnection(server_instance_settings.connection)
#    ignore_error = False
#    error_location = None
#    the_error = None
#    try:
#      db_connection.connect()
#    except MySQLError, exc:
#     # errors that probably just mean the server is down can be ignored (ex 2013)
#     # errors from incorrect connect parameters should raise an exception
#     # ex 1045: bad password
#      if exc.code in (1045,):
#        raise exc
#      elif exc.code in (2013,):
#        ignore_error = True
#      error_location = exc.location
#      the_error = str(exc)
#
#      if not ignore_error:
#        if Utilities.show_warning("Could not Connect to MySQL Server at %s" % error_location,
#                "%s\nYou can continue but some functionality may be unavailable." % the_error,
#                "Continue Anyway", "Cancel", "") != ResultOk:
#          raise MySQLError("")
#    return db_connection
#  else:
#    Utilities.show_warning("WB Admin", "Server Profile has no database connection specified.\nSome functionality will not be available.", "OK", "", "")
#
#
#  return None

#===============================================================================
#
#===============================================================================

class AdministratorTab(AppView):
    #top_box holds all sections
    top_vbox = None
    monitor = None
    configuration = None
    ctrl_be = None
    
    def __init__(self, server_instance_settings):
        AppView.__init__(self, False, "admin", True)

        self.ctrl_be = wb_admin_control_be.MyCtrl(server_instance_settings)

        self.on_close(wb_admin_utils.weakcb(self, "handle_on_close"))

        # Create sections and add them to the admin page.
        self.monitor = wb_admin_monitor.WbAdminMonitor(server_instance_settings, self.ctrl_be)
        section = self.add_section("Server Status", True, True)
        section.set_content(self.monitor)

        self.configuration = wb_admin_configuration.WbAdminConfiguration(server_instance_settings, self.ctrl_be, self.monitor)
        section = self.add_section("Configuration", False, False)
        section.set_content(self.configuration)


    def handle_on_close(self):
        App.get().set_status_text("Closing Administator.")
        self.configuration.shutdown()
        tab_references.remove(self)
        return True


    def wait_server_check(self, timeout):
        # wait for the server status check to be performed until the given timeout
        t = time.time()
        while self.configuration.last_is_running_check is None and time.time() - t < timeout:
            time.sleep(0.5)

    
    def add_section(self, label_text, is_content_expandable, header_mode):
        section = newSectionBox(is_content_expandable, label_text, header_mode)
        section.set_name(label_text)
        self.add(section, not is_content_expandable, True)
        return section



def do_open_administrator(server_instance):
    app = App.get()
    try:
      adminTab = AdministratorTab(server_instance)
    except wb_admin_control_be.ConnectionError, exc:
      Utilities.show_error("Error Connecting to Server (%s@%s)" % (server_instance.loginInfo["ssh.userName"], server_instance.loginInfo["ssh.hostName"]), str(exc), "OK", "", "")
      app.set_status_text("Could not Open WB Admin")
      return None
    except wb_admin_utils.MySQLError, exc:
      if exc.message:
        Utilities.show_error("Error Connecting to MySQL Server (%s)" % exc.location, str(exc), "OK", "", "")
      app.set_status_text("Could not Open WB Admin")
      return None
    
    version = adminTab.ctrl_be.get_server_version()
    if version and version[0] < 5:
      Utilities.show_error("Unsupported Server Version", "The version of the server you're trying to connect to is %i.%i, which is not supported by Workbench."%version[:2],
                          "Close", "", "")
      app.set_status_text("Could not Open WB Admin")
      return None
    
    app.dock_view(adminTab, "maintab")
    app.set_view_title(adminTab, "Admin (%s)" % (server_instance.name))

    tab_references.append(adminTab)

    app.set_status_text("WB Admin Opened")

    return adminTab


#-------------------------------------------------------------------------------
def validate_setting(settings, option, norm_cb, msg):
  if settings.has_key(option):
    if norm_cb is not None:
      norm_cb(settings, option)
  else:
    if msg is not None:
      Utilities.show_warning("WB Administartor", msg, "OK", "", "")
    norm_cb(settings, option)

#-------------------------------------------------------------------------------
def norm_to_switch(settings, option):
  value = 0
  if settings.has_key(option):
    value = settings[option]
    if value > 0:
      value = 1
    else:
      value = 0

  settings[option] = value

#-------------------------------------------------------------------------------
def make_str_existing(settings, option):
  if not settings.has_key(option):
    settings[option] = ""

#-------------------------------------------------------------------------------
@ModuleInfo.plugin("wb.admin.open", type="standalone", caption= "Initialize WB Admin",  pluginMenu= "Administrator")
@ModuleInfo.export(grt.INT, grt.classes.db_mgmt_ServerInstance)
def openAdministrator(server_instance):
    validate_setting(server_instance.serverInfo, "sys.usesudo", norm_to_switch, None)#"Server profile has no indication of sudo usage")
    validate_setting(server_instance.serverInfo, "sys.usesudostatus", norm_to_switch, None)

    if server_instance.serverInfo["sys.system"] != "Windows":
      #validate_setting(server_instance.serverInfo, "sys.sudo", make_str_existing, "Server profile has no privileges elevation command defined")

      #if server_instance.serverInfo.has_key("sys.sudo") and server_instance.serverInfo["sys.sudo"].strip(" \r\t\n") == "":
      #  Utilities.show_warning("WB Administartor", "Server profile has empty privileges elevation command defined. Some functionality maybe unavailable", "OK", "", "")

      # don't break settings that were working perfectly before, assume a valid default
      server_instance.serverInfo["sys.sudo"] = "/usr/bin/sudo -p EnterPasswordHere /bin/bash -c"

    do_open_administrator(server_instance)
    dprint_ex(1, "Completed do_open_administrator")
    return 1


@ModuleInfo.plugin("wb.admin.filterDebugger", type="standalone", caption= "Test filters",  pluginMenu= "Utilities")
@ModuleInfo.export(grt.INT, grt.DICT, grt.DICT)
def openFilterDebugger(loginInfo, serverInfo):
    wb_admin_control_be.run_filter_debugger(loginInfo, serverInfo)
    return 1

@ModuleInfo.plugin("wb.admin.listServices", type="standalone")
@ModuleInfo.export(grt.STRING, grt.DICT)
def openFilterDebugger(server_instance):
    return wb_admin_utils.list_windows_services(server_instance)

@ModuleInfo.plugin("wb.admin.remoteFileSelector", type="standalone")
@ModuleInfo.export(grt.STRING, grt.DICT, grt.DICT)
def openRemoteFileSelector(loginInfo, serverInfo):
    return wba_ssh_ui.remote_file_selector(loginInfo, serverInfo)


def selectServer(title):
    window = mforms.Form(None)
    window.set_title(title)
    box = mforms.newBox(False)
    window.set_content(box)
    
    box.set_padding(12)
    box.set_spacing(12)
    
    label = mforms.newLabel()
    label.set_text("Select Server to Connect to:")
    box.add(label, False, True)
    
    listbox = mforms.newListBox(False)
    box.add(listbox, True, True)

    for inst in grt.root.wb.rdbmsMgmt.storedInstances:
      listbox.add_item(inst.name)
    
    bbox = mforms.newBox(True)
    box.add(bbox, False, True)
    
    bbox.set_spacing(8)
    
    ok = mforms.newButton()
    ok.set_text("OK")
    bbox.add_end(ok, False, True)

    cancel = mforms.newButton()
    cancel.set_text("Cancel")
    bbox.add_end(cancel, False, True)
    
    window.set_size(400, 300)
    window.center()
    
    if window.run_modal(ok, cancel):
      i = listbox.get_selected_index()
      if i >= 0:
          return grt.root.wb.rdbmsMgmt.storedInstances[i]
    return None
        


@ModuleInfo.plugin("wb.admin.dumpManager", type="standalone", caption= "Open Database Export/Import Manager",  pluginMenu= "Administrator")
@ModuleInfo.export(grt.INT)
def openExportImport():
    server = selectServer("Import/Export MySQL Data")
    if server:
        tab = do_open_administrator(server)
        if tab:   
            tab.wait_server_check(4)
            tab.configuration.switch_to(5)
            return 1
    return 0



@ModuleInfo.plugin("wb.admin.securityManager", type="standalone", caption= "Open Security Manager",  pluginMenu= "Administrator")
@ModuleInfo.export(grt.INT)
def openSecurityManager():
    server = selectServer("Security Manager")
    if server:
        tab = do_open_administrator(server)
        if tab:
            tab.wait_server_check(4)
            tab.configuration.switch_to(2)
            return 1
    return 0

@ModuleInfo.plugin("wb.admin.placeholder", type="standalone", caption= "Open Administrator",  pluginMenu= "Administrator")
@ModuleInfo.export(grt.INT)
def tmpAdministratorShortcut():
    server = selectServer("Server Administration")
    if server:
        tab = do_open_administrator(server)
    return 1

def check_if_config_file_has_section(config_file, section):
    for line in config_file:
        if line.strip() == "[%s]"%section:
	    return True
    return False


test_ssh_connection = None
test_ssh_connection_is_windows = None

@ModuleInfo.export(grt.STRING, grt.STRING, grt.classes.db_mgmt_ServerInstance)
def testInstanceSettingByName(what, server_instance):
    global test_ssh_connection
  
    if what == "connect_to_host":
        if test_ssh_connection:
            test_ssh_connection = None

        print "Connecting to %s" % server_instance.loginInfo['ssh.hostName']

        try:
            test_ssh_connection = wb_admin_control_be.MyCtrl(server_instance, connect_sql=False)
            grt.send_info("connected.")
        except Exception, exc:
          import traceback
          traceback.print_exc()
          return "ERROR "+str(exc)
        except:
          print "Unknown error"
          return "ERROR"

        if not test_ssh_connection.is_ssh_connected():
            test_ssh_connection = None
            return "ERROR Error connecting to host"

        result, rc = test_ssh_connection.exec_cmd("uname", False)
        if rc != 0:
            # error calling uname, possibly windows
            result, rc = test_ssh_connection.exec_cmd("ver", False)
            test_ssh_connection_is_windows = True
        else:
            test_ssh_connection_is_windows = False
        print "OK, Operating System is '%s'" % result.strip()
        if not result:
            return "ERROR"

        return "OK"

    elif what == "disconnect":
        if test_ssh_connection:
            test_ssh_connection = None
        return "OK"
    
    elif what == "check_privileges":
        return "ERROR"
    
    elif what in ("find_config_file", "check_config_path", "check_config_section"):
        config_file = server_instance.serverInfo["sys.config.path"]
        print "Check if %s exists in remote host" % config_file
        if not test_ssh_connection.ssh.file_exists(config_file):
          return "ERROR File %s doesn't exist" % config_file
        else:
          print "File was found in expected location"
        
        if what == "check_config_path":
          return "OK"

        section = server_instance.serverInfo["sys.config.section"]
        print "Check if %s section exists in %s" % (section, config_file)
        try:
          local_file = test_ssh_connection.fetch_file(config_file)
          if not local_file:
            return "ERROR could not fetch configuration file"
        except Exception, exc:
          return "ERROR "+str(exc)
        if check_if_config_file_has_section(open(local_file), section):
          os.remove(local_file)
          print "Instance found"
          return "OK"
        os.remove(local_file)
        return "ERROR Couldn't find section %s in the remote config file %s" % (section, config_file)

    elif what in ("find_config_file/local", "check_config_path/local", "check_config_section/local"):
        config_file = server_instance.serverInfo["sys.config.path"]
        config_file = wb_admin_control_be.MyCtrl(server_instance, connect_sql=False).expand_path_variables(config_file)
        print "Check if %s exists locally" % config_file
        if os.path.exists(config_file):
          print "File was found in expected location"
        else:
          return "ERROR File %s doesn't exist" % config_file

        if what == "check_config_path/local":
          return "OK"

        section = server_instance.serverInfo["sys.config.section"]
        print "Check if section for instance %s exists in %s" % (section, config_file)
        if check_if_config_file_has_section(open(config_file, "r"), section):
          print "Instance found"
          return "OK"
        return "ERROR Couldn't find section %s in the config file %s" % (section, config_file)

    elif what == "find_error_files":
        return "ERROR"
      
    elif what == "check_admin_commands":
        path = server_instance.serverInfo["sys.mysqld.start"]
        cmd_start= None
        if path.startswith("/"):
            cmd_start = path.split()[0]
            if not test_ssh_connection.ssh.file_exists(cmd_start):
                return "ERROR %s is invalid" % path

        path = server_instance.serverInfo["sys.mysqld.stop"]
        if path.startswith("/"):
            cmd = path.split()[0]
            if cmd != cmd_start and not test_ssh_connection.ssh.file_exists(cmd):
                return "ERROR %s is invalid" % path

        command = server_instance.serverInfo["sys.mysqld.status"]
        print "Checking command '%s'" % command
        rc = test_ssh_connection.is_running()
        print "Server detected as %s" % (rc and "running" or "stopped"), 

        return "OK"

    elif what == "check_admin_commands/local":
        path = server_instance.serverInfo["sys.mysqld.start"]
        cmd_start= None
        if path.startswith("/"):
            cmd_start = path.split()[0]
            if not os.path.exists(cmd_start):
                return "ERROR %s is invalid" % path

        path = server_instance.serverInfo["sys.mysqld.stop"]
        if path.startswith("/"):
            cmd = path.split()[0]
            if cmd != cmd_start and not os.path.exists(cmd):
                return "ERROR %s is invalid" % path

        command = server_instance.serverInfo["sys.mysqld.status"]
        print "Checking command '%s'" % command
        result, rc = wb_admin_control_be.run_cmd(command, 0, None)
        print "Server detected as %s" % (result and "running" or "stopped")

        return "OK "+(result and "running" or "stopped")

    return "ERROR bad command"


@ModuleInfo.export(grt.DICT, grt.classes.db_mgmt_ServerInstance)
def detectInstanceSettings(server_instance):    
    #form = Form()
    
    #form.run(None, None)
    
    return {}



@ModuleInfo.export(grt.INT, grt.classes.db_mgmt_ServerInstance)
def testInstanceSettings(server_instance):
    
    return 0


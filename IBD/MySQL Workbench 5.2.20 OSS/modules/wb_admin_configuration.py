import threading
import time

from mforms import App, Utilities, newBox, newPanel, newButton, newLabel, newTabView, newTabSwitcher, newTextEntry, newSelector
import mforms

from wb_admin_configuration_startup import WbAdminConfigurationStartup
from wb_admin_config_file_ui import WbAdminConfigFileUI
from wb_admin_connections import WbAdminConnections
from wb_admin_variables import WbAdminVariables
from wb_admin_security import WbAdminSecurity
from wb_admin_logs import WbAdminLogs
from wb_admin_export import WbAdminExport
from wb_admin_utils import MySQLConnection, MySQLError, weakcb, no_ssh_warning_label, dprint, dprint_ex

def add_top_spacer(panel):
    box = newBox(False)
    box.set_back_color("#ffffff")
    spacer = newPanel(mforms.TransparentPanel)
    spacer.set_size(100, 10)
    box.add(spacer, False, True)
    box.add(panel, True, True)
    return box


class WbAdminConfiguration(mforms.Box):
    def __init__(self, server_instance_settings, ctrl_be, monitor):
        self.tabs = None
        self.config_ui = None
        self.closing = False
        self.tabview = None
        self.switcher = None
        self.ctrl_be  = None
        self.old_active_tab = None
        self.last_is_running_check = None
        self.monitor = None

        mforms.Box.__init__(self, False)
        self.set_managed()

        self.tabs = []

        self.ctrl_be = ctrl_be
        self.monitor = monitor;

        # make sure connections are OK
        self.shared_db_connection = MySQLConnection(server_instance_settings.connection)

        self.ctrl_be.add_me_for_event("server_started", self)
        self.ctrl_be.add_me_for_event("server_stopped", self)

        self.tabview = newTabView(True)
        self.switcher = newTabSwitcher()
        self.switcher.attach_to_tabview(self.tabview)
        self.add(self.switcher, False, True)
        self.add(self.tabview, True, True)
        self.refresh_tasks_sleep_time = 2
        
        file_name = newTextEntry()
        sys_config_path = self.ctrl_be.get_config_file_path()
        if sys_config_path is None:
          sys_config_path = ""
        file_name.set_value(sys_config_path)
        file_name.set_size(300, -1)
        section = newSelector()
	section.set_enabled(False)
        section.set_size(150, -1)

        content = None
        panel = None

        if self.ctrl_be.is_admin_available():
          panel = WbAdminConfigurationStartup(server_instance_settings, ctrl_be)
          panel.page_activated()
          panel.set_back_color("#FFFFFF")
          content = panel
          dprint_ex(2, "Added start/stop page")
        else:
          dprint_ex(2, "Failed to add start/stop page.")
          panel = newBox(False)
          panel.set_back_color("#FFFFFF")
          panel.set_padding(10)
          panel.add(no_ssh_warning_label(server_instance_settings), False, True)

        self.add_page(content, panel, "admin_start.png", "admin_start_disabled.png", "Startup", "Start/Stop Server")
        content = None

        panel = newBox(False)
        panel.suspend_layout()

        if self.ctrl_be.is_admin_available():
          spacer = newPanel(mforms.TransparentPanel)
          spacer.set_size(100, 10)
          self.config_ui = WbAdminConfigFileUI(server_instance_settings, file_name, section, ctrl_be)
          panel.add(spacer, False, True)
          panel.add(self.config_ui, True, True)

          bottom_box = newBox(True)
          panel.add(bottom_box, False, False)

          accept_btn = newButton()
          accept_btn.set_text("Apply...")
          #accept_btn.set_size(80, -1)

          discard_btn = newButton()
          discard_btn.set_text("Discard")
          #discard_btn.set_size(80, -1)

          bottom_box.add(newLabel("Configuration File:"), False, True)
          bottom_box.add(file_name, True, True)
          bottom_box.add(section, False, True)

          Utilities.add_end_ok_cancel_buttons(bottom_box, accept_btn, discard_btn)

          bottom_box.set_spacing(8)
          bottom_box.set_padding(12)

          accept_btn.add_clicked_callback(self.config_ui.config_apply_changes_clicked)
          discard_btn.add_clicked_callback(self.config_ui.config_discard_changes_clicked)

          panel.set_back_color("#FFFFFF")
          content = self.config_ui
        else:
          panel = newBox(False)
          panel.set_back_color("#FFFFFF")
          panel.set_padding(10)
          panel.add(no_ssh_warning_label(server_instance_settings), False, True)

        self.add_page(content, panel, "admin_options.png", "admin_options_disabled.png", "Configuration", "Edit Configuration File")
        panel.resume_layout()

        panel = WbAdminSecurity(self.ctrl_be)
        panel.set_back_color("#FFFFFF")
        self.add_page(panel, add_top_spacer(panel), "admin_accounts.png", "admin_accounts_disabled.png", "Accounts", "Manage Users")

        panel = WbAdminConnections(server_instance_settings, self.ctrl_be)
        self.connection_list_panel = panel
        panel.set_back_color("#FFFFFF")
        self.add_page(panel, add_top_spacer(panel), "admin_connections.png", "admin_connections_disabled.png", "Connections", "Edit Connection List")

        panel = WbAdminVariables(self.ctrl_be)
        panel.set_back_color("#FFFFFF")
        self.add_page(panel, add_top_spacer(panel), "admin_variables.png", "admin_variables_disabled.png", "Variables", "Status and Server Vars")

        panel = WbAdminExport(server_instance_settings, self.ctrl_be)
        panel.set_back_color("#FFFFFF")
        self.add_page(panel, add_top_spacer(panel), "admin_dump.png", "admin_dump_disabled.png", "Data Dump", "Export / Import Data")

        panel = WbAdminLogs(server_instance_settings, self.shared_db_connection)
        panel.set_back_color("#FFFFFF")
        self.add_page(panel, add_top_spacer(panel), "admin_logs.png", "admin_logs_disabled.png", "Logs", "Server Log Files")

        Utilities.add_timeout(0.5, weakcb(self, "timeout"))
        self.timeout_thread = threading.Thread(target = self.refresh_tasks)
        self.timeout_thread.setDaemon(True)
        self.timeout_thread.start()
        self.switcher.add_changed_callback(self.tab_changed)

        self.timeout() # will call self.connect_mysql() and check if mysql is running

        # if there's no SSH, try at least to connect to MySQL now, this is handled in start/stop events
        if not self.ctrl_be.is_admin_available():
            self.connect_mysql()

        self.ctrl_be.continue_events() # Process events which are queue during init
        dprint_ex(1, "WBA init complete")


    def connect_mysql(self):
        self.connection_error = None
        try:
            self.shared_db_connection.connect()
            self.connection_error = None
            self.ctrl_be.connect_sql()
            dprint("Created mysql connection")
        except MySQLError, e:
            self.connection_error = str(e)

            # we should not display errors about not being able to connect to MySQL if:
            # 1- error is about not being able to connect (as opposed to bad password or something)
            # 2- we know for sure the connection params are correct
            # Since we can't know 2 for sure, we will just show different msgs for the cases we can know

            # 1045: bad password, 
            if e.code in (1045, ):
              Utilities.show_error("Cannot Connect to MySQL", str(e)+"\nSome functionality will not be available.",
                      "OK", "", "")
            else:
              Utilities.show_error("Cannot Connect to MySQL", str(e)+"\nConnection parameters might be incorrect or the server might be down.\nSome functionality will not be available.",
                      "OK", "", "")

        return self.connection_error


    def switch_to(self, tab_no):
      self.switcher.set_selected(tab_no)
      self.tab_changed()


    def tab_changed(self):
      if self.old_active_tab and hasattr(self.old_active_tab, "page_deactivated"):
        self.old_active_tab.page_deactivated()

      i = self.tabview.get_active_tab()
      panel = self.tabs[i]
      if panel is not None:
        panel.page_activated()
      self.old_active_tab = panel


    def shutdown(self):
        dprint_ex(2, " closing")
        if self.shared_db_connection is not None:
            self.shared_db_connection.disconnect()

        self.ctrl_be.stop()

        self.closing = True
    
    def shutdown_event(self):
        self.shutdown()

    def server_started_event(self):
      dprint("Handling start event")
      if len(self.tabs) > 0 and hasattr(self.tabs[0], 'print_output'):
        self.ctrl_be.uitask(self.tabs[0].print_output, "Server is running")
      if None == self.connect_mysql():
        self.ctrl_be.connect_sql()
      self.refresh_tasks_sleep_time = 2
      dprint("Done handling start event")

    def server_stopped_event(self):
      dprint("Handling stop event")
      if len(self.tabs) > 0 and hasattr(self.tabs[0], "print_output"):
        self.ctrl_be.uitask(self.tabs[0].print_output, "Server is stopped")
      # Note: sql should not be disconnected right here, rather in ctrl_be on QueryError
      #self.ctrl_be.disconnect_sql()
      #if self.shared_db_connection:
      #    self.shared_db_connection.disconnect()
      self.refresh_tasks_sleep_time = 3
      dprint("Done handling stop event")

    def refresh_tasks(self):
      dprint_ex(2, "Enter")
      #status = self.ctrl_be.is_running(True) # True - means supress output
      number_of_wakes_between_refreshes = 3
      cnt = 0

      only_status_check = 0
      while not self.closing:
        status = self.ctrl_be.is_running(True) # True - means supress output

        dprint_ex(3, "server running", status, ", self.closing =", self.closing)
        if 0 == only_status_check:
          dprint_ex(2, "Performing extra actions")
          self.last_is_running_check = status
          self.monitor.refresh_status(status)
          dprint_ex(2, "Done monitor refresh")

          if status:
            self.connection_list_panel.refresh_mt(self.ctrl_be)
            dprint_ex(2, "Done connection list refresh")
          cnt = 0

        time.sleep(self.refresh_tasks_sleep_time)
        cnt += 1
        only_status_check = cnt % number_of_wakes_between_refreshes

      dprint_ex(2, "Leave")

    #---------------------------------------------------------------------------
    def timeout(self):
      if not self.closing:
        self.ctrl_be.process_ui_task_queue()
            
      return not self.closing

    def add_page(self, page_object, panel, icon, alticon, title, subtitle="-"):
        self.tabview.add_page(panel, "")
        self.switcher.add_item(title, subtitle, App.get().get_resource_path(icon), App.get().get_resource_path(alticon))
        self.tabs.append(page_object)


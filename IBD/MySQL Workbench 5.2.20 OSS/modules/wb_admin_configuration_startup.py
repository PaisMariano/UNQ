from mforms import newButton, newPanel, newLabel, newBox, newCheckBox, newTable, newTextBox, newImageBox, Utilities
import mforms

import wb_admin_utils
from wb_admin_utils import dprint_ex
import datetime

class WbAdminConfigurationStartup(mforms.Box):

    long_status_msg = None
    short_status_msg = None
    start_stop_btn = None
    startup_msgs_log = None
    is_server_running_prev_check = None
    settings = None
    copy_to_clipboard_button = None
    clear_messages_button = None
    ui_created = False

    def print_output(self, text):
      ts = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S - ")
      self.startup_msgs_log.append_text_with_encoding(ts + text + "\n", self.ctrl_be.cmd_output_encoding)
    
    def __init__(self, server_instance_settings, ctrl_be):
        mforms.Box.__init__(self, False)
        self.settings = server_instance_settings
        self.ctrl_be = ctrl_be

        
    def create_ui(self):
        self.suspend_layout()
        
        self.set_back_color("#FFFFFF")
        self.set_padding(8)

        # The top container is here just for a nice border.
        top_container = newPanel(mforms.BorderedPanel)
        self.add(top_container, True, True)
                
        # Top layout structure.
        content = newTable()
        content.set_row_count(2)
        content.set_column_count(2)
        content.set_row_spacing(16)
        content.set_column_spacing(32)
        content.set_padding(16)
        top_container.add(content)
        
        # A spacer at the bottom of the page.
        spacer = newBox(True)
        spacer.set_size(-1, 40)
        self.add(spacer, False, True)
        # spacer.show(False) # use this to test how it looks without spacer.

        # Left pane (start/stop).
        heading = newLabel("Database Server Status")
        heading.set_style(mforms.BoldStyle)
        content.add(heading, 0, 1, 0, 1, mforms.HFillFlag | mforms.VFillFlag)

        left_pane = newBox(False)
        left_pane.set_spacing(8)
        
        self.long_status_msg = newLabel("The database server is stopped")
        self.long_status_msg.set_style(mforms.SmallStyle)
        left_pane.add(self.long_status_msg, False, True)
        
        status_message_part = newLabel("The database server instance is ")
        self.short_status_msg = newLabel("stopped")
        self.short_status_msg.set_color("#DD0000")

        self.start_stop_btn = newButton()
        self.start_stop_btn.set_text("Start server")
        self.start_stop_btn.add_clicked_callback(self.start_stop_clicked)

        start_stop_hbox = newBox(True)
        #start_stop_hbox.set_spacing(16)
        start_stop_hbox.add(status_message_part, False, True)
        start_stop_hbox.add(self.short_status_msg, True, True)
        start_stop_hbox.add(self.start_stop_btn, False, False)
        left_pane.add(start_stop_hbox, False, False)

        left_pane.add(self.long_status_msg, False, False)
        left_pane.add(start_stop_hbox, False, False)

        description = newLabel("If you stop the server, you and your applications will not be able to use the Database\nand all current connections will be closed")
        description.set_style(mforms.SmallStyle)
        left_pane.add(description, False, False)
        
        separator = newImageBox()
        separator.set_image("options-horizontal-separator.png")
        left_pane.add(separator, False, True)
        
        auto_start_checkbox = newCheckBox()
        auto_start_checkbox.set_text("Automatically Start Database Server on Startup")
        auto_start_checkbox.set_active(True)
        # not implemented yet
        #left_pane.add(auto_start_checkbox, False, False)

        description = newLabel("You may select to have the Database server start automatically whenever the computer starts up.")
        description.set_style(mforms.SmallStyle)
        description.set_wrap_text(True)
        #left_pane.add(description, False, False)
        
        content.add(left_pane, 0, 1, 1, 2, mforms.HFillFlag | mforms.VFillFlag)

        # Right pane (log).
        heading = newLabel("Startup Message Log")
        heading.set_style(mforms.BoldStyle)
        content.add(heading, 1, 2, 0, 1, mforms.HFillFlag | mforms.VFillFlag)
        
        right_pane = newBox(False)    
        right_pane.set_spacing(8)
        
        self.startup_msgs_log = newTextBox(mforms.BothScrollBars)
        self.startup_msgs_log.set_read_only(True)
        right_pane.add(self.startup_msgs_log, True, True)
        
        button_box = newBox(True)
        self.copy_to_clipboard_button = newButton()
        self.copy_to_clipboard_button.set_size(150, -1)
        self.copy_to_clipboard_button.set_text("Copy to Clipboard")
        self.copy_to_clipboard_button.add_clicked_callback(self.copy_to_clipboard)
        button_box.add_end(self.copy_to_clipboard_button, False, False)

        self.clear_messages_button = newButton()
        self.clear_messages_button.set_size(150, -1)
        self.clear_messages_button.set_text("Clear Messages")
        self.clear_messages_button.add_clicked_callback(self.clear_messages)
        button_box.add_end(self.clear_messages_button, False, False)
        right_pane.add(button_box, False, True)
        
        content.add(right_pane, 1, 2, 1, 2, mforms.HFillFlag | mforms.VFillFlag | mforms.HExpandFlag | mforms.VExpandFlag)

        self.resume_layout()

        self.ctrl_be.add_me_for_event("server_started", self)
        self.ctrl_be.add_me_for_event("server_stopped", self)
        #self.refresh()

    def page_activated(self):
        if not self.ui_created:
            self.create_ui()
            self.ui_created = True
        self.ctrl_be.set_output(self.print_output)
        self.refresh()

    def server_started_event(self):
      dprint_ex(2, "Handling server start event in start/stop page")
      self.ctrl_be.uitask(self.update_ui, True)

    def server_stopped_event(self):
      dprint_ex(2, "Handling server stop event in start/stop page")
      self.ctrl_be.uitask(self.update_ui, False)

    def update_ui(self, server_running):
      dprint_ex(2, "Enter. server_running =", server_running)
      self.is_server_running_prev_check = server_running
      if server_running:
        self.long_status_msg.set_text("The database server is started and ready for client connections. To shut the Server\ndown, use the \"Stop Server\" button")
        self.short_status_msg.set_text("running")
        self.short_status_msg.set_color("#00DD00")
        self.start_stop_btn.set_text("Stop Server")
      else:
        self.long_status_msg.set_text("The database server is stopped. To start the Server, use the \"Start Server\" button")
        self.short_status_msg.set_text("stopped")
        self.short_status_msg.set_color("#DD0000")
        self.start_stop_btn.set_text("Start Server")
      dprint_ex(2, "Leave")

    def start_stop_clicked(self):
        self.start_stop_btn.set_enabled(False)
        status = self.ctrl_be.is_running()
        # Check if server was started/stoped from outside
        if self.is_server_running_prev_check == status:
          # Check if we need sudo and ask for password from user
          usesudo = self.settings.serverInfo["sys.usesudo"]
          if usesudo == 1:
            if self.ctrl_be.is_local_server():
              host = "localhost"
            else:
              host = self.settings.loginInfo["ssh.hostName"]

            if not self.ctrl_be.is_windows():
                accepted, password = Utilities.find_or_ask_for_password("Administrator/sudo Password Required",
                              "sudo@%s" % host, "root", False)
            else:
                accepted = True
                password = None

            if accepted:
              if status:
                self.ctrl_be.stop_server(usesudo, password)
              else:
                self.ctrl_be.start_server(usesudo, password)
              pwd = " ".zfill(128)
              self.refresh()
          else:
            if status:
                self.ctrl_be.stop_server(usesudo, None)
            else:
                self.ctrl_be.start_server(usesudo, None)
            self.refresh()

        self.start_stop_btn.set_enabled(True)

    def refresh(self):
      self.is_server_running_prev_check = self.ctrl_be.is_running()

    def copy_to_clipboard(self):
      Utilities.set_clipboard_text(self.startup_msgs_log.get_string_value())

    def clear_messages(self):
      self.startup_msgs_log.clear()

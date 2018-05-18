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

from mforms import newTreeView, newButton, newBox
import mforms

from wb_admin_utils import not_running_warning_label, weakcb, dprint_ex

class WbAdminConnections(mforms.Box):
    ui_created = False
    def __init__(self, instance_info, ctrl_be):
        mforms.Box.__init__(self, False)
        self.instance_info = instance_info
        self.ctrl_be = ctrl_be
        self.page_active = False

        
    def create_ui(self):
        dprint_ex(3, "Enter")
        self.suspend_layout()
        
        self.warning = not_running_warning_label()
        self.add(self.warning, False, True)
    
        self.connection_list = newTreeView(mforms.TreeShowHeader)
        self.connection_list.add_column(mforms.StringColumnType, "Id", 50, False)
        self.connection_list.add_column(mforms.StringColumnType, "User", 80, False)
        self.connection_list.add_column(mforms.StringColumnType, "Host", 120, False)
        self.connection_list.add_column(mforms.StringColumnType, "DB", 100, False)
        self.connection_list.add_column(mforms.StringColumnType, "Command", 80, False)
        self.connection_list.add_column(mforms.StringColumnType, "Time", 80, False)
        self.connection_list.add_column(mforms.StringColumnType, "State", 80, False)
        self.connection_list.add_column(mforms.StringColumnType, "Info", 300, False)        
        self.connection_list.end_columns()
        
        self.connection_list.add_changed_callback(weakcb(self, "connection_selected"))

        #self.set_padding(8)
        self.add(self.connection_list, True, True)

        self.button_box = box = newBox(True)
        self.add(box, False, True)
        
        box.set_spacing(12)
        box.set_padding(12)
        
        refresh_button = newButton()
        refresh_button.set_text("Refresh")
        box.add_end(refresh_button, False, True)
        refresh_button.add_clicked_callback(weakcb(self, "refresh"))

        self.kill_button = newButton()
        self.kill_button.set_text("Kill Connection")
        box.add_end(self.kill_button, False, True)
        self.kill_button.add_clicked_callback(weakcb(self, "kill_connection"))

        self.add(box, False, True)
        
        self.resume_layout()

        self.connection_selected()
        dprint_ex(3, "Leave")


    def connection_selected(self):
        dprint_ex(3, "Enter")
        if self.connection_list.get_selected() < 0:
            self.kill_button.set_enabled(False)
        else:
            self.kill_button.set_enabled(True)
        dprint_ex(3, "Leave")

    def page_activated(self):
        if not self.ui_created:
          self.create_ui()
          self.ui_created = True

        self.page_active = True
        if self.ctrl_be.is_sql_connected():
          self.warning.show(False)
          self.connection_list.show(True)
          self.button_box.show(True)
        else:
          self.warning.show(True)
          self.connection_list.show(False)
          self.button_box.show(False)

        self.refresh()

    def page_deactivated(self):
      self.page_active = False


    def refresh_mt(self, ctrl_be):
      dprint_ex(2, "Enter")
      if not self.page_active:
        dprint_ex(2, "Leave. Page inactive")
        return
      result = self.ctrl_be.exec_query("SHOW PROCESSLIST")
      if result is not None:
        ctrl_be.uitask(self.refresh, result)
      dprint_ex(2, "Leave")

    def refresh(self, query_result = None):
        if not self.ctrl_be.is_sql_connected():
          dprint_ex(2, "Leave. SQL connection is offline")
          return

        if not self.page_active:
          dprint_ex(2, "Leave. Page is inactive")
          return

        i = self.connection_list.get_selected()
        if i >= 0:
          old_selected = self.connection_list.get_string(i, 0)
        else:
          old_selected = None

        self.connection_list.clear_rows()
        if query_result is None:
          result = self.ctrl_be.exec_query("SHOW PROCESSLIST")
        else:
          result = query_result

        if result is not None:
          while result.nextRow():
            r = self.connection_list.add_row()
            fields = ["Id", "User", "Host", "db", "Command", "Time", "State", "Info"]
            for field in range(len(fields)):
              value = result.stringByName(fields[field])
              self.connection_list.set_string(r, field, value)

              if field == 0 and value == old_selected:
                self.connection_list.set_selected(r)

    def kill_connection(self):
      if not self.ctrl_be.is_sql_connected():
          return

      sel = self.connection_list.get_selected()
      if sel < 0:
        return

      connid = self.connection_list.get_string(sel, 0)

      try:
        self.ctrl_be.exec_sql("KILL CONNECTION %s"%connid)
      except Exception, e:
        raise Exception("Error executing KILL CONNECTION: %s" % e)

      self.refresh()

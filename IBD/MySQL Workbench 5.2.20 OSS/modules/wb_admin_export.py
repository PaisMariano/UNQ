#
#  wb_admin_export.py
#  MySQLWorkbench
#
#
#  Copyright (c) 2009-2010 Oracle and/or its affiliates. All rights reserved. 
#

import os
import sys
import subprocess
import threading
import thread
import time
import grt
import wb_admin_export_options
import tempfile
import platform

from wb_admin_utils import MySQLConnection, MySQLError, ConnectionTunnel, escape_sql_string, escape_sql_identifier, not_running_warning_label
from collections import deque

from mforms import newBox, newButton, newPanel, newTextBox, newRadioButton, newLabel, newTreeView, newProgressBar, newTextEntry, newCheckBox, newScrollPanel, newTabView
from mforms import Utilities, FileChooser
import mforms

def quote_shell_token(s):
    t = '"%s"' % s.replace('\\', '\\\\').replace('"', '\\"').replace('$', '\\$')
    return t

def normalize_filename(s):
    s = s.replace(":", "_").replace("/", "_").replace("\\", "_")
    return s



####################################################################################################

class DumpThread(threading.Thread):


    # description, object_count, pipe_factory, extra_args, objects
    #operations.append((title, len(tables), lambda schema=schema:self.dump_to_file([schema]), params, objects))
    class TaskData():
        def __init__(self,title,table_count,extra_arguments,objec_names,make_pipe = lambda:None):
            self.title = title
            self.table_count = table_count
            self.extra_arguments = extra_arguments
            self.objec_names = objec_names
            self.make_pipe = make_pipe

    def __init__(self, command, operations, pwd, owner):
        self.owner = owner
        self.pwd = pwd
        self.logging_lock = thread.allocate_lock()
        self.log = deque([])
        self.is_import = False
        self.command = command
        self.operations = operations
        self.done = False
        self.progress = 0
        self.status_text = "Starting"
        self.error_count = 0
        self.process_handle = None
        self.abort_requested = False
        threading.Thread.__init__(self)

    def process_db(self, respipe, extra_arguments, object_names):
        pwdfilename = None
        tmpdir = None
        try:
            params = [self.command] + extra_arguments
            for arg in object_names:
                params.append(quote_shell_token(arg))
            
            strcmd = " ".join(params)
            logstr = strcmd.partition("--password=")[0]
    
            if platform.system() == 'Windows':
                pwdfile = tempfile.NamedTemporaryFile(delete=False)
                pwdfilename = pwdfile.name
            else:
                tmpdir = tempfile.mkdtemp()
                pwdfilename = os.path.join(tmpdir, 'extraparams')
                os.mkfifo(pwdfilename)
   
            logstr += "--defaults-extra-file=" + pwdfilename + " "
    
            logstr += strcmd.partition("--password=")[2]
    
            self.print_log_message("Running: " + logstr)
            if platform.system() != 'Windows':
                try:
                    p1 = subprocess.Popen(logstr,stdout=respipe,stdin=subprocess.PIPE, stderr=subprocess.PIPE, shell=True)
                except OSError, exc:
                    self.print_log_message("Error executing task: %s" % str(exc))

                pwdfile = open(pwdfilename, 'w')
            else:
                pwdfile = open(pwdfilename, 'w')
            pwdfile.write('[client]\npassword="')
            pwdfile.write(self.pwd.replace("\\", "\\\\"))
            pwdfile.write('"')
            pwdfile.close()
            if platform.system() == 'Windows':
                try:
                    info = subprocess.STARTUPINFO()
                    info.dwFlags |= subprocess.STARTF_USESHOWWINDOW
                    info.wShowWindow = subprocess.SW_HIDE
                    p1 = subprocess.Popen(logstr,stdout=respipe or subprocess.PIPE,stdin=subprocess.PIPE, stderr=subprocess.PIPE,startupinfo=info,shell=logstr[0] != '"')
                except OSError, exc:
                    self.print_log_message("Error executing task: %s" % str(exc))
#                finally:
#                    pass


            self.process_handle = p1

            while p1.poll() == None and not self.abort_requested:
                err = p1.stderr.read()
                if err != "":
                    self.print_log_message(err)
            result = ""


        except Exception, exc:
            self.print_log_message("Error executing task: %s" % str(exc))
#        finally:
#            pass
        if pwdfilename:
            os.remove(pwdfilename)
        if platform.system() != 'Windows' and tmpdir:
            os.rmdir(tmpdir)

        err = p1.stderr.read()
        if err != "":
            result += err
        if p1.poll() != 0:
            self.print_log_message("Operation failed with exitcode " + str(p1.poll()))
        else:
            self.print_log_message("")

        if result:
            self.print_log_message(result)
        return p1.poll()
      
    def kill(self):
        self.abort_requested = True
        if self.process_handle:
            if platform.system() == 'Windows':
                subprocess.Popen("taskkill /F /T /PID %i" % self.process_handle.pid , shell=True)
            else:
                import signal
                try:
                    os.kill(self.process_handle.pid, signal.SIGTERM)
                except OSError, exc:
                    self.print_log_message("kill task: %s" % str(exc))

    def print_log_message(self,message):
        self.logging_lock.acquire()
        self.log.append(str(message))
        self.logging_lock.release()  

    def run(self):
        try:
            self.progress = 0
            tables_processed = 0.0
            tables_total = 0.0
#            for title, count, make_pipe, args, objs in self.operations:
            for task in self.operations:
                tables_total += task.table_count

#            for title, table_count, make_pipe, arguments, objects in self.operations:
            for task in self.operations:
                self.print_log_message(time.strftime('%X ') + task.title)

                tables_processed += task.table_count
                pipe = task.make_pipe()
                exitcode = self.process_db(pipe, task.extra_arguments, task.objec_names)
                if exitcode == 0:
                    if self.is_import:
                        self.status_text = "%i of %i imported." % (tables_processed, tables_total)
                    else:
                        self.status_text = "%i of %i exported." % (tables_processed, tables_total)
                else:
                    self.owner.fail_callback()
                    self.error_count += 1

                if self.abort_requested:
                    break

                self.progress = float(tables_processed) / tables_total
#                print self.progress
#               Emulate slow dump
#                import time
#                time.sleep(1)
        except Exception, exc:
            self.print_log_message("Error executing task %s" % str(exc) )
#        finally:
        if not self.abort_requested:
            self.progress = 1
        self.done = True


class WbAdminSchemaListTab(mforms.Box):
    savefile_path = None
    savefolder_path = None
    def __init__(self, owner, instance_info, is_importing = False):
        mforms.Box.__init__(self, False)
        
        self.suspend_layout()
        
        self.owner = owner
        self.is_importing = is_importing
        
        self.dump_thread = None
        self.instance_info = instance_info
        self.out_pipe = None
        self.tables_by_schema = {}
        if self.savefolder_path is None:
            self.savefolder_path = self.get_default_dump_folder()
        if self.savefile_path is None:
            self.savefile_path = os.path.join(self.savefolder_path, "export.sql")

        self.schema_list = newTreeView(mforms.TreeShowHeader)
        self.schema_list.add_column(mforms.CheckColumnType, is_importing and "Import" or "Export", 50, True)
        self.schema_list.add_column(mforms.StringColumnType, "Schema", 300, False)

        self.schema_list.set_cell_edited_callback(self.schema_list_edit)
        self.schema_list.end_columns()

        self.table_list = newTreeView(mforms.TreeShowHeader)
        self.table_list.add_column(mforms.CheckColumnType, is_importing and "Import" or "Export", 50, True)
        self.table_list.add_column(mforms.StringColumnType, "Tables in Schema", 300, False)
        self.table_list.end_columns()

        self.table_list.set_cell_edited_callback(self.table_list_edit)
        
        self.schema_list.add_changed_callback(self.schema_selected)

        self.set_padding(8)
        self.set_spacing(10)


        box = newBox(True)
        box.set_spacing(12)
        optionspanel = newPanel(mforms.TitledBoxPanel)
        optionspanel.set_title("Options")
        optionsbox = newBox(False)
        optionsbox.set_padding(8)
        optionsbox.set_spacing(6)

        self.file_btn = newButton()
        self.file_btn.set_text("...")
        self.file_btn.enable_internal_padding(False)
        self.file_btn.set_enabled(False)

        if is_importing:
          self.folderlabel = newLabel("Select the Backup Project Folder to import. You can do a selective restore.")
          self.folderradio = newRadioButton(0)
          self.hintlabel = newLabel("Press [Start Import] to start...")
          self.filelabel = newLabel("Select the SQL/dump file to import. Please note that the whole file will be imported.")
          self.single_transaction_check = None
          self.dump_view_check = None
          self.dump_routines_check = None
        else:
          self.filelabel = newLabel("All selected database objects will be exported into a single, self-contained file.")
          self.folderlabel = newLabel("Each table will be exported into a separate file. This allows a selective restore.")
          self.folderradio = newRadioButton(1)
          self.hintlabel = newLabel("Press [Start Export] to start...")
          self.single_transaction_check = newCheckBox()
          self.dump_view_check = newCheckBox()
          self.dump_routines_check = newCheckBox()

        self.filelabel.set_enabled(False)
        self.filelabel.set_style(mforms.SmallStyle)

        if is_importing:
          self.fileradio = newRadioButton(0)
          self.fileradio.set_text("Import from Self-Contained File")
        else:
          self.fileradio = newRadioButton(1)
          self.fileradio.set_text("Export to Self-Contained File")

        self.fileradio.add_clicked_callback(self.set_save_option)

        file_path = newBox(True)
        file_path.set_spacing(4)
        labelfile = newLabel("   File Path")
        self.file_te = newTextEntry()
        self.file_te.set_value(self.savefile_path)
        file_path.add(labelfile, False, False)
        file_path.add(self.file_te, True, True)
        file_path.add(self.file_btn, False, False)

        self.folderradio.add_clicked_callback(self.set_save_option)
        self.folderradio.set_active(True)
        self.folderlabel.set_style(mforms.SmallStyle)

        folder_path = newBox(True)
        folder_path.set_spacing(4)
        labelfolder = newLabel("   Folder Path")
        self.folder_te = newTextEntry()
        self.folder_te.set_value(self.savefolder_path)
        self.folder_btn = newButton()
        self.folder_btn.set_text("...")
        self.folder_btn.enable_internal_padding(False)
        self.folder_btn.add_clicked_callback(self.open_folder_chooser)
        folder_path.add(labelfolder, False, False)
        folder_path.add(self.folder_te, True, True)
        folder_path.add(self.folder_btn, False, False)

        optionsbox.add(self.folderradio, False, True)
        optionsbox.add(self.folderlabel, False, True)
        optionsbox.add(folder_path, False, False)
        if is_importing:
            self.folder_te.add_changed_callback(self.folder_path_changed)
            self.folder_load_btn = newButton()
            self.folder_load_btn.set_text("Load Folder Contents")
            self.folder_load_btn.add_clicked_callback(self.refresh_table_list)
            tbox = newBox(True)
            tbox.add(self.folder_load_btn, False, True)
            optionsbox.add(tbox, False, False)

        optionsbox.add(self.fileradio, False, True)
        optionsbox.add(self.filelabel, False, True)
        optionsbox.add(file_path, False, True)

        if self.single_transaction_check or self.dump_view_check or self.dump_routines_check:
            suboptionsbox = newBox(False)
            optionsbox.add(suboptionsbox, False, True)
        
        if self.single_transaction_check:
            suboptionsbox.add(self.single_transaction_check, False, True)
        if self.dump_view_check:
            suboptionsbox.add(self.dump_view_check, False, True)
        if self.dump_routines_check:
            suboptionsbox.add(self.dump_routines_check, False, True)

        if os.getenv("WB_DUMP_TEST_BUTTON"):
            self.test_button = newButton()
            self.test_button.set_text("Test")
            optionsbox.add(self.test_button, False, True)
            self.test_button.add_clicked_callback(self.test_clicked)


        self.file_te.set_enabled(False)
        optionspanel.add(optionsbox)

        selectionpanel = newPanel(mforms.TitledBoxPanel)
        if is_importing:
            selectionpanel.set_title("Select Database Objects to Import (only available for Project Folders)")
        else:
            selectionpanel.set_title("Select Database Objects to Export")
        selectionvbox = newBox(False)
        selectionvbox.set_padding(8)
        selectionvbox.set_spacing(8)
        selectionbox = newBox(True)
        selectionvbox.add(selectionbox, True, True)
        selectionbox.set_spacing(12)
        selectionbox.add(self.schema_list, True, True)
        selectionbox.add(self.table_list, True, True)
        selectionbbox = newBox(True)
        selectionbbox.set_spacing(8)
        
        if not is_importing:
            self.refresh_button = newButton()
            self.refresh_button.set_text("Refresh")
            selectionbbox.add(self.refresh_button, False, True)
            self.refresh_button.add_clicked_callback(self.refresh_table_list)
        
        self.select_all_btn = newButton()
        self.select_all_btn.set_text("Select All Tables")
        self.select_all_btn.add_clicked_callback(self.select_all_tables)
        self.select_all_btn.set_enabled(False)
        self.unselect_all_btn = newButton()
        self.unselect_all_btn.set_text("Unselect All")
        self.unselect_all_btn.add_clicked_callback(self.unselect_all_tables)
        self.unselect_all_btn.set_enabled(False)
        selectionbbox.add_end(self.unselect_all_btn, False, True)
        selectionbbox.add_end(self.select_all_btn, False, True)
        selectionvbox.add(selectionbbox, False, True)
        selectionpanel.add(selectionvbox)

        box.set_homogeneous(True)
        if is_importing:
            box.add(optionspanel, False, True)
        box.add(selectionpanel, False, True)
        if not is_importing:
            box.add(optionspanel, False, True)

        self.add(box, True, True)

        export_path = newBox(True)
        export_path.set_spacing(4)

        box = newBox(True)
        box.set_padding(8)
        box.set_spacing(12)
        statusbox = newBox(False)
        statusbox.set_spacing(2)
        self.dump_progressbar = newProgressBar()
        self.statlabel = newLabel("")
        statusbox.set_size(400, -1)
        statusbox.add(self.hintlabel, False, False)
        statusbox.add(self.dump_progressbar, False, False)
        statusbox.add(newLabel("Statistics:"), False, False)
        statusbox.add(self.statlabel, False, False)

        self.progress_log = newTextBox(mforms.VerticalScrollBar)
        self.progress_log.set_read_only(True)

        box.add(statusbox, False, False)
        label = newLabel("Log:")
        label.set_text_align(mforms.TopRight)
        box.add(label, False, False)
        box.add(self.progress_log, True, True)
        self.add(box, False, False)

        box = newBox(True)
        self.add(box, False, True)
        
        box.set_spacing(8)
        box.set_padding(0)
                
        self.export_button = newButton()
        if is_importing:
            self.export_button.set_enabled(False)
        box.add_end(self.export_button, False, True)
        self.export_button.add_clicked_callback(self.start)

        self.stop_button = newButton()
        self.stop_button.set_text("Stop")
        self.stop_button.set_enabled(False)
        self.stop_button.add_clicked_callback(self.stop)
        box.add_end(self.stop_button, False, True)

        self.add(box, False, True)

        if is_importing:
          self.file_btn.add_clicked_callback(lambda: self.open_file_chooser(mforms.OpenFile))
          self.single_transaction_check = None
          self.folderradio.set_text("Import from Backup Project Folder")
          self.export_button.set_text("Start Import")
        else:
          self.file_btn.add_clicked_callback(lambda: self.open_file_chooser(mforms.SaveFile))
          self.single_transaction_check.set_text("Create Dump in a Single Transaction")
          self.single_transaction_check.set_enabled(False)
          self.single_transaction_check.add_clicked_callback(self.single_transaction_clicked)
          self.dump_view_check.set_text("Dump Views")
          self.dump_routines_check.set_text("Dump Stored Routines (Procedures and Functions)")
          self.folderradio.set_text("Export to Backup Project Folder")
          self.export_button.set_text("Start Export")

        self.resume_layout()

    def get_default_dump_folder(self):
        try:
            path = grt.root.wb.options.options["dumpdirectory"] or "~/dumps"
        except:
            path = "~/dumps"
        return os.path.expanduser(path)

    def schema_list_edit(self, row, col, data): 
        if col == 0:
            self.schema_list.set_bool(row, 0, int(data))
            schema = self.schema_list.get_string(row, 1)
            tables, selection = self.tables_by_schema[schema]
            if int(data):
                selection.update(set(tables))
            else:
                selection.difference_update(set(tables))
            self.schema_selected()

    def table_list_edit(self, row, col, data): 
        self.table_list.set_bool(row, col, int(data))
        self.update_table_selection()
        if int(data):
            # select the schema if its not        
            sel = self.schema_list.get_selected()
            if not self.schema_list.get_check(sel, 0):
                self.schema_list.set_bool(sel, col, True)
                self.schema_selected()

    def count_selected_tables(self):
        count = 0
        for tlist, selected in self.tables_by_schema.values():
            count += len(selected)
        return count

    def update_table_selection(self):
        if not self.get_selected_schema():
             return
        tables, selection = self.tables_by_schema[self.get_selected_schema()]
        for r in range(len(tables)):
            if self.table_list.get_check(r, 0):
                selection.add(tables[r])
            else:
                selection.discard(tables[r])
        self.statlabel.set_text("%i tables selected" % self.count_selected_tables())

    def get_selected_schema(self):
        sel = self.schema_list.get_selected()
        if sel < 0:
            return None
        return self.schema_list.get_string(sel, 1)

    def schema_selected(self):
        sel = self.schema_list.get_selected()
        self.table_list.clear_rows()
        if sel < 0:
            self.unselect_all_btn.set_enabled(False)
            self.select_all_btn.set_enabled(False)
            return
        tables, selection = self.tables_by_schema[self.get_selected_schema()]
        for table in tables:
            r = self.table_list.add_row()
            self.table_list.set_bool(r, 0, table in selection)
            self.table_list.set_string(r, 1, table)
        self.unselect_all_btn.set_enabled(True)
        self.select_all_btn.set_enabled(True)
        
        self.statlabel.set_text("%i tables selected" % self.count_selected_tables())

    def select_all_tables(self):
        sel = self.schema_list.get_selected()
        if sel < 0:
            return
        self.schema_list.set_bool(sel, 0, True)
        for row in range(self.table_list.count()):
            self.table_list.set_bool(row, 0, True)
        self.update_table_selection()
        

    def unselect_all_tables(self):
        for row in range(self.table_list.count()):
            self.table_list.set_bool(row, 0, False)
        self.update_table_selection()

    def set_save_option(self):
        folder_selected = self.folderradio.get_active()
        self.folder_te.set_enabled(folder_selected)
        self.folder_btn.set_enabled(folder_selected)
        self.folderlabel.set_enabled(folder_selected)
        self.file_te.set_enabled(not folder_selected)
        self.file_btn.set_enabled(not folder_selected)
        self.filelabel.set_enabled(not folder_selected)

        if self.is_importing:
            if folder_selected:
                count = sum([len(item[1]) for item in self.tables_by_schema.values()])
                self.export_button.set_enabled(count > 0)
            else:
                self.export_button.set_enabled(True)
            self.schema_list.set_enabled(folder_selected)
            self.table_list.set_enabled(folder_selected)
        else:
            if folder_selected:
                self.single_transaction_check.set_active(False)
                self.single_transaction_check.set_enabled(False)
            else:
                self.single_transaction_check.set_enabled(True)

    def refresh(self):
        pass


    def update_progress(self):
        completed = True
        progress = 0
        if self.dump_thread != None:
            if not self.dump_thread.done:
                completed = False
            progress = self.dump_thread.progress
            self.dump_thread.logging_lock.acquire()
            while len(self.dump_thread.log) > 0:
                self.progress_log.append_text_and_scroll(self.dump_thread.log.popleft()+"\n", True)
#                print self.dump_thread.log.popleft()
#                print progress
            self.dump_thread.logging_lock.release() 
            self.statlabel.set_text(self.dump_thread.status_text)
        self.dump_progressbar.set_value(progress)
#       Python 2.6 needed
#       completed = self.dump_thread.is_alive()
        if completed:
#            print progress
            self.close_pipe()
            if self.dump_thread.abort_requested:
                self.tasks_aborted()
            else:
                self.tasks_completed()
            self.dump_thread = None
        return not completed

    def open_folder_chooser(self):
        filechooser = FileChooser(mforms.OpenDirectory)
        filechooser.set_directory(self.savefolder_path)
        if filechooser.run_modal():
            self.savefolder_path = filechooser.get_path()
            self.folder_te.set_value(self.savefolder_path)
            if self.is_importing:
                self.refresh_table_list()

    def open_file_chooser(self, chooser_type=mforms.SaveFile):
        filechooser = FileChooser(chooser_type)
        filechooser.set_directory(self.savefile_path)
        if filechooser.run_modal():
            self.savefile_path = filechooser.get_path()
            self.file_te.set_value(self.savefile_path)
            if self.is_importing:
                self.refresh_table_list()

    def get_mysql_password(self, reset_password=False):
        parameterValues = self.instance_info.connection.parameterValues
        pwd = parameterValues["password"]
        if not pwd or reset_password:
            username = parameterValues["userName"]
            host = self.instance_info.connection.hostIdentifier
            title = self.is_importing and "Import" or "Export"
            accepted, pwd = mforms.Utilities.find_or_ask_for_password(title, host, username, reset_password)
            if not accepted:
                return None
        return pwd

    def stop(self):
        if self.dump_thread:
            self.dump_thread.kill()

    def print_log_message(self, message):
        self.progress_log.append_text_and_scroll(message+"\n", True)

    def failed(self, message):
        self.progress_log.append_text_and_scroll(message+"\n", True)
        self.hintlabel.set_text("Operation Failed")
        self.export_button.set_enabled(True)
        self.stop_button.set_enabled(False)

    def cancelled(self, message):
        self.progress_log.append_text_and_scroll(message+"\n", True)
        self.hintlabel.set_text("Operation Cancelled")
        self.export_button.set_enabled(True)
        self.stop_button.set_enabled(False)


####################################################################################################
## Import
####################################################################################################

class WbAdminImportTab(WbAdminSchemaListTab):
    def __init__(self, owner, instance_info):
        WbAdminSchemaListTab.__init__(self, owner, instance_info, True)
        self.export_button.set_text("Start Import")
        self.tables_paths = {}
        self.views_paths = {}
        self.tables_by_schema = {}

    def folder_path_changed(self):
        self.folder_load_btn.set_enabled(True)
        self.savefolder_path = self.folder_te.get_string_value()


    def refresh_table_list(self):
        def parse_name_from_single_table_dump(path):
            f = open(path)
            schema = None
            table = None
            is_view = False
            for line in f:
                if line.startswith("-- Host:"):
                    schema = line.partition("Database: ")[-1].strip()
                    if table:
                        break
                elif line.startswith("CREATE TABLE"):
                    table = line.rstrip("\n\r (").partition("CREATE TABLE")[-1].strip()
                    if table[0] == '`':
                        table = table[1:-1]
                    if schema:
                        break
                elif line.startswith("/*!50001 VIEW") or line.startswith("/*!50003 CREATE*/ /*!50020 DEFINER="):
                    is_view = True
                    table = "Views and routines"
                    if schema:
                        break
            return schema, table, is_view

        self.folder_load_btn.set_enabled(False)
        self.tables_by_schema = {}
        # (schema, table) -> path
        self.tables_paths = {}
        self.views_paths = {}
        self.schema_list.clear_rows()
        try:
            save_to_folder = not self.fileradio.get_active()
            if save_to_folder:
                self.export_button.set_enabled(False)
                path = self.savefolder_path
                dirList=os.listdir(path)
                for fname in dirList:
                    fullname = os.path.join(path, fname)
                    if os.path.isfile(fullname) and os.path.splitext(fullname)[1] == ".sql":
                        # open the backup file and look for schema and table name in it
                        schema, table, is_view = parse_name_from_single_table_dump(fullname)
                        if not schema or not table:
                            self.print_log_message("%s does not contain schema/table information" % fullname)
                            continue
                        if self.tables_by_schema.has_key(schema):
                            tables, selection = self.tables_by_schema[schema]
                            tables.append(table)
                            tables.sort()
                            selection.add(table) # select all by default
                        else:
                            self.tables_by_schema[schema] = ([table], set([table]))
                        if is_view:
                            self.views_paths[(schema, table)] = fullname
                        else:
                            self.tables_paths[(schema, table)] = fullname

                if not self.tables_by_schema:
                    Utilities.show_message("Open Dump Folder", "There were no dump files in the selected folder.", "OK", "", "")
                else:
                    names = self.tables_by_schema.keys()
                    names.sort()
                    for schema in names:
                        row = self.schema_list.add_row()
                        self.schema_list.set_bool(row, 0, True)
                        self.schema_list.set_string(row, 1, schema)
                
                    self.export_button.set_enabled(True)
        except Exception, exc:
            import traceback
            traceback.print_exc()
            Utilities.show_error("Error Opening Dump", str(exc), "OK", "", "")
            self.failed(str(exc))

    def get_path_to_mysql(self):
        # get path to mysql client from options        
        try:
            path = grt.root.wb.options.options["mysqlclient"]
            if path:
                if os.path.exists(path):
                    return path
                if any(os.path.exists(os.path.join(p,path)) for p in os.getenv("PATH").split(os.pathsep)):
                    return path
                return None
        except:
            return None

        if sys.platform == "darwin":
            # if path is not specified, use bundled one
            return mforms.App.get().get_resource_path("mysql")
        elif sys.platform == "win32":
            return mforms.App.get().get_resource_path("mysql.exe")
        else:
            # just pick default
            if any(os.path.exists(os.path.join(p,"mysql")) for p in os.getenv("PATH").split(os.pathsep)):
                return "mysql"
            return None

    def start(self):
        self.export_button.set_enabled(False)

        from_folder = not self.fileradio.get_active()

        operations = []
        if from_folder:
          self.path = self.folder_te.get_string_value()
        else:
          self.path = self.file_te.get_string_value()
        #self.path = self.folder_te.get_string_value() if from_folder else self.file_te.get_string_value()

        self.hintlabel.set_text("Import is running ...")
        
        if from_folder:
            for schema, (tables, selection) in self.tables_by_schema.items():
                for table in selection:
                    logmsg = "Restoring %s (%s)" % (schema, table)
                    path = self.tables_paths.get((schema, table))
                    # description, object_count, extra_args, objects, pipe_factory
                    if path != None: 
                        task = DumpThread.TaskData(logmsg, 1, [], [path], lambda:None)
                        operations.insert(0,task) 
                    else: 
                        path = self.views_paths.get((schema, table)) 
                        task = DumpThread.TaskData(logmsg, 1, [], [path], lambda:None)
                        if path != None: 
                            operations.append(task) 
        else:
            if not os.path.exists(self.path):
                Utilities.show_message("Dump file not found", "File " + str(self.path) + " doesn't exist", "OK", "", "")
                self.failed("Dump file not found: File " + str(self.path) + " doesn't exist")
                return
            logmsg = "Restoring " + self.path
            # description, object_count, pipe_factory, extra_args, objects
            task = DumpThread.TaskData(logmsg, 1, [], [self.path], lambda:None)
            operations.append(task)
#            operations.append((logmsg, 1, lambda:None, [], [self.path]))

        tunnel = ConnectionTunnel(self.instance_info.connection)

        conn = self.instance_info.connection.parameterValues
        params = [
        "--password= ",
        "--host=" + (tunnel.port and ["localhost"] or [conn["hostName"]])[0],
        "--user=" + conn["userName"],
        "--port=" + str(tunnel.port or conn["port"]),
        "--default-character-set=utf8",
        "--comments",
        "<" # the rest of the params will be redirected from stdin
        ]
        if tunnel.port:
            params.insert(1, "--protocol=tcp")
        cmd = self.get_path_to_mysql()
        if cmd == None:
            self.failed("mysql command was not found, please install it or configure it in Edit -> Preferences -> MySQL")
            return
#        if cmd[0] != '"':
#            cmd = '"' + cmd + '"'
        cmd += " " + (" ".join(params))

        password = self.get_mysql_password()
        if password is None:
            self.cancelled("Password Input Cancelled")
            return

        self.stop_button.set_enabled(True)
        self.dump_thread = DumpThread(cmd, operations, password, self)
        self.dump_thread.is_import = True
        self.dump_thread.start()
        Utilities.add_timeout(float(0.4), self.update_progress)

    def fail_callback(self):
        pass

    def close_pipe(self):
        pass
    
    def tasks_aborted(self):
        self.cancelled(time.strftime('%X ') + "Aborted by User")
        self.print_log_message("Restored database(s) maybe in an inconsistent state")


    def tasks_completed(self):
        logmsg = time.strftime('%X ') + "Import of %s has finished" % str(self.path)
        if self.dump_thread.error_count > 0:
            self.hintlabel.set_text("Import Completed With %i Errors" % self.dump_thread.error_count)
            logmsg += " with %i errors" % self.dump_thread.error_count
        else:
            self.hintlabel.set_text("Import Completed")
        self.progress_log.append_text_and_scroll(logmsg+"\n\n\n", True)
        self.export_button.set_enabled(True)
        self.stop_button.set_enabled(False)


    def setup_test(self):
        print "test_setup"

        db_connection = self.owner.ctrl_be.sql

        try:
            db_connection.execute("DROP DATABASE IF EXISTS 1wb_export_test")
        except Exception, e:
             return "Error executing test setup query(%s)"%(e)
        self.dumpfile = tempfile.NamedTemporaryFile(delete=False)
        f = open(self.dumpfile.name,"w")
        initscript = [
        "CREATE DATABASE  IF NOT EXISTS `1wb_export_test`;",
        "USE `1wb_export_test`;",
        "CREATE  TABLE IF NOT EXISTS `1wb_export_test`.`test_table` ( \
        `id` INT(11) NOT NULL AUTO_INCREMENT ,\
        `predbc` DECIMAL(17,5) NULL DEFAULT NULL ,\
        `picms` DECIMAL(5,2) NULL DEFAULT NULL ,  \
        PRIMARY KEY (`id`) );",
        "INSERT INTO `1wb_export_test`.`test_table` VALUES \
        (1,'33.00000','123.00'),(2,'444.00000','12.00');"
        ]
        f.writelines(initscript)
        f.close()
        return None

    def select_file(self):
        self.folderradio.set_active(False)
        self.fileradio.set_active(True)
        self.set_save_option()
        self.savefile_path = self.dumpfile.name
        self.file_te.set_value(self.savefile_path)
        return None


    def start_restore(self):
            print "Starting Restore"
            self.start()
            return None

    def check_result(self):
        def check_val(result,name,expected_val):
            resval = result.stringByName(name)
            expected_val = str(expected_val)
            return (str(resval) == str(expected_val) and [None] or ["Wrong data got %s for %s instead of %s"%(resval,name,expected_val)])[0]

        db_connection = self.owner.ctrl_be.sql
        try:
            result = db_connection.exec_query("SELECT * FROM `1wb_export_test`.`test_table`")
            if not result.nextRow():
                return "Restored table is empty"
            res = check_val(result,"id",1)
            if res != None:
                return res
            res = check_val(result,"predbc","33.00000")
            if res != None:
                return res
            res = check_val(result,"picms","123.00")
            if res != None:
                return res
            if not result.nextRow():
                return "Restored doesn't have enough data"
            res = check_val(result,"id",2)
            if res != None:
                return res
            res = check_val(result,"predbc","444.00000")
            if res != None:
                return res
            res = check_val(result,"picms","12.00")
            if res != None:
                return res


        except:
            return "Error executing test data select"
        return None

    def cleanup(self):
        db_connection = self.owner.ctrl_be.sql
        try:
            db_connection.execute("DROP DATABASE IF EXISTS 1wb_export_test")
        except:
            return "Error executing test clean up query"
        if self.dumpfile!= None:
            self.dumpfile.close()
            os.remove(self.dumpfile.name)
        return None

    def test_clicked(self):
        self.test_steps = deque(
        [self.setup_test, self.select_file,
        self.start_restore,
#        lambda:None,lambda:None,lambda:None,
        self.check_result,
        self.cleanup
        ])
        Utilities.add_timeout(float(1.0), self.run_test)
        print "Export Test"

    def run_test(self):
        if not len(self.test_steps):
            print "Test OK"
            return False
        retval = self.test_steps.popleft()()
        if retval != None:
            print "Test failed: ",retval
            return False
        return True


####################################################################################################
## Export
####################################################################################################

class WbAdminExportTab(WbAdminSchemaListTab):
    class TableRefreshThread(threading.Thread):
        def __init__(self, owner):
            self.owner = owner
            self.views_by_schema = {}
            threading.Thread.__init__(self)

        def run(self):
            self.owner.refresh_table_list_thread()

    def __init__(self, owner, instance_info):
        self.schemasqls = {}
                
        self.savefolder_path = os.path.join(self.get_default_dump_folder(), time.strftime("Dump%Y%m%d"))
        self.savefile_path = self.savefolder_path + ".sql"
        self.basepath = self.savefolder_path
        self.update_paths()
        WbAdminSchemaListTab.__init__(self, owner, instance_info, False)
#        self.filefolder_label.set_text("Save to")

    def refresh_table_list_thread(self):
        try:
            result = self.owner.ctrl_be.exec_query("SHOW DATABASES")
            schema_names = []
            while result.nextRow():
                value = result.stringByName("Database")
                if type(value) is unicode:
                    value = value.encode("utf8")
                if value == "information_schema":
                    continue
                schema_names.append(value)            
            del result
            self.schemasqls = {}
            self.views_by_schema = {}
            schema_cntr = 1
            self.refresh_progress = float(schema_cntr) / len(schema_names)
            for schema in schema_names:
                schematables = []
                viewlist = []
                try:
                    self.refresh_state= "Retriving tables data for schema " + schema
                    dbcreate = self.owner.ctrl_be.exec_query("SHOW CREATE DATABASE `"+escape_sql_identifier(schema)+"`")
                    tableset = self.owner.ctrl_be.exec_query("SHOW FULL TABLES FROM `"+escape_sql_identifier(schema)+"`")
                    dbcreate.nextRow()
                    dbsql = dbcreate.stringByName("Create Database")
                    parts = dbsql.partition("CREATE DATABASE ")
                    dbsql = parts[0] + parts[1] + " IF NOT EXISTS " + parts[2] + ";\nUSE `" + escape_sql_identifier(schema) + "`;\n"
                    self.schemasqls[schema] = dbsql
                    while tableset.nextRow():
                        tabletype = tableset.stringByName("Table_type")
                        tablename = tableset.stringByName("Tables_in_"+schema)
                        if type(tablename) is unicode:
                            tablename = tablename.encode("utf8")
                        if tabletype == "VIEW":
                            viewlist.append(tablename)
                            continue
                        schematables.append(tablename)
                    del tableset
                except Exception, exc:
                    print "Error retriving table list form schema '",value,"'"
                    self.print_log_message("Error Fetching Table List From %s(%s)" % (value, str(exc)) )
                    mforms.Utilities.show_error("Error Fetching Table List From %s" % value, str(exc), "OK", "", "")
#                finally:
                schema_cntr += 1
                self.refresh_progress = float(schema_cntr) / len(schema_names)
                self.tables_by_schema[schema] = (schematables, set())
                self.views_by_schema[schema] = viewlist
        except Exception, exc:
            self.print_log_message("Error updating DB: %s" % str(exc) )
#        finally:
        self.refresh_completed = True

    def refresh_table_list(self):
        self.tables_by_schema = {} # schema -> (table_list, selection)
        self.dump_progressbar.set_value(0)
        
        if not self.owner.ctrl_be.is_sql_connected():
            return

        self.hintlabel.set_text("Schema list update")
        self.refresh_state = "Retriving schema list"
        self.refresh_progress = 0
        self.schema_list.clear_rows()
        self.refresh_button.set_enabled(False)
        self.refresh_thread = self.TableRefreshThread(self)
#        refresh_thread.run()
        self.refresh_completed = False
        self.refresh_thread.start()
        Utilities.add_timeout(float(0.4), self.update_refresh)

    def update_refresh(self):
        if self.refresh_progress > 1:
            self.refresh_progress = float(1)
        self.dump_progressbar.set_value(self.refresh_progress)
        self.statlabel.set_text(self.refresh_state)
        if not self.refresh_completed:
            return True
        self.dump_progressbar.set_value(0)
        names = self.tables_by_schema.keys()
        names.sort()
        for schema in names:
            r = self.schema_list.add_row()
            self.schema_list.set_string(r, 1, schema)
            self.schema_list.set_bool(r, 0, 0)
        self.refresh_button.set_enabled(True)
        self.statlabel.set_text("")
        self.hintlabel.set_text("Press [Start Export] to start...")
        return False


    def update_paths(self):
        pathcntr = 1
        while os.path.exists(self.savefolder_path):
            self.savefolder_path = self.basepath + "-" + str(pathcntr)
            pathcntr += 1
        pathcntr = 1
        while os.path.exists(self.savefile_path):
            self.savefile_path = self.basepath + "-" + str(pathcntr) + ".sql"
            pathcntr += 1

  
    def get_path_to_mysqldump(self):
        # get path to mysqldump from options        
        try:
            path = grt.root.wb.options.options["mysqldump"]
            if path:
                if os.path.exists(path):
                    return path
                if any(os.path.exists(os.path.join(p,path)) for p in os.getenv("PATH").split(os.pathsep)):
                    return path
                return None
        except:
            return None

        if sys.platform == "darwin":
            # if path is not specified, use bundled one
            return mforms.App.get().get_resource_path("mysqldump")
        elif sys.platform == "win32":
            return mforms.App.get().get_resource_path("mysqldump.exe")
        else:
            # just pick default
            if any(os.path.exists(os.path.join(p,"mysqldump")) for p in os.getenv("PATH").split(os.pathsep)):
                return "mysqldump"
            return None


    def validate_single_transaction(self, starting):
        schemas_to_dump = self.get_objects_to_dump()
        # check if there are >1 schemas selected and if so, that all tables are selected in each
        if len(schemas_to_dump) > 1 and self.single_transaction_check.get_active():
            ok = True
            for schema, tables in schemas_to_dump:
                if len(self.tables_by_schema[schema][0]) != len(tables):
                    ok = False
                    break
            if not ok:
                if starting:
                    r = mforms.Utilities.show_warning("Export to Disk", 
                              "Selectively exporting tables from multiple schemas using a single transaction is not supported.\n"
                              "Would you like to select all tables from all selected schemas to be exported?",
                              "Export All Tables", "Cancel", "")
                    if r != mforms.ResultOk:
                        return False
                else:
                    r = mforms.Utilities.show_warning("Export to Disk", 
                              "Selectively exporting tables from multiple schemas using a single transaction is not supported.\n"
                              "Would you like to select all tables from all selected schemas to be exported?",
                              "Select All Tables", "No", "")
                    if r != mforms.ResultOk:
                        self.single_transaction_check.set_active(False)
                        return True
                for schema, t in self.get_objects_to_dump():
                    tables, selection = self.tables_by_schema[schema]
                    selection.update(set(tables))
                self.schema_selected()
        return True


    def single_transaction_clicked(self):
        self.validate_single_transaction(False)


    def get_objects_to_dump(self):
        schemas_to_dump = []
        names = self.tables_by_schema.keys()
        names.sort()
        for schema in names:
        #No tables selected for schema so skip it
            tables, selection = self.tables_by_schema[schema]
            if not selection:
                continue
            schemas_to_dump.append((schema, list(selection)))
        return schemas_to_dump

    class TableDumpData(DumpThread.TaskData):
        def __init__(self,schema,table,make_pipe):
            title = "Dumping " + schema
            title += " (%s)" % table
            DumpThread.TaskData.__init__(self,title, 1, [], [schema, table],make_pipe)

    class ViewDumpData(DumpThread.TaskData):
        def __init__(self,schema,views,make_pipe,dump_routines):
            title = "Dumping " + schema + " views"
            DumpThread.TaskData.__init__(self,title, len(views), [], [schema] + views, make_pipe)
            if dump_routines:
                self.extra_arguments.append("--routines")

    class RoutinesDumpData(DumpThread.TaskData):
        def __init__(self,schema,make_pipe):
            title = "Dumping " + schema + " routines"
            DumpThread.TaskData.__init__(self,title, 1, ["--routines" ," --no-create-info" ," --no-data" ," --no-create-db"], [schema], make_pipe)

    def dump_to_folder(self, schemaname, tablename):
        self.close_pipe()        
        self.out_pipe = open(os.path.join(self.path, normalize_filename(schemaname) + "_" + normalize_filename(tablename) + '.sql'),"w")
        self.out_pipe.write(self.schemasqls[schemaname])
        self.out_pipe.flush()
        return self.out_pipe

        
    def start(self):
        self.export_button.set_enabled(False)

        if not self.validate_single_transaction(True):
            self.export_button.set_enabled(True)
            return 
        single_transaction = self.single_transaction_check.get_active()
        dump_views = self.dump_view_check.get_active()
        dump_routines = self.dump_routines_check.get_active()

        save_to_folder = not self.fileradio.get_active()

        if save_to_folder:
          self.path = self.folder_te.get_string_value()
        else:
          self.path = self.file_te.get_string_value()

        # gather objects to dump
        schemas_to_dump = self.get_objects_to_dump()

        if len(schemas_to_dump) == 0:
            self.progress_log.append_text_and_scroll(time.strftime('%X ') + "Nothing to do, no schemas or tables selected." + "\n", True)
            self.export_button.set_enabled(True)
            return
        
        # assemble list of operations/command calls to be performed
        operations = []
        if save_to_folder:
            if not os.path.exists(self.path):
                os.makedirs(self.path)
            for schema, tables in schemas_to_dump:
                for table in tables:
                    title = "Dumping " + schema
                    title += " (%s)" % table
                    # description, object_count, pipe_factory, extra_args, objects
                    task = self.TableDumpData(schema,table,lambda schema=schema,table=table:self.dump_to_folder(schema, table))
                    operations.append(task)
                if dump_views:
                    task = self.ViewDumpData(schema,self.views_by_schema[schema],lambda schema=schema,table=table:self.dump_to_folder(schema, "views"),dump_routines)
                    operations.append(task)
                elif dump_routines: # Dump routines separately only if no views dumped
                    task = self.RoutinesDumpData(schema,lambda schema=schema,table=table:self.dump_to_folder(schema, "routines"))
                    operations.append(task)
        else: # single file
            if not os.path.exists(os.path.dirname(self.path)):
                os.makedirs(os.path.dirname(self.path))

            # if there is a single schema to dump or single-transaction is off we allow selecting the tables
            if len(schemas_to_dump) == 1 or not single_transaction:
                for schema, tables in schemas_to_dump:
                    if dump_views:
                        tables += self.views_by_schema[schema]
                    title = "Dumping " + schema
                    title += " (%s)" % ", ".join(tables)
                    objects = [schema] + tables                    
                    if single_transaction:
                        params = ["--single-transaction=TRUE"]
                    else:
                        params = []
                    if dump_routines:
                        params.append("--routines")
                    # description, object_count, pipe_factory, extra_args, objects
                    task = DumpThread.TaskData(title, len(tables), params, objects, lambda schema=schema:self.dump_to_file([schema]))
                    operations.append(task)
#                    operations.append((title, len(tables), lambda schema=schema:self.dump_to_file([schema]), params, objects))
            else:
                # for multiple schemas, we can't pick the tables
                schema_names = [s[0] for s in schemas_to_dump]
                count = sum([len(s[1]) for s in schemas_to_dump])
                title = "Dumping " + ", ".join(schema_names)
                if single_transaction:
                    params = ["--single-transaction=TRUE", "--databases"]
                else:
                    params = ["--databases"]
                if dump_routines:
                    params.append("--routines")
                # --databases includes CREATE DATABASE info, so it's not needed for dump_to_file()
                # description, object_count, pipe_factory, extra_args, objects
                task = DumpThread.TaskData(title, count, params, schema_names, lambda:self.dump_to_file([]))
                operations.append(task)
#                operations.append((title, count, lambda:self.dump_to_file([]), params, schema_names))
    
        tunnel = ConnectionTunnel(self.instance_info.connection)

        conn = self.instance_info.connection.parameterValues
        params = {
        "host":(tunnel.port and ["localhost"] or [conn["hostName"]])[0],
        "port":(tunnel.port and [str(tunnel.port)] or [conn["port"]])[0],
        "default-character-set":"utf8",
        "user":conn["userName"]
        }
        if tunnel.port:
            params["protocol"] = "tcp"

        params.update(self.owner.get_export_options())
        cmd = self.get_path_to_mysqldump()
        if cmd == None:
            self.failed("mysqldump command was not found, please install it or configure it in Edit -> Preferences -> MySQL")
            return
        if cmd[0] != '"':
            cmd = '"' + cmd + '"'
        cmd += " --password="
        for paramname, paramvalue in params.items():
            cmd += " --"+paramname+((paramvalue != None and ["="+str(paramvalue)] or [""])[0])
        password = self.get_mysql_password()
        if password is None:
            self.cancelled("Password Input Cancelled")
            return
        self.stop_button.set_enabled(True)
        self.hintlabel.set_text("Export is running ...")
        self.dump_thread = DumpThread(cmd, operations, password, self)
        self.dump_thread.is_import = False
        self.dump_thread.start()
        Utilities.add_timeout(float(0.4), self.update_progress)

    def dump_to_file(self, schemanames):
        if self.out_pipe == None:
            self.out_pipe = open(self.path,"w")
        for schema in schemanames:
            self.out_pipe.write(self.schemasqls[schema])
        self.out_pipe.flush()
        return self.out_pipe

    def fail_callback(self):
        fname = self.out_pipe.name
        self.close_pipe()
        os.remove(fname)

    def close_pipe(self):
        if self.out_pipe != None:
            self.out_pipe.close()
            self.out_pipe = None

    def tasks_aborted(self):
        if self.path:
            try:
                os.rename(self.path, self.path+".cancelled")
                self.print_log_message("Partial backup file renamed to %s.cancelled" % self.path)
            except Exception, exc:
                self.print_log_message("Error renaming partial backup file %s: %s" % (self.path, exc))

        self.cancelled(time.strftime('%X ') + "Aborted by User")


    def tasks_completed(self):
        self.update_paths()
        self.file_te.set_value(self.savefile_path)
        self.folder_te.set_value(self.savefolder_path)
        logmsg = time.strftime('%X ') + "Export of %s has finished" % str(self.path)
        if self.dump_thread.error_count > 0:
            self.hintlabel.set_text("Export Completed With %i Errors" % self.dump_thread.error_count)
            logmsg += " with %i errors" % self.dump_thread.error_count
        else:
            self.hintlabel.set_text("Export Completed")
        self.print_log_message(logmsg+"\n\n\n")
        self.export_button.set_enabled(True)
        self.stop_button.set_enabled(False)

    def setup_test(self):
        print "test_setup"

        db_connection = self.owner.ctrl_be.sql

        try:
            db_connection.execute("DROP DATABASE IF EXISTS 1wb_export_test")
            db_connection.execute("CREATE DATABASE 1wb_export_test")
            db_connection.execute("CREATE  TABLE IF NOT EXISTS `1wb_export_test`.`test_table` ( \
            `id` INT(11) NOT NULL AUTO_INCREMENT ,\
            `predbc` DECIMAL(17,5) NULL DEFAULT NULL ,\
            `picms` DECIMAL(5,2) NULL DEFAULT NULL ,  \
            PRIMARY KEY (`id`) );")
            db_connection.execute("INSERT INTO `1wb_export_test`.`test_table` VALUES \
            (1,'33.00000','123.00'),(2,'444.00000','12.00');")
        except Exception, e:
             return "Error executing test setup query(%s)"%(e)
        self.resfile = tempfile.NamedTemporaryFile(delete=False)
        return None

    def check_refresh(self):
        print "Checking refresh"
        schema_index = None
        for row in range(self.schema_list.count()):
            schemaname = self.schema_list.get_string(row, 1)
            if "1wb_export_test" == schemaname:
               schema_index = row
               break
        if schema_index == None:
            return "No schema found in list"
        self.schema_list.set_bool(schema_index, 0, True)
        self.schema_list.set_selected(schema_index)
        self.schema_selected()
        self.select_all_tables()
        return None

    def select_file(self):
        self.folderradio.set_active(False)
        self.fileradio.set_active(True)
        self.set_save_option()
        self.savefile_path = self.resfile.name
        self.file_te.set_value(self.savefile_path)
        return None


    def start_dump(self):
            print "Starting Dump"
            self.start()
            return None

    def check_result(self):
        f = open(self.resfile.name,"r")
        found_use = False
        found_inserts = False
        for line in f:
            if line == "INSERT INTO `test_table` VALUES (1,33.00000,123.00),(2,444.00000,12.00);\n":
                found_inserts = True
            if line == "USE `1wb_export_test`;\n":
                found_use = True
        f.close()
        if not found_use:
            return "USE statement missing in output file"
        if not found_inserts:
            return "INSERT statement missing in output file"
        return None

    def cleanup(self):
        db_connection = None
        if self.instance_info.connection:
          db_connection = MySQLConnection(self.instance_info.connection)
          error_location = None
          the_error = None
          try:
            db_connection.connect()
          except MySQLError, exc:
            error_location = exc.location
            the_error = str(exc)

          if not db_connection.is_connected:
            return "Could not Connect to MySQL Server at %s %s." % (error_location, the_error)
        else:
            return "No connection information specified in the server instance profile."

        try:
            db_connection.execute("DROP DATABASE IF EXISTS 1wb_export_test")
        except:
             return "Error executing test clean up query"

        if self.resfile != None:
            self.resfile.close()
            os.remove(self.resfile.name)
        return None

    def test_clicked(self):
        self.test_steps = deque(
        [self.setup_test,self.refresh_table_list,
        self.check_refresh, self.select_file,
        self.start_dump,
#        lambda:None,lambda:None,lambda:None,
        self.check_result,
        self.cleanup
        ])
        Utilities.add_timeout(float(1.0), self.run_test)
        print "Export Test"

    def run_test(self):
        if not len(self.test_steps):
            print "Test OK"
            return False
        retval = self.test_steps.popleft()()
        if retval != None:
            print "Test failed: ",retval
            return False
        return True

####################################################################################################
## Options
####################################################################################################

class WbAdminExportOptionsTab(mforms.Box):
    class check_option_getter:
        def __init__(self,optname,checkbox):
            self.optname = optname
            self.checkbox = checkbox

        def get_option(self):
            return {self.optname:(self.checkbox.get_active() and ["TRUE"] or ["FALSE"])[0]}


    def __init__(self):
        mforms.Box.__init__(self, False)
        self.set_managed()

        self.options = {}
        outerbox = newBox(False)
        outerbox.set_padding(8)
        outerbox.set_spacing(12)
        for groupname, options in reversed(wb_admin_export_options.export_options.items()):
            box = newBox(False)
            box.set_padding(8)
            box.set_spacing(8)
            panel = newPanel(mforms.TitledBoxPanel)
            panel.set_title(groupname)
#            print groupname
            for optname, option in reversed(options.items()):
                checkbox = newCheckBox()
                checkbox.set_text("%s - %s"% (optname, option[0]))
                checkbox.set_active(option[1] == "TRUE")
                box.add(checkbox, False, True)
                self.options[optname] = self.check_option_getter(optname,checkbox)
            panel.add(box)
            outerbox.add(panel, True, True)
        scrollpan = newScrollPanel(False)
        scrollpan.add(outerbox)
        self.add(scrollpan, True, True)

    def get_options(self):
        options = {}
        for optname, getter in self.options.items():
            result = getter.get_option()
            if result != None:
                options.update(result)
        return options

####################################################################################################

class WbAdminExport(mforms.Box):
    ui_created = False

    def __init__(self, instance_info, ctrl_be):
        mforms.Box.__init__(self, False)
        self.ctrl_be = ctrl_be
        self.set_managed()
        self.secman = None
        self.instance_info = instance_info


    def page_activated(self):
        if not self.ui_created:
            self.suspend_layout()
            self.create_ui()
            self.resume_layout()
            self.ui_created = True
            self.export_tab.refresh_table_list()

        if self.ctrl_be.is_sql_connected():
            self.warning.show(False)
            self.tabview.show(True)
        else:
            self.warning.show(True)
            self.tabview.show(False)


    def create_ui(self):
        self.suspend_layout()

        self.warning = not_running_warning_label()
        self.add(self.warning, False, True)

        self.tabview = newTabView(False)
        self.add(self.tabview, True, True)
        self.tabview.show(False)
    
        self.export_tab = WbAdminExportTab(self, self.instance_info)
        self.tabview.add_page(self.export_tab, "Export to Disk")

        self.import_tab = WbAdminImportTab(self, self.instance_info)
        self.tabview.add_page(self.import_tab, "Import from Disk")

        self.options_tab = WbAdminExportOptionsTab()
        self.tabview.add_page(self.options_tab, "Advanced Export Options")

        self.resume_layout()

 
    def get_export_options(self):
        return self.options_tab.get_options()


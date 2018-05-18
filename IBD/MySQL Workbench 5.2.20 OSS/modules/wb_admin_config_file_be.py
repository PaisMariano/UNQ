import copy
import errno

from mforms import *
import mforms
from wb_admin_utils import dprint, dprint_ex

import gc
import os
import tempfile

import wb_admin_control_be

pysource = {}
pysource['engine-list'] = "grt.root.wb.options.options[\"@db.mysql.Table:tableEngine/Items\"]"
multi_separator = ';'

#===============================================================================
class Option:
  def __init__(self, section, line = None, value = None):
    self.section = section
    self.values = []
    if line is not None and value is not None:
      self.values.append((line, value))

  def append(self, line, value):
    self.values.append((line, value))

  def is_multiline(self):
    return len(self.values) > 1

  def is_switch_opt(self):
    ret = False
    if len(self.values) > 0:
      ret = type(self.values) == bool
    return ret

  def val(self, i):
    return self.values[i][1]

  def line(self, i):
    return self.values[i][0]

  def __iter__(self):
    return iter(self.values)

  def __len__(self):
    return len(self.values)

  def __str__(self):
    return multi_separator.join([str(x[1]) for x in self.values])

#===============================================================================

CHANGE = 1
DELETE = 2
ADD    = 3

#===============================================================================
# ApplyWizard class 
class ApplyWizard(Form):
    #view = None     # Holds mforms view(currently TextBox) to display diff and file text
    #view_btn = None # We need ref to this button as pressing on it changes view mode
                    # from diff to file. So the button's label must be changed accordingly
    #cmds_view = None # That is the display widget of commands to execute to save file
    #accept_action = None # This is an accept_action passed from client via ApplyWizard::show

    #---------------------------------------------------------------------------
    def __init__(self, owner, ctrl_be, settings):
      Form.__init__(self, None)

      self.set_title("Apply Changes to MySQL Configuration File")

      self.settings = settings
      self.ctrl_be = ctrl_be
      self.is_win = self.settings.serverInfo['sys.system'] == 'Windows'

      content = Box(False)
      content.set_padding(12)
      content.set_spacing(12)

      file = self.ctrl_be.get_config_file_path()
      msg = "The following changes were made to the configuration file \"%s\"\nand will be saved when you click [Apply]." % file
      msg += "\nYou may edit the File Preview if you wish to make more changes manually."
      msg += "\nPlease review carefully as some mistakes could prevent the MySQL server from starting."
      content.add(newLabel(msg), False, True)

      self.file_textbox = TextBox(BothScrollBars)
      self.file_textbox.set_bordered(True)
      self.diff_view_textbox = TextBox(BothScrollBars)
      self.diff_view_textbox.set_bordered(True)
      content.add(self.file_textbox, True, True)
      content.add(self.diff_view_textbox, True, True)

      button_box = Box(True)
      button_box.set_spacing(12)
      apply_btn = Button()
      apply_btn.set_text("Apply")

      self.cancel_btn = Button()
      self.cancel_btn.set_text("Cancel")
      self.cancel_btn.add_clicked_callback(self.cancel_clicked)

      self.view_btn = Button()
      self.view_btn.add_clicked_callback(self.switch_view)

      #self.save_from_preview_btn = Button()
      #self.save_from_preview_btn.set_text("Save from preview")
      #self.save_from_preview_btn.add_clicked_callback(self.save_from_preview)

      button_box.add(self.view_btn, False, False)
      #button_box.add(self.save_from_preview_btn, False, False)

      button_box.add_end(apply_btn, False, False)
      button_box.add_end(self.cancel_btn, False, False)

      content.add(button_box, False, False)

      #panel = Panel(TitledBoxPanel)
      #panel.set_title("Commands which will be run to save config file")

      # unused???
      #self.cmds_view = newLabel()
      #self.cmds_view.set_wrap_text(True)

      #panel.add(self.cmds_view)
      #content.add(panel, False, False)

      self.set_content(content)
      self.center()
      self.set_size(640,480)
      apply_btn.add_clicked_callback(self.apply_clicked)

    def switch_view(self):
      if self.view_diff == False:
        #switch to view diff
        self.file_textbox.show(False)
        self.diff_view_textbox.show(True)
        self.view_btn.set_text("View File Preview")
        #self.save_from_preview_btn.set_enabled(False)
        self.view_diff = True
      else:
        self.view_btn.set_text("View Changes")
        self.file_textbox.show(True)
        self.diff_view_textbox.show(False)
        #self.save_from_preview_btn.set_enabled(True)
        self.view_diff = False

    def apply_clicked(self):
      if self.accept_action is not None:
        text_from_box = self.file_textbox.get_string_value()
        if text_from_box != self.cfgfile:
          answer = Utilities.show_message("Confirm Changes from Preview"
            ,"You have made additional edits to the configuration file in preview.\n"
             "If you wish to save these changes click [Yes], "
             "or if you wish to ignore these changes click [No]."
            ,"Yes", "No", "")
          if answer != mforms.ResultOk:
            text_from_box = None
       
        if text_from_box:
          App.get().set_status_text("Saving Configuration File with Manual Edits...")
        else:
          App.get().set_status_text("Saving Configuration File...")
        try:
          self.accept_action(text_from_box) # call action passed from caller(client)
          App.get().set_status_text("Configuration File Saved.")
        except Exception, exc:
          App.get().set_status_text("Error Saving Configuration File.")
          Utilities.show_error("Could not Save Configuration File", "There was an error saving the configurationfile: %s"%exc, "OK", "", "")

      self.close()

    def cancel_clicked(self):
      App.get().set_status_text("Cancelled Save of Configuration File")
      self.accept_action = None
      self.close()

    def show(self, changes_text, temp_file_content, accept_action = None):
      self.accept_action = accept_action
      self.view_diff = False            # Set view mode to list changes (diff)
      self.cfgfile = temp_file_content  # Content of the file
      self.file_textbox.set_value(self.cfgfile)
      self.diff_view_textbox.set_value(changes_text)

      self.switch_view() # Make it show diff

      self.show_modal(None, self.cancel_btn)


#===============================================================================
class WbAdminConfigFileBE:
    settings = None
    file_lines = []
    original_opts = {}
    file_name = ""
    changeset = {}
    sections = []
    apply_form = None


    class ChangesetItem:
      mod = None
      section = None
      value = None
      name = None
      orig_opt = None

      def __init__(self, m,s,n,v):
        self.mod = m
        self.section = s
        self.value = v
        self.name = n

      def __repr__(self):
        if self.mod == ADD:
          s = "+"
        elif self.mod == DELETE:
          s = "-"
        elif self.mod == CHANGE:
          s = "*"
        s += self.section + ":" + self.name + "=" + str(self.value)
        if self.orig_opt:
          s += ";[" + str(self.orig_opt) + "]"
        return s + "   "

    #---------------------------------------------------------------------------
    def __init__(self, server_instance_settings, ctrl_be):
      self.settings = server_instance_settings
      self.ctrl_be = ctrl_be
      self.is_win = self.settings.serverInfo['sys.system'] == 'Windows'

    #---------------------------------------------------------------------------
    def is_local(self):
      return self.ctrl_be.is_local_server()

    #---------------------------------------------------------------------------
    def read_mysql_cfg_file(self, file_name):
      # read_mysql_cfg_file fetches file in case of remote file
      # Return value is the name of the file
      file_lines = []
      self.file_lines = []
      # ctrl_be (MyCtrl) fetches file for remote file or returns file_name for local files
      local_file_name = self.ctrl_be.fetch_file(file_name)

      # At this point we should have either downloaded file to a temp location, or existing local file
      try:
        f = open(local_file_name, "r")
        for line in f:
          file_lines.append(line)
        f.close()
        self.file_lines = file_lines
        dprint_ex(2, "read_mysql_cfg_file ", local_file_name)
      except:
        self.file_lines = []
        print "read_mysql_cfg_file failed. Added empty content", local_file_name

      return local_file_name

    #---------------------------------------------------------------------------
    def save_config_file(self, user_modified_file_content):
      pwd = None
      sudo = 0
      if user_modified_file_content is not None:
        f = open(self.temp_file_name, "w")
        f.write(user_modified_file_content)
        f.close()

      if self.ctrl_be.is_local_server():
        dprint_ex(1, "Check if we can write to file ", self.file_name)
        (directory, filename) = wb_admin_control_be.splitpath(self.file_name)
        (can_write, error_number) = wb_admin_control_be.can_write_to_dir(directory)
        password = None
        if can_write == False:
          if error_number == errno.ENOENT:
            dprint_ex(1, "Directory does not exist.")
            raise Exception("Cannot write configuration file: directory does not exist")
          elif error_number == errno.EACCES:
            dprint_ex(1, "Directory exists, but access is denied. Requesting sudo/admin pwd")
            if self.is_win == False:
              accepted, password = mforms.Utilities.find_or_ask_for_password("Administrator/sudo Password Required",
                        "sudo@localhost", "root", False)
              if not accepted:
                  password = None
            else:
              password = "UAC"

        (file_exists, error_number) = wb_admin_control_be.check_file_is_in_dir(directory, filename)

        if file_exists == True:
          dprint_ex(1, "Making backup copy of the original file")
          output, rc = self.ctrl_be.copy_file(self.file_name, self.file_name + ".wba.bak", password is not None, password)
              
        dprint_ex(1, "copying file from", self.temp_file_name, "to", self.file_name, " sudo =", password is not None)
        output, rc = self.ctrl_be.copy_file(self.temp_file_name, self.file_name, password is not None, password)

        if rc != 0 and rc is not None:
          raise Exception("Could not write configuration file: %s"%output)

        password = None
      else:
        self.ctrl_be.upload_file(self.temp_file_name)

      pwd = " ".zfill(128)
      self.parse_file()

    #---------------------------------------------------------------------------
    def process_include_directive(self, opt_ln_with_include):
      #we can have either
      tokens = opt_ln_with_include.split(" ")
      directive = tokens[0].lower()
      tail = " ".join(tokens[1:])
      if directive == "!include":
        self.parse_file(tail)
      elif directive == "!includedir":
        files = os.listdir(tail)
        for file in files:
          if file[-4:] == ".cnf" or file[-4:] == ".ini":
            self.parse_file(os.path.join(tail,file))

    #---------------------------------------------------------------------------
    def parse_file(self, file_name = ""):
      if file_name == "":
        file_name = self.ctrl_be.get_config_file_path()

      # Reset changes which could be made to the previously loaded config
      self.changeset = {}
      # read_mysql_cfg_file either reads local file or fetches file from 
      # the remote and read it in as a local temp copy
      self.file_name = self.read_mysql_cfg_file(file_name)

      filter_by_section = self.settings.serverInfo['sys.config.section']
      if filter_by_section is None or filter_by_section == "":
        filter_by_section = "mysqld"

      dprint_ex(1, "Parsing options only from section", filter_by_section)

      self.sections = []
      if self.file_name is not None:
        cur_file_original_opts = {}

        current_section = ""
        for i,line in enumerate(self.file_lines):
          sline = line.strip(" \r\n\t")
          # Skip empty and commented out lines
          if len(sline) > 0 and ((sline[0] is not '#') and (sline[0] is not ';')):
            # Got section start line
            if sline[0] == '[':
              current_section = sline.strip("[]")
              # Add sections as we go, having list of section names and its start lines
              # we can compute section lines range to add config values later
              self.sections.append((i, current_section))
            elif sline.lower().find("!include") == 0:
              # Currently we skip include and includedir directives
              pass
            else:
              # Split line into option name and option value
              opt = sline.split("=")

              if current_section == filter_by_section:
                option_name = opt[0].strip(" \t")

                option = None
                if option_name in cur_file_original_opts:
                  option = cur_file_original_opts[option_name]
                else:
                  option = Option(current_section)
                  cur_file_original_opts[option_name] = option

                #i is a line # at which the option is in the cfg file
                # Form option tuple of form (section, line, value)
                if len(opt) > 1:
                  option.append(i, (" ".join(opt[1:])).strip(" \t"))
                else:
                  option.append(i, True)

        self.original_opts = cur_file_original_opts
        self.sections = sorted(self.sections, lambda x,y: cmp(x[0], y[0]))

      if len(self.sections) == 0 and len(self.file_lines) == 0:
        section = self.settings.serverInfo['sys.config.section']
        self.sections.append((0, section))
        self.file_lines.append("[" + section + "]\n")
      
      return self.file_name


    #---------------------------------------------------------------------------
    def option_added(self, name, value, section):
      dprint("opt_added ", name, value, section)
      if value is None:
        value = True

      if section is None:
        section = self.settings.serverInfo['sys.config.section']

      ci = WbAdminConfigFileBE.ChangesetItem(ADD, section, name, value)
      if self.original_opts.has_key(name) and self.original_opts[name].section == section:
        opt = self.original_opts[name]
        ci.mod = CHANGE
        ci.orig_opt = opt

      self.changeset[name] = ci

    #---------------------------------------------------------------------------
    def option_removed(self, name, section):
      dprint("opt removed", name)

      if self.original_opts.has_key(name):
        ci = WbAdminConfigFileBE.ChangesetItem(DELETE, section, name, "")
        opt = self.original_opts[name]
        ci.mod = DELETE
        ci.orig_opt = opt
        self.changeset[name] = ci
      elif self.changeset.has_key(name):
        ci = self.changeset[name]
        if ci.section == section:
          del self.changeset[name]

    #---------------------------------------------------------------------------
    def option_changed(self, name, string_value, section):
      dprint("opt changed", name, string_value)
      if self.original_opts.has_key(name):
        opt = self.original_opts[name]
        ci = WbAdminConfigFileBE.ChangesetItem(CHANGE, section, name, string_value)
        ci.orig_opt = opt
        self.changeset[name] = ci
      else:
        self.changeset[name] = WbAdminConfigFileBE.ChangesetItem(ADD, section, name, string_value)

    #---------------------------------------------------------------------------
    def get_options(self, section):
      options = []
      for (name, opt) in self.original_opts.iteritems():
        if opt.section == section:
          if self.changeset.has_key(name):
            options.append((name, self.changeset[name].value))
          else:
            options.append((name, str(opt)))

      return options

    #---------------------------------------------------------------------------
    def get_sections(self):
      return [x[1] for x in self.sections]

    #---------------------------------------------------------------------------
    def get_section_line_nr_range(self, section_name):
      ret = [-1,-1]
      sections_nr = len(self.sections) - 1
      for i,sec in enumerate(self.sections):
        if sec[1] == section_name:
          ret[0] = sec[0]
          if i < sections_nr:
            ret[1] = self.sections[i + 1][0] - 1
          else:
            ret[1] = len(self.file_lines)

      return ret

    #---------------------------------------------------------------------------
    def validate_changes(self, options):
      option_types = {}
      for item in options.itervalues():
        for group in item["groups"]:
          for control in group["controls"]:
            option_types[control["name"]] = control["type"]

      errors = ""
      for change in self.changeset.itervalues():
        otype = option_types.get(change.name)
        if not otype: continue
        if change.mod in (CHANGE, ADD):
          if otype == "filename":
            if change.value == "":
              errors += "Option '%s' is blank, but should be a path\n" % change.name
      return errors
      
    #---------------------------------------------------------------------------
    def apply_changes(self):
      if self.file_name is None:
        return

      # Build sections map. self.sections holds tuples of form (section_name, section first line number)
      # self.sections is sorted by line numbers
      # This map of sections is needed to sort changeset items. We sort them in the following order:
      # CHANGE first as it does not require line to be added or deleted. Next is REMOVE action. REMOVE action
      # is replacement of the line in file with and empty one. And the last goes ADD action. As we need to 
      # calculate line number to insert we need to insert from bottom to top, so we need an additional sort
      # criteria - sections order. That means that when sorting two ADD actions the first action in the sorted changelist 
      # will be the one which is in the lower section
      sections_map = dict([(x[1],self.get_section_line_nr_range(x[1])) for x in self.sections])

      def sort_fn(x,y):
        r = cmp(x.mod,y.mod)
        if x.mod == ADD and r == 0:
          r = cmp(sections_map[y.section][0], sections_map[x.section][0])
        return r

      change = sorted(self.changeset.itervalues(), sort_fn)
      second_pass_changes = []

      # Now we have sorted items (CHANGE, DEL, ADD). This is the order we will apply changes
      file_lines = copy.deepcopy(self.file_lines)
      for c in change:
        if c.mod == CHANGE:
          dprint("Applying change ",c)
          # Here comes the hard part
          orig_values_len     = len(c.orig_opt)
          modified_values_len = len(c.value)
          # First we apply changes of multiple options, so we walk the least common part of both lists
          # say we have 3 orignal options and 4 modified, so we will apply changes to the first three
          # and ADD a new one after that
          for i in range(min(orig_values_len, modified_values_len)):
            # Orig opt is list of tupples with a format of (linenr, old_value)
            line_nr = c.orig_opt.line(i)
            dprint("line_nr", line_nr, c.orig_opt)
            file_lines[line_nr] = c.name + " = " + c.value[i] + "\n"
          # Below are two branches which schedule items for second pass. At the current - first
          # pass we can not change line number via adding or removing lines
          if orig_values_len < modified_values_len:
            # Add options here
            for i in range(orig_values_len, modified_values_len):
              ci = WbAdminConfigFileBE.ChangesetItem(ADD, c.section, c.name, c.value[i])
              second_pass_changes.append(ci)
          elif orig_values_len > modified_values_len:
            #Remove options here
            for i in range(modified_values_len, orig_values_len):
              file_lines[c.orig_opt.line(i)] = ""
              ci = WbAdminConfigFileBE.ChangesetItem(DELETE, c.section, c.name, c.orig_opt.val(i))
              second_pass_changes.append(ci)
        elif c.mod == DELETE:
          # In c.orig_opt[1] we have a line number for single-lien options, or a string 'Multiple' for multi-line ones
          for line, value in c.orig_opt:
            file_lines[line] = ""
        elif c.mod == ADD:
          lines_range = sections_map[c.section]
          if lines_range[1] >= 0:
            if type(c.value) is list or type(c.value) is tuple:
              lineno = lines_range[1]
              for v in c.value:
                if type(v) is bool:
                  file_lines.insert(lines_range[1], c.name + "\n")
                else:
                  file_lines.insert(lineno, c.name + " = " + v.strip(" ") + "\n")
                  lineno += 1
            else:
              file_lines.insert(lines_range[1], c.name + " = " + c.value + "\n")
          else:
            print "Can't add option"

      # handle only addition for now, as change and delete can be done in place earlier
      for c in second_pass_changes:
        if c.mod == ADD:
          lines_range = sections_map[c.section]
          if lines_range[1] >= 0:
            vtype = type(c.value)
            if vtype is bool:
              file_lines.insert(lines_range[1], c.name + "\n")
            if vtype is str or vtype is unicode:
              file_lines.insert(lines_range[1], c.name + " = " + c.value + "\n")
            else:
              file_lines.insert(lines_range[1], c.name + " = " + c.value + "\n")
          else:
            print "Can't add option"

      tempdir = tempfile.gettempdir()
      self.temp_file_name = os.path.join(tempdir, "mysql_workbench_config.temp")
      outf = open(self.temp_file_name, "w")
      for line in file_lines:
        outf.write(line)
      outf.close()

      # Prepare data for ApplyWizard
      self.apply_form = ApplyWizard(self, self.ctrl_be, self.settings)

      changes_for_apply = [(ci.mod, ci.section, ci.name, ci.value) for ci in change]
      second_pass_changes_for_apply = [(ci.mod, ci.section, ci.name, ci.value) for ci in second_pass_changes]
      changes_for_apply += second_pass_changes_for_apply

      line_end = "\n"
      if self.is_win:
        line_end = "\r\n"

      # Prepare diff view content
      mods_as_text = [" ", "Changed: ", "Removed: ", "Added:  "]
      changes_text = ""
      for (mod, section, name, value) in changes_for_apply:
        changes_text += mods_as_text[mod]
        changes_text += "[" + section + "] "
        changes_text += name
        if value is not None:
          if (type(value) is list or type(value) is tuple):
            if len(value) > 1:
              changes_text += " = " + " ; ".join(value)
            else:
              changes_text += " = " + str(value[0])
          else:
            if type(value) is not bool:
              changes_text += " = " + str(value)
        changes_text += line_end

      temp_file_content = ""
      try:
        outf = open(self.temp_file_name, "r")
        temp_file_content = outf.read()
        outf.close()
      except BaseException, e:
        temp_file_content = "Can not read file " + self.temp_file_name + "\n" + str(e)

      self.apply_form.show(changes_text, temp_file_content, self.save_config_file)

    #---------------------------------------------------------------------------
    def revert(self):
      file_name = self.ctrl_be.get_config_file_path()
      if file_name is not None:
        self.parse_file(self.file_name)


if __name__ == "__main__":
    class Settings:
      serverInfo = {'sys.config.path' : '/etc/mysql/my.cnf'}
      #serverInfo = {'sys.config.path' : os.path.join(os.getcwd(), 'my.cnf')}

    s = Settings()
    cfg = WbAdminConfigFileBE(s)
    cfg.parse_file(s.ctrl_be.get_config_file_path())


    print "\n\n------------------\nLines:\n"
    for i,line in enumerate(cfg.file_lines):
      print i, line.rstrip("\r\n")

    
    print "\n\n------------------\nSections:\n"
    for sec in cfg.get_sections():
      print sec, cfg.get_section_line_nr_range(sec)
    
    print "\n\n------------------\nParsed options\n"
    for k,v in cfg.original_opts.iteritems():
      print k,v

    print "\n\n----------------\ngetting options for [mysqld]"
    for o in  cfg.get_options('mysqld'):
      print o


    cfg.option_added('buffer', '16k', 'isamchk')
    cfg.option_changed('port', '3307', 'client')
    cfg.option_changed('bind-address', '127.0.0.1', 'mysqld')
    cfg.option_added('basedir', '/var/mysql', 'mysqld')
    cfg.option_added('datadir', '/var/mysql/data', 'mysqld')
    cfg.option_added('user', 'mysql', 'client')
    cfg.option_removed('quick', 'mysqldump')


    for k,v in cfg.changeset.iteritems():
      print v

    print "\n\n----------------\ngetting options for [mysqld]"
    for o in  cfg.get_options('mysqld'):
      print o

    print "\n\n----------------\ngetting options for [mysqld2]"
    for o in  cfg.get_options('mysqld2'):
      print o


    cfg.apply_changes()
    
    print "\n\n------------------\nLines:\n"
    for i,line in enumerate(cfg.file_lines):
      print i, line.rstrip("\r\n")
    

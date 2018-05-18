import opts
import grt
import copy
from mforms import TabView, newBox, newTable, newPanel, TitledBoxPanel, newScrollPanel, newCheckBox, newTextEntry
from mforms import newLabel, HFillFlag, VFillFlag, HExpandFlag, Utilities, newSelector
from mforms import newButton, SmallHelpTextStyle, FileChooser, OpenDirectory
from mforms import SelectorPopup, SelectorCombobox
import mforms
import wb_admin_config_file_be
import os
from wb_admin_utils import dprint_ex
from wb_admin_config_file_be import multi_separator

CATOPTS = os.getenv("WB_CATOPTS")
if CATOPTS is not None:
  cat_sec = ('General', 'Advanced', 'MyISAM Parameters', 'Performance', 'Log Files', 'Security', 'InnoDB Parameters', 'Networking', 'Replication')
  cat_grp = ('Networking', 'Advanced log options', 'Slave replication objects', 'Slave default connection values', 'Activate Logging', 'Memory', 'Fulltext search', 'Data / Memory size', 'Datafiles', 'Localization', 'Thread specific settings', 'Advanced', 'Advanced Settings', 'Various', 'Binlog Options', 'Memory usage', 'Directories', 'Logfiles', 'Relay Log', 'Master', 'General slave', 'Security', 'Activate InnoDB', 'Slave Identification', 'Query cache', 'General', 'Insert delayed settings', 'Slow query log options', 'Naming', 'Timeout Settings')

  def handle_cat_opt(cat, grp, enabled):
    print "CATOPT", "'" + enabled + "', '" + cat.get_string_value() + "', '" + grp.get_string_value()
    #f = open("cats.txt", "a")
    #f.write("'" + enabled + "', '" + cat.get_string_value() + "', '" + grp.get_string_value() + "'\n")
    #f.close()

#--------------------------------------
def option_is_for_version(version, versions_list):
  short_version   = version[0:2]
  is_full_version = len(version) >= 3

  ret = False
  for v in versions_list:
    is_full_v = len(v) >= 3
    short_v = v[0:2]

    # If short versions match, check longer ones
    # If we have a long (like x.y.z) version in vs then it means that the option was introduced
    # from this server version
    if short_version == short_v:
      # Check if we have a full version format of the argument
      if is_full_version:
        # Check if we have long version format of the current version from the list
        if is_full_v:
          # We do have full version, check if it is k
          if version >= v:
            ret = True
            break
        else:
          ret = True # We have short version (x.y) as an argument, so assume that all x.y version will do
          break
      else:
        ret = True # We have short version (x.y) as an argument, so assume that all x.y version will do
        break

  return ret


#===============================================================================
class Page:
  def __init__(self, page_name, page_content):
    self.page_name = page_name
    self.page_content = page_content
    self.panel = None
    self.created = False

#===============================================================================
class WbAdminConfigFileUI(TabView):
    def page_activated(self):
      if not self.ui_created:
        self.suspend_layout()
        self.create_ui()
        self.resume_layout()
        self.ui_created = True
      
      #if self.ctrl_be.is_


    #---------------------------------------------------------------------------
    def __init__(self, server_instance_settings, file_name_ctrl, section_ctrl, ctrl_be, version="5.1"):
      TabView.__init__(self)
      
      self.myopts = None
      self.opt2ctrl_map = {}
      self.loading = True
      self.section = None
      self.ui_created = False

      self.set_managed()
      self.version = version
      self.ctrl_be = ctrl_be
      self.settings = server_instance_settings
      self.file_name_ctrl = file_name_ctrl
      self.file_name_ctrl.set_enabled(False)
      self.section_ctrl = section_ctrl
      self.cfg_be = wb_admin_config_file_be.WbAdminConfigFileBE(server_instance_settings, ctrl_be)
      self.version = version

    def create_page(self, page_number):
      self.loading = True
      if page_number < 0 or page_number == 0:
        self.loading = False
        return

      if page_number not in self.pages:
        print "Unknown page number ", page_number
        self.loading = False
        return

      page = self.pages[page_number]
      if page.created == True:
        self.loading = False
        return

      page_name    = page.page_name
      page_content = page.page_content

      box = newBox(False)
      box.set_spacing(8)
      box.suspend_layout()

      options = self.cfg_be.get_options(self.section_ctrl.get_string_value())
      opts_map = dict(options)

      server_version = self.ctrl_be.get_server_version()

      for group in page_content['groups']:
        controls = group['controls']
        
        empty = True
        # check if this group is empty
        for ctrl_def in controls:
          versions = ctrl_def['versions']
          if option_is_for_version(server_version, versions):
            empty = False
            break
        if empty:
          continue
        
        number_of_controls = len(controls)
        table = newTable()
        table.set_row_spacing(10)
        table.set_column_spacing(20)
        table.set_padding(5)
        table.suspend_layout()
        table.set_homogeneous(False)

        panel = newPanel(TitledBoxPanel)
        panel.add(table)
        panel.set_title(group['caption'])
        box.add(panel, False, True)

        table.set_row_count(number_of_controls)
        table.set_column_count(3)

        table_row = -1 # Counter to address table rows, as we may skip some control_idx.

        for control_idx in range(0, number_of_controls):
          ctrl_def = controls[control_idx]

          versions = ctrl_def['versions']
          if not option_is_for_version(server_version, versions):
            continue
          else:
            table_row += 1

          ctrl_tupple = self.place_control(ctrl_def, table, table_row)
          label = newLabel(ctrl_def['description'])
          label.set_size(500, -1)
          label.set_wrap_text(True)
          label.set_style(SmallHelpTextStyle)
          table.add(label, 2, 3, table_row, table_row + 1, HFillFlag | VFillFlag)

          tag      = ctrl_tupple[0]
          ctrl     = ctrl_tupple[1]
          ctrl_def = ctrl_tupple[2]

          name = ctrl_def['name']
          #load default value into control
          if ctrl is not None and ctrl_def is not None:
            ctrl[0].set_active(False)
            self.enabled_checkbox_click(name, False)
            if ctrl_def.has_key('default'):
              default = ctrl_def['default']
              if default is not None:
                self.set_string_value_to_control(ctrl_tupple, default)
            else:
              self.set_string_value_to_control(ctrl_tupple, "")

          #load control with values from config
          if name in opts_map:
            value = opts_map[name]
            self.set_string_value_to_control(ctrl_tupple, value)
            self.enabled_checkbox_click(name, True)

        # Remove empty rows
        table.set_row_count(table_row+1)#number_of_controls - (number_of_controls - table_row))
        table.resume_layout()

      page.panel.add(box)
      page.created = True
      box.resume_layout()
      self.loading = False

    def tab_changed(self):
      page_number = self.get_active_tab() + 1
      self.create_page(page_number)

    def create_ui(self):
      self.loading = True

      sys_config_path = self.ctrl_be.get_config_file_path()
      if sys_config_path is None:
        sys_config_path = ""
      self.file_name_ctrl.set_value(sys_config_path)
      self.section_ctrl.add_changed_callback(self.clear_and_load)
      try:
        self.myopts = opts.opts_list
      except KeyError:
        Utilities.show_error("Error", "Wrong version '" + self.version + "'given to admin plugin", "Close", None, None)

      self.load_options_from_cfg()

      #build ordered list of pages
      self.pages = {}
      for page_name, page_content in self.myopts.iteritems():
        self.pages[int(page_content['position'])] = Page(page_name, page_content) # False means page not created
      page_positions = self.pages.keys()
      page_positions.sort()

      # Create dummy pages
      for page_pos in page_positions:
        page = self.pages[page_pos]
        page.panel = newScrollPanel(False)
        self.add_page(page.panel, page.page_name)

      # Create first page, so we display something from start
      self.create_page(1)
      self.loading = True # create_page resets loading flag

      self.add_tab_changed_callback(self.tab_changed)

      self.loading = False

    def create_textedit(self, name, ctrl_def):
      te = newTextEntry()
      te.set_enabled(False)
      te.add_changed_callback(lambda: self.control_action(name))
      te.set_tooltip("To convert option to a multi-line one, use " + multi_separator + " to separate values. The symbol " + multi_separator + " should not be the first char")
      return te

    def create_dir_file_edit(self, name, ctrl_def):
      dir_box = newBox(True)
      dir_box.set_spacing(4)

      te = newTextEntry()
      te.set_tooltip("To convert option to a multi-line one, use " + multi_separator + " to separate values. The symbol " + multi_separator + " should not be the first char")
      btn = newButton()
      btn.set_text("...")
      btn.enable_internal_padding(False)
      btn.add_clicked_callback(lambda: self.open_file_chooser(OpenDirectory, te, name))

      dir_box.add(te, True, True)
      dir_box.add(btn, False, False)
      te.set_enabled(False)
      btn.set_enabled(False)

      return (dir_box, te, btn)

    def create_numeric(self, name, ctrl_def):
      spin_box = newBox(True)
      spin_box.set_spacing(5)
      te = newTextEntry()
      spin_box.add(te, True, True)
      te.set_enabled(False)

      te.add_changed_callback(lambda: self.control_action(name))

      unit = None
      if ctrl_def.has_key('unitcontrol'):
        unit = ctrl_def['unitcontrol']

      unitcontrol = None
      unit_items = None

      if unit is not None:
        unitcontrol = newSelector()
        unit_items = unit.split(";")
        for item in unit_items:
          unitcontrol.add_item(item)

        spin_box.add(unitcontrol, False, False)
        unitcontrol.set_enabled(False)
        unitcontrol.add_changed_callback(lambda: self.control_action(name))

      return (spin_box, te, unitcontrol, unit_items)

    def create_dropdownbox(self, name, ctrl_def, ctype):
      items = None
      if 'items' in ctrl_def:
        items = ctrl_def['items']
      else:
        items = ctrl_def['choices']

      style = SelectorPopup
      if ctype == 'dropdownboxentry':
        style = SelectorCombobox
      dropbox = newSelector(style)

      if type(items) is str:
        if items in wb_admin_config_file_be.pysource:
          code = wb_admin_config_file_be.pysource[items]
          result = eval(code)
          items = {}
          for item in result.split(','):
            item = item.strip(" \t")
            items[item] = item

      for i,v in items.iteritems():
        dropbox.add_item(i)
      dropbox.set_enabled(False)
      if ctrl_def.has_key('default'):
        default = ctrl_def['default']
        idx = 0
        for i,v in items.iteritems():
          if v == default:
            dropbox.set_selected(idx)
          idx += 1

      dropbox.add_changed_callback(lambda: self.control_action(name))

      return (dropbox, items)

    #---------------------------------------------------------------------------
    def place_control(self, ctrl_def, table, row):
      ctrl = None
      ctype = ctrl_def['type']
      name = ctrl_def['name']

      enabled = newCheckBox()
      enabled.set_text(ctrl_def['caption'])
      enabled.set_size(200, -1) # Use a fixed fix to make all tables align their columns properly. Must be larger than the largest text, to make it work.
      enabled.set_tooltip(ctrl_def['name'])

      # place_control creates control as ctrl_def describes. Reference to a created control is placed 
      # to map of controls. That is done in order to access controls via option name
      if ctype == "checkbox" or ctype == "boolean":
        ctrl = ('chk', (enabled, enabled), ctrl_def)
        self.opt2ctrl_map[name] = ctrl
        if ctrl_def.has_key('default'):
          enabled.set_active(ctrl_def['default'] == "Checked")
        label = newLabel(" ")
        table.add(label, 1, 2, row, row+1, HExpandFlag | HFillFlag)
      elif ctype == 'textedit' or ctype == 'string':
        te = self.create_textedit(name, ctrl_def)
        table.add(te, 1, 2, row, row+1, HExpandFlag | HFillFlag)
        ctrl = ('txt', (enabled, te), ctrl_def)
        self.opt2ctrl_map[name] = ctrl
      elif ctype == "directory" or ctype == "filename":
        (dir_box, te, btn) = self.create_dir_file_edit(name, ctrl_def)
        table.add(dir_box, 1, 2, row, row + 1, HExpandFlag | HFillFlag)
        te.add_changed_callback(lambda: self.control_action(name))
        ctrl = ('dir', (enabled, te, btn), ctrl_def)
        self.opt2ctrl_map[name] = ctrl
      elif ctype == "numeric" or ctype == "spinedit":
        (spin_box, te, unitcontrol, unit_items) = self.create_numeric(name, ctrl_def)
        ctrl = ('spn', (enabled, te, unitcontrol, unit_items), ctrl_def)
        self.opt2ctrl_map[name] = ctrl
        table.add(spin_box, 1, 2, row, row + 1, HExpandFlag | HFillFlag)
      elif ctype == "dropdownbox" or ctype == 'dropdownboxentry':
        if 'items' not in ctrl_def and 'choices' not in ctrl_def:
          te = newTextEntry()
          te.set_enabled(False)
          te.add_changed_callback(lambda: self.control_action(name))
          table.add(te, 1, 2, row, row+1, HExpandFlag | HFillFlag)
          ctrl = ('txt', (enabled, te), ctrl_def)
          self.opt2ctrl_map[name] = ctrl
        else:
          (dropbox, items) = self.create_dropdownbox(name, ctrl_def, ctype)
          table.add(dropbox, 1, 2, row, row + 1, HExpandFlag | HFillFlag)
          ctrl = ('drp', (enabled, dropbox, items), ctrl_def)
          self.opt2ctrl_map[name] = ctrl

      if CATOPTS is None:
        table.add(enabled, 0, 1, row, row + 1, HFillFlag)
        enabled.add_clicked_callback(lambda: self.enabled_checkbox_click(name))
      else:
        catbox = newBox(True)
        cat = newSelector(mforms.SelectorCombobox)
        for item in cat_sec:
          cat.add_item(item)
        grp = newSelector(mforms.SelectorCombobox)
        for item in cat_grp:
          grp.add_item(item)
        cat.add_changed_callback(lambda : handle_cat_opt(cat, grp, ctrl_def['name']))
        grp.add_changed_callback(lambda : handle_cat_opt(cat, grp, ctrl_def['name']))
        catbox.add(cat, True, True)
        catbox.add(grp, True, True)
        catbox.add(enabled, True, True)
        table.add(catbox, 0, 1, row, row + 1, HExpandFlag | HFillFlag)

      return ctrl

    #---------------------------------------------------------------------------
    def open_file_chooser(self, type, textfield, name):
      filechooser = FileChooser(type)
      filechooser.set_directory(textfield.get_string_value())
      if filechooser.run_modal():
        textfield.set_value("\"" + filechooser.get_directory() + "\"")
        self.control_action(name)
      
    #---------------------------------------------------------------------------
    def enabled_checkbox_click(self, name, force_enabled = None):
      if self.opt2ctrl_map.has_key(name):
        ctrl = self.opt2ctrl_map[name]

        def control(idx):
           return ctrl[1][idx]

        tag = ctrl[0] # tupple ctrl holds tag at index 0, the rest is control def. Exact format
                      # of control tupple(the one that goes after tag is defined by the type of control

        if force_enabled is not None:
          enabled = force_enabled
          control(0).set_active(enabled)
        else:
          enabled = control(0).get_active()

        if tag == "txt":
          control(1).set_enabled(enabled)
        elif tag == "spn":
          control(1).set_enabled(enabled)
          if control(2) is not None:
            control(2).set_enabled(enabled)
        elif tag == "drp":
          control(1).set_enabled(enabled)
        elif tag == "dir":
          control(1).set_enabled(enabled)
          control(2).set_enabled(enabled)

        if not self.loading:
          # Notify config BE about change
          if enabled:
            self.cfg_be.option_added(name, self.get_string_value_from_control(ctrl), self.section)
          else:
            self.cfg_be.option_removed(name, self.section)

    #---------------------------------------------------------------------------
    def control_action(self, name):
      if self.loading:
        return

      if self.opt2ctrl_map.has_key(name):
        ctrl = self.opt2ctrl_map[name]

        if not self.loading:
          self.cfg_be.option_changed(name, self.get_string_value_from_control(ctrl), self.section)

    #---------------------------------------------------------------------------
    def get_string_value_from_control(self, ctrl):
      #ctrl is a tupple from map
      value = ""

      tag = ctrl[0]
      def control(idx):
        return ctrl[1][idx]

      is_multiple = False
      control_name = control(1).get_name()
      if control_name == "Multiple":
        is_multiple = True

      if tag == "txt":
        value = (control(1).get_string_value(),)
      elif tag == "spn":
        # (enabled, te, unitcontrol, unit_items)). Note! unitcontrol and unit_items may be None
        value = control(1).get_string_value().strip(" \r\n\t")

        if control(2) is not None:
            value += control(2).get_string_value()
      elif tag == "drp":
        value = control(1).get_string_value()
        # Replace value from the UI with a real value
        # ctrl = ('drp', (enabled, dropbox, items), ctrl_def)
        items = ctrl[1][2]
        if value in items:
          mapped_value = items[value]
          value = mapped_value
      elif tag == "dir":
        value = control(1).get_string_value()
        if is_multiple:
          value = value.split(';')
      elif tag == "chk":
        value = (control(0).get_active(),)

      is_string = type(value) is str or type(value) is unicode
      if is_multiple == False and is_string and value.find(multi_separator) > 0 and not self.loading:
        answer = Utilities.show_message("Confirm"
            ,"Multi-line option format entered. Would you like to convert option to multi-line?"
            , "Convert", "Skip", "")
        if answer == mforms.ResultOk:
          control(1).set_name("Multiple")
          value = map(lambda x: x.strip(multi_separator), value.split(multi_separator))

      if type(value) is not list and type(value) is not tuple:   
        value = (value,)

      return value

    #---------------------------------------------------------------------------
    #Value is a an integer with
    def parse_spin_string(self, unit_items, value):
      value = value.strip(" \r\t\n")
      longest_suffix = 0
      if unit_items is not None:
        for item in unit_items:
          l = len(item)
          if (l > longest_suffix):
            longest_suffix = l

      suffix = ""

      def get_unit(sfx):
        sfx2 = sfx.lower()
        ret_item = None
        for item in unit_items:
          if sfx2 == item.lower():
            ret_item = item
            break
        return ret_item

      if longest_suffix > 0:
        value_len = len(value)
        for suffix_length in range(1,longest_suffix + 1):
          if suffix_length < value_len:
            cur_sfx = value[-suffix_length:]
            cur_unit = get_unit(cur_sfx)
            if cur_unit is not None:
              suffix = cur_unit
              value = value[:-suffix_length]

      return (filter(lambda x: x.isdigit() or x == '-', value), suffix)


    #---------------------------------------------------------------------------
    def set_string_value_to_control(self, ctrl, value):
      #ctrl is a tupple from map
      tag = ctrl[0]
      def control(idx):
        return ctrl[1][idx]


      is_multiple = False
      if len(value) > 1:
        is_multiple = True
        control(1).set_name("Multiple")
      else:
        control(1).set_name("Single")

      if tag == "txt" or tag == "dir":
        if value is None or value.__class__ != "".__class__:
          # TODO: Add config file error message
          value = ""
        value = value.strip(" \r\n\t")
        control(1).set_value(value)
      elif tag == "spn":
        if value is None:
          value = ""
        elif type(value) is not str:
          # TODO: Add Warning
          pass
        value = value.strip(" \r\n\t")
        (value,suffix) = self.parse_spin_string(control(3), value)
        control(1).set_value(value)

        if control(2) is not None and suffix is not None:
          try:
            idx = control(3).index(suffix)
            control(2).set_selected(idx)
          except ValueError:
            pass
      elif tag == "drp":
        #search for value
        try:
          items = control(2)
          if items is not None:
            lowcase_value = value.lower()
            for (i, item) in enumerate(items.values()):
              if item.lower() == lowcase_value:
                control(1).set_selected(i)
        except ValueError:
          pass
      elif tag == "chk":
        control(1).set_active(value == "Checked" or value == "True" or value == True)
      else:
        print "Error"

    #---------------------------------------------------------------------------
    def config_apply_changes_clicked(self):
      option_types = {}
      
      errors = self.cfg_be.validate_changes(self.myopts)
      if errors:
        mforms.Utilities.show_warning("Configuration Error",
                    "The following errors were found in the changes you have made.\n"
                    "Please correct them before applying:\n"+errors, "OK", "", "")
      else:
        self.cfg_be.apply_changes()

    #---------------------------------------------------------------------------
    def config_discard_changes_clicked(self):
      #self.cfg_be.revert()
      self.clear_and_load()

    #---------------------------------------------------------------------------
    def clear_and_load(self):
      if self.loading == False:
        self.load_defaults()
        self.load_options_from_cfg(self.section_ctrl.get_string_value())

    #---------------------------------------------------------------------------
    def load_options_from_cfg(self, given_section = None):
      self.loading = True

      self.cfg_be.parse_file(self.file_name_ctrl.get_string_value())

      self.section_ctrl.clear()

      idx = 0
      if given_section is None or given_section == "":
        given_section = self.settings.serverInfo['sys.config.section']

      # Fill section selector at the bottom of config file page
      section_ctrl_was_filled = False
      for i,sec in enumerate(self.cfg_be.get_sections()):
        self.section_ctrl.add_item(sec)
        section_ctrl_was_filled = True
        if sec == given_section:
          idx = i
          self.section = sec

      # If we have an empty file or file with no section, add user-specified default section to the selector
      if section_ctrl_was_filled == False and given_section is not None:
        self.section_ctrl.add_item(given_section)
        idx = 0

      self.section_ctrl.set_selected(idx)

      # each opt is (name, value)
      for name, value in self.cfg_be.get_options(self.section):
        if self.opt2ctrl_map.has_key(name):
          ctrl = self.opt2ctrl_map[name]
          self.set_string_value_to_control(ctrl, value)
          self.enabled_checkbox_click(name, True)

      self.loading = False

    #---------------------------------------------------------------------------
    def load_defaults(self):
      self.loading = True
      for name,ctrl_tupple in self.opt2ctrl_map.iteritems():
        if ctrl_tupple is not None:
          tag      = ctrl_tupple[0]
          ctrl     = ctrl_tupple[1]
          ctrl_def = ctrl_tupple[2]

          if ctrl is not None and ctrl_def is not None:
            ctrl[0].set_active(False)
            self.enabled_checkbox_click(ctrl_def['name'], False)
            if ctrl_def.has_key('default'):
              default = ctrl_def['default']
              if default is not None:
                self.set_string_value_to_control(ctrl_tupple, default)
            else:
              self.set_string_value_to_control(ctrl_tupple, "")

      self.loading = False

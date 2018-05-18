from mforms import App, Utilities, newBox, newPanel, newButton, newLabel, newTabView, newTabSwitcher, newTextEntry, newSelector, Form, TreeView
import mforms
import wb_admin_ssh

#===============================================================================
#
#================== =============================================================
class RemoteFileSelector:
  def __init__(self, ls, cwd, cd):
    self.ls = ls
    self.cwd = cwd
    self.cd = cd
    self.selection = ""

  def get_filenames(self):
    return self.selection

  def on_change(self):
    selid = self.flist.get_selected()
    fname = self.flist.get_string(selid, 1)

    self.selection = self.curdir.get_string_value() + fname

  def on_cd(self, row, column):
    print self.cwd()
    
    fname = None
    selid = self.flist.get_selected()
    if selid > -1:
      fname = self.flist.get_string(selid, 1)

    if fname is not None or fname != "":
      if not self.cd(fname):
        self.selection = self.curdir.get_string_value() + fname
        self.form.close()

    curdir = self.cwd()
    self.curdir.set_value(curdir)
    self.flist.clear_rows()

    (dirs, files) = self.ls('.')

    if curdir != "/":
      row_id = self.flist.add_row()
      self.flist.set_string(row_id, 0, 'd')
      self.flist.set_string(row_id, 1, '..')

    for d in dirs:
      row_id = self.flist.add_row()
      self.flist.set_string(row_id, 0, 'd')
      self.flist.set_string(row_id, 1, d)

    for f in files:
      row_id = self.flist.add_row()
      self.flist.set_string(row_id, 0, ' ')
      self.flist.set_string(row_id, 1, f)

  def cancel_action(self):
    self.selection = None

  def accept_action(self):
    self.form.close()

  def run(self):
    self.form  = Form(None, mforms.FormResizable)
    self.form.set_title("Select configuration file on remote server")
    self.flist = TreeView(mforms.TreeShowHeader)
    self.curdir = newTextEntry()

    self.flist.add_column(mforms.StringColumnType, " ", 20, False)
    self.flist.add_column(mforms.StringColumnType, "Name", 400, False)
    self.flist.end_columns()

    self.flist.add_activated_callback(self.on_cd)
    self.flist.add_changed_callback(self.on_change)

    accept = newButton()
    accept.set_text("OK")
    cancel = newButton()
    cancel.set_text("Cancel")
    button_box = newBox(True)
    button_box.set_padding(10)
    button_box.set_spacing(8)
    Utilities.add_end_ok_cancel_buttons(button_box, accept, cancel)

    box = newBox(False) # Hosts all entries on that dialog.
    box.set_padding(10)
    box.set_spacing(10)
    box.add(self.curdir, False, False)
    box.add(self.flist, True, True)
    box.add(button_box, False, False)

    self.form.set_content(box)
    self.form.set_size(400, 300)

    cancel.add_clicked_callback(self.cancel_action)
    accept.add_clicked_callback(self.accept_action)

    self.form.relayout()
    self.form.center()

    self.on_cd(0, 0)

    # Don't use the accept button in run_modal or you won't be able to press <enter>
    #  to change the path via the top edit control.
    self.form.run_modal(None, cancel)

#-------------------------------------------------------------------------------
def remote_file_selector(loginInfo, serverInfo):
  class Settings:
    def __init__(self, s, l):
      self.loginInfo = s
      self.serverInfo = l

  settings = Settings(serverInfo, loginInfo)

  ssh = None

  try:
    ssh = wb_admin_ssh.WbAdminSSH()
    ssh.wrapped_connect(settings)
  except wb_admin_ssh.ConnectCanceled:
    ssh = None
  except wb_admin_ssh.SSHDownException:
    ssh = None

  file_names = []

  if ssh is not None and ssh.is_connected():
    ftp = ssh.getftp()

    if ftp:
      rfs = RemoteFileSelector(ls = ftp.ls, cwd = ftp.pwd, cd = ftp.cd)
      rfs.run()
      result = rfs.get_filenames()
      if result is not None:
        file_names = result

      ftp.close()
    ssh.close()

  ret = ""
  if type(file_names) is list:
    if len(file_names) > 0:
      ret = file_names[0]
  else:
    ret = file_names

  return ret

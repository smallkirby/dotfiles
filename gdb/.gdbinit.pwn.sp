set auto-load safe-path /
set disassembly-flavor intel
set print pretty on
set print elements 0
set history save off
define hook-kill
  set confirm off
end
define hook-quit
  set confirm off
end
#add-auto-load safe-path /home/wataru/linux-stable/scripts/gdb/vmlinux-gdb.py

source /home/wataru/pwndbg/gdbinit.py
source /home/wataru/splitmind/gdbinit.py

python
import splitmind
(splitmind.Mind()
  .tell_splitter(show_titles=True)
  .tell_splitter(set_title="Main")
  .above(of="main", display="disasm", size="60%", banner="top")
  .show("code", on="disasm", banner="none")
  .right(display="legend", size="45%")
  .show("regs", on="legend")
  .below(display="stack", size="35%")
  .right(of="main", cmd='tty; tail -f /dev/null', size="20%", clearing=False)
  .tell_splitter(set_title='Input / Output')
  .below(display="backtrace", size="50%")
  .right(of="main", cmd="python -q", size="20%")
  .tell_splitter(set_title='python')
).build(nobanner=True)
end

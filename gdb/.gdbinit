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

define conn
  target remote:1234
end

define ii
  x/10i 
end

define ir
  pipe -d DE info registers DE tail -n+1 2>/dev/null | head -n20
end

define hook-stop
  ir
  shell echo "-----------------------------------------------"
  x/10i $rip-0xd
end
  

#set tui border-kind ascii
#layout asm
#layout reg
#add-auto-load-safe-path /home/wataru/linux-stable/scripts/gdb/vmlinux-gdb.py


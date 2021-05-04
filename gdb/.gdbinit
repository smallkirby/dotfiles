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

define hook-stop
  shell echo -e '\033[0;36m++++++++++++++++++++++++++++++++++++++++++++++++++++\033[0m'
  pipe -d DE info registers DE tail -n+1 2>/dev/null | head -n20
  shell echo -e '\033[0;36m++++++++++++++++++++++++++++++++++++++++++++++++++++\033[0m'
  pipe -d DE x/20i $rip-0x20 DE grc tail -n+1 | grep ".*=>.*" --color=always -B2 -C0
  pipe -d DE x/20i $rip-0x20 DE grc tail -n+1 | grep "=>" -A7 | tail -n+2
  shell echo -e '\033[0;36m++++++++++++++++++++++++++++++++++++++++++++++++++++\033[0m'
  info line
  list
end

#set tui border-kind ascii
#layout asm
#layout reg
#add-auto-load-safe-path /home/wataru/linux-stable/scripts/gdb/vmlinux-gdb.py


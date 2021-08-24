#!/bin/python3
#encoding: utf-8;
#encoding: 2 spaces

import os, glob, re

EXT = "xml"
GPATH = "/usr/share/gnome-control-center/keybindings/"
RE = r'schema="([^\"]*)"'

dconfs = []
files = glob.glob("{}*.{}".format(GPATH, EXT))
print("Checking {} schemas.".format(len(files)))

for schema in files:
  with open(schema, mode="r") as f:
    lines = f.readlines()
    for l in lines:
      m = re.search(RE, l)
      if m != None:
        dconf = m.groups()[0]
        print("{} => {}".format(schema, dconf))
        if dconf not in dconfs:
          dconfs.append(dconf)
        break

print("")
print("Extracting {} files.".format(len(dconfs)))
for dconf in dconfs:
  p = "/" + dconf.replace(".", "/") + "/"
  print("{} => {}".format(p, dconf))
  os.system("dconf dump '{}' > {}".format(p, dconf))

print("")
print("DONE.")

# Gnome Terminal Preference  

Almost nomal setting.  
Color is based on gruvbox.  

## how to extract  
```
dconf dump /org/gnome/terminal/legacy/profiles:/ > ./org-gnome-terminal-legacy-profiles.dconf
```  

## how to import  
```
dconf load /org/gnome/terminal/legacy/profiles:/ < ./org-gnome-terminal-legacy-profiles.dconf
```

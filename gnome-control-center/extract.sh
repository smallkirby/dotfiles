#!/bin/bash

# Schema which describes how these dconf setting would be used is placed in /usr/share/gnome-control-center/

# shortcut for launchers, screenshots, sound and media, and system
dconf dump '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/' > custom-keybindings.dconf
# shortcut handled by window manager
dconf dump '/org/gnome/desktop/wm/keybindings/' > keybindings.dconf
# shortcut for power system
dconf dump '/org/gnome/settings-daemon/plugins/power/' > power.dconf
# shortcut for screenshots
dconf dump '/org/gnome/settings-daemon/plugins/media-keys/' > screenshots.dconf


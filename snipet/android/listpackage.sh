adb shell 'pm list packages -f' | sed -e 's/.*=//' | sort

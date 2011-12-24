#!/bin/bash
# Clean: General Files/Settings

# Change Default System Shell
if question --default yes "Do you want to change the default system shell? (Y/n)"; then
	subheader "Changing Default System Shell..."
	dpkg-reconfigure dash
fi

# Remove Unneeded Getty Instances
if question --default yes "Do you want to disable unneeded getty instances? (Y/n)"; then
	subheader "Disabling Unneeded Getty Instances..."
	sed -e 's/\(^[2-6].*getty.*\)/#\1/' -i /etc/inittab
fi

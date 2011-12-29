#!/bin/bash
# Clean: General Files/Settings

# Disable BASH History
if question --default yes "Do you want to disable BASH history? (Y/n)"; then
	subheader "Disabling BASH History..."
	echo -e "\nunset HISTFILE" >> /etc/profile
fi

# Disable Extra Getty Instances
if question --default yes "Do you want to disable extra getty instances? (Y/n)"; then
	subheader "Disabling Extra Getty Instances..."
	sed -e 's/\(^[2-6].*getty.*\)/#\1/' -i /etc/inittab
fi

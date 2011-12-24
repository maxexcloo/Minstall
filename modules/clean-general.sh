#!/bin/bash
# Clean: General Files/Settings

# Clean Bash History
if question --default yes "Do you want to disable Bash history? (Y/n)"; then
	subheader "Disabling Bash History..."
	echo -e "\nunset HISTFILE" >> /etc/profile
fi

# Disable Additional Getty Instances
if question --default yes "Do you want to disable additional getty instances? (Y/n)"; then
	subheader "Disabling Additional Getty Instances..."
	sed -e 's/\(^[2-6].*getty.*\)/#\1/' -i /etc/inittab
fi

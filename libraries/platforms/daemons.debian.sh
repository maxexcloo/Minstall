#!/bin/bash
# Functions For Handling Daemon Management In Debian Linux

# Add Daemon
function daemon_add() {
	update-rc.d $1 defaults
}

# Remove Daemon
function daemon_remove() {
	update-rc.d -f $1 remove
}

# Enable Daemon
function daemon_enable() {
	update-rc.d $1 enable
}

# Disable Daemon
function daemon_disable() {
	update-rc.d $1 disable
}

# Manage Daemon
function daemon_manage() {
	if [ -e /etc/init.d/$1 ]; then
		invoke-rc.d $1 $2
	else
		warning "Daemon Not Found, Skipping..."
	fi
}

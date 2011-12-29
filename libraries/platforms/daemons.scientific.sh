#!/bin/bash
# Functions For Handling Daemon Management In Scientific Linux

# Add Daemon
function daemon_add() {
	chkconfig --add $1
}

# Remove Daemon
function daemon_remove() {
	chkconfig --del $1
}

# Enable Daemon
function daemon_enable() {
	chkconfig $1 on
}

# Disable Daemon
function daemon_disable() {
	chkconfig $1 off
}

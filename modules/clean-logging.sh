#!/bin/bash
# Clean: Logging

# Check Package
if check_package_ni "inetutils-syslogd"; then
	# Print Warning
	warning "This module requires the inetutils-syslogd package to be installed, please install it and run this module again!"
	# Shift Variables
	shift
	# Continue Loop
	continue
fi

# Clean Logs
subheader "Cleaning Logs..."

# Stop Logging Daemon
daemon_manage inetutils-syslogd stop

# Remove Log Files
rm /var/log/* /var/log/*/* > /dev/null 2>&1
rm -rf /var/log/news > /dev/null 2>&1

# Create New Log Files
touch /var/log/{auth,daemon,kernel,mail,messages} > /dev/null 2>&1

# Configure Logging
subheader "Configuring Logging..."

# Copy Configuration
cp -r $MODULEPATH/$MODULE/* /etc/

# Start Logging Daemon
daemon_manage inetutils-syslogd start

#!/bin/bash
# Clean: Logging

# Check For inetutils-syslogd Package
check "inetutils-syslogd" "/etc/init.d/inetutils-syslogd"

# Clean Logs
subheader "Cleaning Logs..."

# Stop Logging Daemon
/etc/init.d/inetutils-syslogd stop

# Remove Log Files
rm /var/log/* /var/log/*/*
rm -rf /var/log/news

# Create New Log Files
touch /var/log/{auth,daemon,kernel,mail,messages}

# Configure Logging
subheader "Configuring Logging..."

# Copy Configuration
cp -r $MODULEPATH/$MODULE/* /etc/

# Start Logging Daemon
/etc/init.d/inetutils-syslogd start

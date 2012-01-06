#!/bin/bash
# HTTP Install: MySQL Database Server

# Package List Update Question
package_update_question

# Install Package
subheader "Installing Package..."
package_install mysql-server

# Check PHP
if [ -e /etc/init.d/php-fpm ]; then
	subheader "Found PHP! Installing PHP MySQL Package..."
	package_install php5-mysql
fi

# Restart Daemon
subheader "Stopping Daemon..."
invoke-rc.d mysql stop

# Copy Configuration
subheader "Copying Configuration..."
cp -r $MODULEPATH/$MODULE/* /etc/

# Restart Daemon
subheader "Starting Daemon..."
invoke-rc.d mysql start

# Package List Clean Question
package_clean_question

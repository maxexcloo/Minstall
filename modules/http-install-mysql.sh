#!/bin/bash
# HTTP Install: MySQL Database Server

# Common Functions
source $MODULEPATH/http-install-common.sh

# Package List Update Question
package_update_question

# Copying Configuration
subheader "Copying Configuration..."
mkdir -p /etc/mysql/conf.d/
cp -r $MODULEPATH/$MODULE/mysql/conf.d/* /etc/mysql/conf.d/

# Install Package
subheader "Installing Package..."
package_install mysql-server

# Check PHP
if check_package "php5-fpm"; then
	subheader "Installing PHP MySQL Package..."
	package_install php5-mysql
fi

# Stop Daemon
subheader "Stopping Daemon..."
daemon_manage mysql stop

# Copy Configuration
subheader "Copying Configuration..."
cp -r $MODULEPATH/$MODULE/* /etc/

# Start Daemon
subheader "Starting Daemon..."
daemon_manage mysql start

# Package List Clean Question
package_clean_question

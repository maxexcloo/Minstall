#!/bin/bash
# HTTP Install: PHP

# Package List Update Question
package_update_question

# Common Functions
source $MODULEPATH/http-install-common.sh

# Install Package
subheader "Installing Package..."
package_install php5-fpm

# Check MySQL
if check_package "mysql_server"; then
	subheader "Installing PHP MySQL Package..."
	package_install php5-mysql
fi

# Copy Configuration
subheader "Copying Configuration..."
cp -r $MODULEPATH/$MODULE/* /etc/

# Restart Daemon
subheader "Restarting Daemon..."
daemon_manage php-fpm start

# Package List Clean Question
package_clean_question

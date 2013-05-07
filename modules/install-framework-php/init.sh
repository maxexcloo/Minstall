#!/bin/bash
# Install (Framework): PHP

# Distribution Checks
check_repository_message "debian" "dotdeb" "DotDeb"

# Package List Update Question
package_update_question

# Install Package
subheader "Installing Package..."
package_install php5-fpm

# Check MariaDB/MySQL
if check_package "mariadb-server" || check_package "mysql-server"; then
	subheader "Installing PHP MySQL Package..."
	package_install php5-mysql
fi

# Copy Configuration
subheader "Copying Configuration..."
cp -r $MODULEPATH/$MODULE/etc/* /etc/php5/

# Clean Common Function
clean-common

# Restart Daemon
subheader "Restarting Daemon..."
daemon_manage php5-fpm restart

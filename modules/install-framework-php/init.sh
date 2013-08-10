#!/bin/bash
# Install (Framework): PHP

# Distribution Checks
check_repository_message "debian" "dotdeb" "DotDeb"

# Package List Update Question
package_update_question

# Install Package
subheader "Installing Package..."
package_install php5-cli php5-fpm

# Install Extras
subheader "Installing Extras..."
package_install php5-curl php5-gd php5-mcrypt php5-sqlite

# Check MariaDB/MySQL
if check_package "mariadb-server" || check_package "mysql-server"; then
	subheader "Installing PHP MySQL Package..."
	package_install php5-mysql
fi

# Check PostgreSQL
if check_package "postgresql-9.1"; then
	subheader "Installing PHP PostgreSQL Package..."
	package_install php5-pgsql
fi

# Copy Configuration
subheader "Copying Configuration..."
cp -r $MODULEPATH/$MODULE/etc/* /etc/php5/

# Clean Common
clean-common

# Restart Daemon
subheader "Restarting Daemon..."
daemon_manage php5-fpm restart

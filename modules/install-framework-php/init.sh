#!/bin/bash
# Install (Framework): PHP

# Package List Update Question
package_update_question

# Install HTTP Common Functions
module-install-http-common

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
rm /etc/php5/fpm/pool.d/www.conf &> /dev/null
cp -r $MODULEPATH/$MODULE/php5/* /etc/php5/

# Restart Daemon
subheader "Restarting Daemon..."
daemon_manage php5-fpm restart

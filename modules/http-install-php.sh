#!/bin/bash
# HTTP Install: PHP Application Server

# Package List Update Question
package_update_question

# Common Functions
source $MODULEPATH/http-install-common.sh

# Install Package
subheader "Installing Package..."
package_install php5-fpm

# Check MySQL
if check_package "mysql-server"; then
	subheader "Installing PHP MySQL Package..."
	package_install php5-mysql
fi

# Copy Configuration
subheader "Copying Configuration..."
rm /etc/php5/fpm/pool.d/www.conf
cp -r $MODULEPATH/$MODULE/* /etc/

# Check Package
if check_package "nginx"; then
	subheader "Enabling PHP Configuration..."
	sed -i "s/\o011#include \/etc\/nginx\/php.d/\o011include \/etc\/nginx\/php.d/g" /etc/nginx/hosts.d/www-data{.conf,-ssl*}
	subheader "Restarting Daemons..."
	daemon_manage nginx restart
	daemon_manage php5-fpm restart
fi

# Restart Daemon
subheader "Restarting Daemon..."
daemon_manage php5-fpm restart

# Package List Clean Question
package_clean_question

#!/bin/bash
# HTTP Install: PHP Application Server

# Common Functions
source $MODULEPATH/http-install-common.sh

# Package List Update Question
package_update_question

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
rm /etc/php5/fpm/pool.d/www.conf
cp -r $MODULEPATH/$MODULE/* /etc/

# Check Package
if check_package "nginx"; then
	subheader "Enabling nginx PHP Configuration..."
	sed -i 's/#include \/etc\/nginx\/php.d/include \/etc\/nginx\/php.d/g' /etc/nginx/hosts.d/www-data.conf
	subheader "Restarting Daemon (nginx)..."
	daemon_manage nginx restart
fi

# Restart Daemon
subheader "Restarting Daemon..."
daemon_manage php-fpm5 start

# Package List Clean Question
package_clean_question

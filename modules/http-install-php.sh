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
rm -rf /etc/php5/fpm/pool.d/* > /dev/null 2>&1
cp -r $MODULEPATH/$MODULE/* /etc/

# Check Nginx
if check_package "nginx"; then
	subheader "Enabling Nginx PHP Configuration..."
	sed -i 's/#include \/etc\/nginx\/php.d/include \/etc\/nginx\/php.d/g' /etc/nginx/hosts.d/www-data.conf
fi

# Restart Daemon
subheader "Restarting Daemon..."
daemon_manage php-fpm start

# Package List Clean Question
package_clean_question

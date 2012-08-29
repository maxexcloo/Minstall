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
if check_package "mysql-server"; then
	subheader "Installing PHP MySQL Package..."
	package_install php5-mysql
fi

# Copy Configuration
subheader "Copying Configuration..."
rm /etc/php5/fpm/pool.d/www.conf
cp -r $MODULEPATH/$MODULE/php5/fpm/* /etc/php5/fpm/

# Check PHP Suhosin
if check_package "php5-suhosin"; then
	cp -r $MODULEPATH/$MODULE/php5/conf.d/suhosin.ini /etc/php5/conf.d/
fi

# Restart Daemon
subheader "Restarting Daemon..."
daemon_manage php5-fpm restart

# Package List Clean Question
package_clean_question

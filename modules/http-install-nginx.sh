#!/bin/bash
# HTTP Install: nginx Web Server

# Common Functions
source $MODULEPATH/http-install-common.sh

# Package List Update Question
package_update_question

# Install Package
subheader "Installing Package..."
package_install nginx

# Remove System Sites
subheader "Removing System Sites..."
rm -rf /etc/nginx/sites-* > /dev/null 2>&1

# Copy Configuration
subheader "Copying Configuration..."
cp -r $MODULEPATH/$MODULE/* /etc/

# Move System Configuration
subheader "Moving System Configuration..."
mv /etc/nginx/mime.types /etc/nginx/nginx.d/mime.conf > /dev/null 2>&1

# Update Permissions
subheader "Updating Permissions..."
mkdir -p /var/lib/nginx/cache
chown -r www-data:www-data /var/lib/nginx/cache

# Check PHP
if check_package "php5-fpm"; then
	subheader "Enabling PHP Configuration..."
	sed -i "s/#include \/etc\/nginx\/php.d/include \/etc\/nginx\/php.d/g" /etc/nginx/hosts.d/www-data.conf
	subheader "Restarting Daemon (PHP-FPM)..."
	daemon_manage php5-fpm restart
fi

# Restart Daemon
subheader "Restarting Daemon..."
daemon_manage nginx restart

# Package List Clean Question
package_clean_question

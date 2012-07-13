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

# Create Caching Directory
subheader "Creating Caching Directory..."
mkdir -p /var/lib/nginx/cache
chown -R www-data:www-data /var/lib/nginx/cache
chmod -R o= /var/lib/nginx/cache

# Create Self Signed SSL Certificate
subheader "Creating Self Signed SSL Certificate..."
mkdir -p /etc/ssl/http
openssl req -new -days 3650 -newkey rsa:2048 -nodes -x509 -subj "/C=/ST=/L=/O=/CN=$(hostname -f)" -out /etc/ssl/http/self.pem -keyout /etc/ssl/http/self.key
chown -R www-data:www-data /etc/ssl/http
chmod -R o= /etc/ssl/http

# Check Package
if check_package "php5-fpm"; then
	subheader "Enabling PHP Configuration..."
	sed -i "s/\o011#include \/etc\/nginx\/php.d/\o011include \/etc\/nginx\/php.d/g" /etc/nginx/hosts.d/www-data{.conf,-ssl*}
	subheader "Restarting Daemons..."
	daemon_manage nginx restart
	daemon_manage php5-fpm restart
fi

# Restart Daemon
subheader "Restarting Daemon..."
daemon_manage nginx restart

# Package List Clean Question
package_clean_question

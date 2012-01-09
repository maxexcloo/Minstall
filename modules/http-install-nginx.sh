#!/bin/bash
# HTTP Install: Nginx Web Server

# Common Functions
source $MODULEPATH/http-install-common.sh

# Package List Update Question
package_update_question

# Install Package
subheader "Installing Package..."
package_install nginx

# Remove System Sites
subheader "Removing System Sites..."
echo -n "" > /usr/share/nginx/www/index.html > /dev/null 2>&1
rm -rf /etc/nginx/conf.d/* /etc/nginx/sites-* > /dev/null 2>&1

# Move System Configuration
subheader "Moving System Configuration..."
mv /etc/nginx/mime.types /etc/nginx/nginx.d/mime.conf

# Copy Configuration
subheader "Copying Configuration..."
cp -r $MODULEPATH/$MODULE/* /etc/

# Restart Daemon
subheader "Restarting Daemon..."
daemon_manage nginx restart

# Package List Clean Question
package_clean_question

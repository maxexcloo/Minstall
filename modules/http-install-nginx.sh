#!/bin/bash
# HTTP Install: nginx Web Server

# HTTP Install Common Functions
module-http-install-common

# Package List Update Question
package_update_question

# Check OpenSSL
if ! check_package "openss;"; then
	subheader "Installing OpenSSL..."
	package_install openssl
fi

# Install Package
subheader "Installing Package..."
package_install nginx

# Remove System Sites
subheader "Removing System Sites..."
rm -rf /etc/nginx/sites-* &> /dev/null

# Copy Configuration
subheader "Copying Configuration..."
cp -r $MODULEPATH/$MODULE/nginx/* /etc/nginx/

# Move System Configuration
subheader "Moving System Configuration..."
mv /etc/nginx/mime.types /etc/nginx/nginx.d/mime.conf &> /dev/null

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

# Set Default Host Root
if [ $DISTRIBUTION = "debian" ]; then
	sed -i "s/root path/root \/usr\/share\/nginx\/html/g" /etc/nginx/hosts.d/default*
elif [ $DISTRIBUTION = "ubuntu" ]; then
	sed -i "s/root path/root \/usr\/share\/nginx\/www/g" /etc/nginx/hosts.d/default*
fi

# Restart Daemon
subheader "Restarting Daemon..."
daemon_manage nginx restart

# Package List Clean Question
package_clean_question

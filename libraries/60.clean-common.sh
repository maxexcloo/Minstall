#!/bin/bash
# Common Functions For Module Category: Clean

# Module Functions
function module-clean-common() {
	# Check Package
	if check_package "nginx"; then
		# Remove Default Sites
		rm -rf /etc/nginx/sites-* &> /dev/null

		# Create PHP Directories
		mkdir -p /etc/php5/fpm/pool.d &> /dev/null

		# Remove Default PHP Pool
		rm /etc/php5/fpm/pool.d/www.conf &> /dev/null

		# Copy Nginx Configuration
		cp -f $MODULEPATH/install-http-nginx/etc/* /etc/nginx/ &> /dev/null
		cp -rf $MODULEPATH/install-http-nginx/etc/conf.d/* /etc/nginx/conf.d/ &> /dev/null
		
		# Move Nginx Mime Types
		mv -f /etc/nginx/mime.types /etc/nginx/nginx.d/mime.conf &> /dev/null
	fi
}

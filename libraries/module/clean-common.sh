#!/bin/bash
# Common Functions For Module Category: Clean

# Module Functions
function clean-common() {
	# Check Package
	if check_package "nginx"; then
		# Create PHP Directories
		mkdir -p /etc/php5/fpm/pool.d &> /dev/null

		# Copy Nginx Configuration
		cp -f $MODULEPATH/install-http-nginx/etc/* /etc/nginx/ &> /dev/null
		cp -rf $MODULEPATH/install-http-nginx/etc/conf.d/* /etc/nginx/conf.d/ &> /dev/null
		mv -f /etc/nginx/mime.types /etc/nginx/nginx.d/mime.conf &> /dev/null
	fi

	# Remove Nginx Default Sites
	rm -rf /etc/nginx/sites-* &> /dev/null

	# Remove PHP Default Pool
	rm /etc/php5/fpm/pool.d/www.conf &> /dev/null
}

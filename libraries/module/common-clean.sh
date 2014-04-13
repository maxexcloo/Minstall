#!/bin/bash
# Common Functions For Module Category: Clean

# Module Functions
common-clean() {
	# Check Package
	if check_package "nginx"; then
		# Create PHP Directories
		mkdir -p /etc/php5/fpm/pool.d &> /dev/null

		# Copy Nginx Configuration
		cp -f $MODULEPATH/install-http-nginx/etc/nginx/* /etc/nginx/ &> /dev/null
		cp -f $MODULEPATH/install-http-nginx/etc/nginx/conf.d/* /etc/nginx/conf.d/ &> /dev/null
		mv -f /etc/nginx/mime.types /etc/nginx/nginx.d/mime.conf &> /dev/null
	fi

	# Remove PHP Default Pool
	rm /etc/php5/fpm/pool.d/www.conf &> /dev/null
}

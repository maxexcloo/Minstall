#!/bin/bash
# Common Functions For Module Category: Clean

# Module Functions
function module-clean-common() {
	# Check Package
	if check_package "nginx"; then
		# CentOS Specific Tests
		if [ $DISTRIBUTION = "centos" ]; then
			# Remove Default Files
			rm -rf /etc/nginx/*.default

			# Remove Default Sites
			rm -rf /etc/nginx/conf.d/*

			# Create PHP Directories
			mkdir -p /etc/php-fpm.d &> /dev/null

			# Remove Default PHP Pool
			rm /etc/php-fpm.d/www.conf &> /dev/null
		# Debian/Ubuntu Specific Tests
		else
			# Remove Default Sites
			rm -rf /etc/nginx/sites-* &> /dev/null

			# Create PHP Directories
			mkdir -p /etc/php5/fpm/pool.d &> /dev/null

			# Remove Default PHP Pool
			rm /etc/php5/fpm/pool.d/www.conf &> /dev/null
		fi

		# General Tasks
		cp -f $MODULEPATH/install-http-nginx/nginx/* /etc/nginx/ &> /dev/null
		cp -rf $MODULEPATH/install-http-nginx/nginx/conf.d/* /etc/nginx/conf.d/ &> /dev/null
		mv -f /etc/nginx/mime.types /etc/nginx/nginx.d/mime.conf &> /dev/null
	fi
}

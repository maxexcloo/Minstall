#!/bin/bash
# HTTP Configure: nginx Web Server

# Check Package
if check_package_ni "nginx"; then
	# Print Warning
	warning "This module requires the nginx package to be installed, please install it and run this module again!"
	# Shift Variables
	shift
	# Continue Loop
	continue
fi

# Enable Caching
if question --default yes "Do you want to enable a caching directory? (Y/n)" || [ $(read_var_module cache) = 1 ]; then
	subheader "Adding Configuration..."
	cp -r $MODULEPATH/$MODULE/nginx/nginx.d/cache.conf /etc/nginx/nginx.d/
	mkdir -p /var/lib/nginx/cache
	chown -r www-data:www-data /var/lib/nginx/cache
# Disable Caching
else
	subheader "Removing Configuration..."
	rm /etc/nginx/nginx.d/cache.conf > /dev/null 2>&1
	rm -rf /var/lib/nginx/cache > /dev/null 2>&1
fi

# Enable Compression
if question --default yes "Do you want to enable gzip compression? (Y/n)" || [ $(read_var_module gzip) = 1 ]; then
	subheader "Adding Configuration..."
	cp -r $MODULEPATH/$MODULE/nginx/nginx.d/gzip.conf /etc/nginx/nginx.d/
# Disable Compression
else
	subheader "Removing Configuration..."
	rm /etc/nginx/nginx.d/gzip.conf > /dev/null 2>&1
fi

# Enable Optimised Configuration
if question --default yes "Do you want to enable optimised configurations? (Y/n)" || [ $(read_var_module optimise ) = 1]; then
	subheader "Adding Configuration..."
	cp -r $MODULEPATH/$MODULE/nginx/nginx.d/speed.conf /etc/nginx/nginx.d/
# Disable Optimised Configuration
else
	subheader "Removing Configuration..."
	rm /etc/nginx/nginx.d/speed.conf > /dev/null 2>&1
fi

# Restart Daemon
subheader "Restarting Daemon..."
daemon_manage nginx restart

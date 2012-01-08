#!/bin/bash
# HTTP Configure: Nginx Web Server

# Check Package
if check_package_ni "nginx"; then
	# Print Warning
	warning "This module requires the nginx package to be installed, please install it and run this module again!"
	# Continue Loop
	continue
fi

# Enable Compression
if question --default yes "Do you want to enable gzip compression? (Y/n)"; then
	subheader "Adding Configuration..."
	cp -r $MODULEPATH/$MODULE/nginx/nginx.d/gzip.conf /etc/nginx/nginx.d/
# Configure MySQL For Normal Memory Usage
else
	subheader "Removing Configuration..."
	rm /etc/nginx/nginx.d/gzip.conf
fi

# Enable Optimised Configuration
if question --default yes "Do you want to enable optimised configurations? (Y/n)"; then
	subheader "Adding Configuration..."
	cp -r $MODULEPATH/$MODULE/nginx/nginx.d/speed.conf /etc/nginx/nginx.d/
# Disable Optimised Configuration
else
	subheader "Removing Configuration..."
	rm /etc/nginx/nginx.d/speed.conf
fi

# Restart Daemon
subheader "Restarting Daemon..."
daemon_manage nginx restart

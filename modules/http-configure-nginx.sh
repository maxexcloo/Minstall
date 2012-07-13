#!/bin/bash
# HTTP Configure: nginx Web Server

# Check Package
if ! check_package "nginx"; then
	# Print Warning
	warning "This module requires the nginx package to be installed, please install it and run this module again!"
	# Continue Loop
	continue
fi

# Enable Caching
if question --default yes "Do you want to enable a caching directory? (Y/n)" || [ $(read_var_module cache) = 1 ]; then
	subheader "Enabling Caching..."
	cp -r $MODULEPATH/$MODULE/nginx/nginx.d/cache.conf /etc/nginx/nginx.d/
	mkdir -p /var/lib/nginx/cache
	chown -R www-data:www-data /var/lib/nginx/cache
# Disable Caching
else
	subheader "Disabling Caching..."
	rm /etc/nginx/nginx.d/cache.conf > /dev/null 2>&1
	rm -rf /var/lib/nginx/cache > /dev/null 2>&1
fi

# Enable Compression
if question --default yes "Do you want to enable gzip compression? (Y/n)" || [ $(read_var_module gzip) = 1 ]; then
	subheader "Enabling Compression..."
	cp -r $MODULEPATH/$MODULE/nginx/nginx.d/gzip.conf /etc/nginx/nginx.d/
# Disable Compression
else
	subheader "Disabling Compression..."
	rm /etc/nginx/nginx.d/gzip.conf > /dev/null 2>&1
fi

# Enable Miscellaneous Speed Tweaks
if question --default yes "Do you want to enable miscellaneous speed tweaks? (Y/n)" || [ $(read_var_module misc) = 1 ]; then
	subheader "Enabling Miscellaneous Speed Tweaks..."
	cp -r $MODULEPATH/$MODULE/nginx/nginx.d/misc.conf /etc/nginx/nginx.d/
# Disable Miscellaneous Speed Tweaks
else
	subheader "Disabling Miscellaneous Speed Tweaks..."
	rm /etc/nginx/nginx.d/misc.conf > /dev/null 2>&1
fi

# Protect Default Host
if question --default no "Do you want to protect the default host (this will override your default virtual host if you have assigned one)? (y/N)" || [ $(read_var_module protect) = 1 ]; then
	subheader "Protecting Default Host..."
	cp $MODULEPATH/$MODULE/nginx/hosts.d/*.conf /etc/nginx/hosts.d/
fi

# Enable SSL Session Tweaks
if question --default yes "Do you want to enable SSL session tweaks? (Y/n)" || [ $(read_var_module ssl) = 1 ]; then
	subheader "Enabling SSL Session Tweaks..."
	cp -r $MODULEPATH/$MODULE/nginx/nginx.d/ssl.conf /etc/nginx/nginx.d/
# Disable SSL Session Tweaks
else
	subheader "Disabling SSL Session Tweaks..."
	rm /etc/nginx/nginx.d/ssl.conf > /dev/null 2>&1
fi

# Restart Daemon
subheader "Restarting Daemon..."
daemon_manage nginx restart

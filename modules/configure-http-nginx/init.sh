#!/bin/bash
# Configure (HTTP): nginx Web Server

# Check Package
if ! check_package "nginx"; then
	# Print Warning
	warning "This module requires the nginx package to be installed, please install it using the http-install-nginx module and try again!"

	# Continue Loop
	continue
fi

# Enable Cache
if question --default yes "Do you want to enable cache support and create a cache directory? (Y/n)" || [ $(read_var_module cache) = 1 ]; then
	subheader "Enabling Cache Support..."
	cp -r $MODULEPATH/install-http-nginx/nginx/nginx.d/cache.conf /etc/nginx/nginx.d/
	mkdir -p /var/lib/nginx/cache
	chown -R www-data:www-data /var/lib/nginx/cache
# Disable Cache
else
	subheader "Disabling Cache Support..."
	rm /etc/nginx/nginx.d/cache.conf &> /dev/null
	rm -rf /var/lib/nginx/cache &> /dev/null
fi

# Enable Caching SSL Sessions
if question --default yes "Do you want to enable caching of SSL sessions (can increase responsiveness over SSL)? (Y/n)" || [ $(read_var_module cache_ssl) = 1 ]; then
	subheader "Enabling SSL Session Caching..."
	cp -r $MODULEPATH/install-http-nginx/nginx/nginx.d/cache_ssl.conf /etc/nginx/nginx.d/
# Disable Caching SSL Sessions
else
	subheader "Disabling SSL Session Caching..."
	rm /etc/nginx/nginx.d/cache_ssl.conf &> /dev/null
fi

# Enable Compression
if question --default yes "Do you want to enable gzip compression to save bandwidth and decrease page load time (compresses CSS, HTML, Javascript & XML at gzip compression level 6)? (Y/n)" || [ $(read_var_module gzip) = 1 ]; then
	subheader "Enabling Compression..."
	cp -r $MODULEPATH/install-http-nginx/nginx/nginx.d/gzip.conf /etc/nginx/nginx.d/
# Disable Compression
else
	subheader "Disabling Compression..."
	rm /etc/nginx/nginx.d/gzip.conf &> /dev/null
fi

# Enable Virtual Host For Hostname
if question --default yes "Do you want to enable a virtual host that accepts all requests for the servers hostname (can be useful for scripts such as bandwidth monitors or web administration)? (Y/n)" || [ $(read_var_module hostname_virtual_host) = 1 ]; then
	subheader "Enabling Virtual Host For Hostname..."
	mv /etc/nginx/hosts.d/system.conf.disabled /etc/nginx/hosts.d/system.conf
# Disable Virtual Host For Hostname
else
	subheader "Disabling Virtual Host For Hostname..."
	mv /etc/nginx/hosts.d/system.conf /etc/nginx/hosts.d/system.conf.disabled
fi

# Enable Default Host Protection
if question --default no "Do you want to protect the default host by denying unmatched requests (this will override your default virtual host if you have assigned one)? (y/N)" || [ $(read_var_module protect_default) = 1 ]; then
	subheader "Enabling Default Host Protection..."
	cp $MODULEPATH/$MODULE/nginx/hosts.d/default.conf /etc/nginx/hosts.d/
# Disable Default Host Protection
else
	# Default Host Reset
	if question --default no "Do you want to reset the default host to the script default  (this will override your default virtual host if you have assigned one)? (y/N)" || [ $(read_var_module default_host_reset) = 1 ]; then
		subheader "Resetting Default Host..."
		cp $MODULEPATH/install-http-nginx/nginx/hosts.d/default.conf /etc/nginx/hosts.d/
	fi
fi

# Restart Daemon
subheader "Restarting Daemon..."
daemon_manage nginx restart

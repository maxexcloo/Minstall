#!/bin/bash
# Configure (HTTP): Nginx

# Check Package
check_package_message "" "nginx" "install-http-nginx"

# Enable Compression
if question --default yes "Do you want to enable gzip compression to save bandwidth and decrease page load time (compresses CSS, HTML, Javascript & XML at gzip compression level 6)? (Y/n)" || [ $(read_variable_module gzip) = 1 ]; then
	subheader "Enabling Compression..."
	cp -r $MODULEPATH/install-http-nginx/etc/nginx.d/gzip.conf /etc/nginx/nginx.d/
# Disable Compression
else
	subheader "Disabling Compression..."
	rm /etc/nginx/nginx.d/gzip.conf &> /dev/null
fi

# Enable Virtual Host For Hostname
if question --default yes "Do you want to enable a virtual host that accepts all requests for the servers hostname (can be useful for scripts such as bandwidth monitors)? (Y/n)" || [ $(read_variable_module hostname_virtual_host) = 1 ]; then
	subheader "Enabling Virtual Host For Hostname..."
	mv /etc/nginx/sites-available/system.conf.disabled /etc/nginx/sites-available/system.conf
# Disable Virtual Host For Hostname
else
	subheader "Disabling Virtual Host For Hostname..."
	mv /etc/nginx/sites-available/system.conf /etc/nginx/sites-available/system.conf.disabled
fi

# Enable Proxy Cache
if question --default yes "Do you want to enable proxy cache support and create a cache directory? (Y/n)" || [ $(read_variable_module proxy_cache) = 1 ]; then
	subheader "Enabling Proxy Cache Support..."
	cp -r $MODULEPATH/install-http-nginx/etc/nginx.d/proxy_cache.conf /etc/nginx/nginx.d/
	mkdir -p /var/lib/nginx/cache
	chown -R www-data:www-data /var/lib/nginx/cache
# Disable Proxy Cache
else
	subheader "Disabling Proxy Cache Support..."
	rm /etc/nginx/nginx.d/proxy_cache.conf &> /dev/null
	rm -rf /var/lib/nginx/cache &> /dev/null
fi

# Enable SSL Session Cache
if question --default yes "Do you want to enable caching of SSL sessions (can increase responsiveness over SSL)? (Y/n)" || [ $(read_variable_module ssl_session_cache) = 1 ]; then
	subheader "Enabling SSL Session Cache..."
	cp -r $MODULEPATH/install-http-nginx/etc/nginx.d/ssl_session_cache.conf /etc/nginx/nginx.d/
# Disable SSL Session Cache
else
	subheader "Disabling SSL Session Cache..."
	rm /etc/nginx/nginx.d/ssl_session_cache.conf &> /dev/null
fi

# Enable Default Host Protection
if question --default no "Do you want to protect the default host by denying unmatched requests (this will override your default virtual host if you have assigned one)? (y/N)" || [ $(read_variable_module protect_default) = 1 ]; then
	subheader "Enabling Default Host Protection..."
	cp $MODULEPATH/$MODULE/nginx/sites-available/default.conf /etc/nginx/sites-available/
# Disable Default Host Protection
else
	# Default Host Reset
	if question --default no "Do you want to reset the default host to the script default (this will override your default virtual host if you have assigned one)? (y/N)" || [ $(read_variable_module default_host_reset) = 1 ]; then
		subheader "Resetting Default Host..."
		cp $MODULEPATH/install-http-nginx/etc/sites-available/default.conf /etc/nginx/sites-available/
	fi
fi

# Restart Daemon
subheader "Restarting Daemon..."
daemon_manage nginx restart

#!/bin/bash
# Clean: Common (Called Automatically, Do Not Run Manually!)

# Check Package
if check_package "nginx"; then
	# Create PHP Directories
	mkdir -p /etc/php5/fpm/pool.d &> /dev/null

	# Update HTTP Config
	cp -rf $MODULEPATH/http-install-nginx/nginx/{*.conf,fastcgi_params} /etc/nginx/ &> /dev/null
	cp -rf $MODULEPATH/http-install-nginx/nginx/conf.d/*.conf /etc/nginx/conf.d/ &> /dev/null
	mv -f /etc/nginx/mime.types /etc/nginx/nginx.d/mime.conf &> /dev/null
	rm -rf /etc/nginx/sites-* &> /dev/null
fi

# Check Package
if check_package "php5-fpm"; then
	# Update PHP Config
	cp -rf $MODULEPATH/http-install-php/php5/fpm/*.conf /etc/php5/fpm/ &> /dev/null
	rm /etc/php5/fpm/pool.d/www.conf &> /dev/null
fi

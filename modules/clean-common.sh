#!/bin/bash
# Clean: Common

# Check Package
if check_package "nginx"; then
	# Create PHP Directories
	mkdir -p /etc/php5/fpm/pool.d > /dev/null 2>&1

	# Update HTTP Config
	cp -rf $MODULEPATH/http-install-nginx/nginx/{*.conf,fastcgi_params} /etc/nginx/ > /dev/null 2>&1
	cp -rf $MODULEPATH/http-install-nginx/nginx/conf.d/* /etc/nginx/conf.d/ > /dev/null 2>&1
	mv -f /etc/nginx/mime.types /etc/nginx/nginx.d/mime.conf > /dev/null 2>&1
	rm -rf /etc/nginx/sites-* > /dev/null 2>&1
fi

# Check Package
if check_package "php5-fpm"; then
	# Update PHP Config
	cp -rf $MODULEPATH/http-install-php/php5/fpm/*.conf /etc/php5/fpm/ > /dev/null 2>&1
	cp -rf $MODULEPATH/http-install-php/php5/fpm/conf.d/* /etc/php5/fpm/conf.d/ > /dev/null 2>&1
	rm -rf /etc/php5/fpm/pool.d/www.conf > /dev/null 2>&1
fi

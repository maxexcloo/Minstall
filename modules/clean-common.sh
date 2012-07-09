#!/bin/bash
# Clean: Common

# Clean HTTP Config
rm -rf /etc/nginx/sites-* /etc/php5/fpm/pool.d/www.* > /dev/null 2>&1

# Update HTTP Config
cp $MODULEPATH/http-install-nginx/nginx/* /etc/nginx/ > /dev/null 2>&1
cp $MODULEPATH/http-install-nginx/nginx/conf.d/* /etc/nginx/conf.d/ > /dev/null 2>&1
cp $MODULEPATH/http-install-php/php5/fpm/* /etc/php5/fpm/ > /dev/null 2>&1
cp $MODULEPATH/http-install-php/php5/fpm/conf.d/* /etc/php5/fpm/conf.d/ > /dev/null 2>&1
mv /etc/nginx/mime.types /etc/nginx/nginx.d/mime.conf > /dev/null 2>&1

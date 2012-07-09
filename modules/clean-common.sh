#!/bin/bash
# Clean: Common

# Clean HTTP Config
mv /etc/nginx/mime.types /etc/nginx/nginx.d/mime.conf > /dev/null 2>&1
rm -rf /etc/nginx/sites-* /etc/php5/fpm/pool.d/www.* > /dev/null 2>&1

#!/bin/bash
# Manage: Remove System Virtual Host

# Check Package
if check_package_ni "nginx"; then
	# Print Warning
	warning "This module requires the nginx package to be installed, please install it and run this module again!"
	# Shift Variables
	shift
	# Continue Loop
	continue
fi

# Confirmation Question
if question --default yes "Are you sure you want to remove the system virtual host? (Y/n)"; then
	subheader "Removing Files..."
	rm /etc/nginx/hosts.d/www-data.conf
	rm /etc/nginx/php.d/www-data.conf
	rm /etc/php5/fpm/pool.d/www-data.conf
else
	# Shift Variables
	shift
	# Continue Loop
	continue
fi

# Check Package
if check_package "php5-fpm"; then
	subheader "Restarting Daemon (PHP-FPM)..."
	daemon_manage php5-fpm restart
fi

# Check Package
if check_package "nginx"; then
	subheader "Restarting Daemon (nginx)..."
	daemon_manage nginx restart
fi

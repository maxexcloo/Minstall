#!/bin/bash
# Manage: Manage Virtual Host

# Check Package
if check_package_ni "nginx"; then
	# Print Warning
	warning "This module requires the nginx package to be installed, please install it and run this module again!"
	# Shift Variables
	shift
	# Continue Loop
	continue
fi

# User Check Loop
while true; do
	# Take User Input
	read -p "Please enter a user name: " USERNAME
	# Check If User Directory Exists
	if [ -d /home/$USERNAME ]; then
		break
	else
		echo "Please enter a valid username."
	fi
done

# Host Check Loop
while true; do
	# Take Host Input
	read -p "Please enter the virtual host (e.g. www.example.com): " HOST
	# Check If User Directory Exists
	if [[ $HOST = *.*.* ]]; then
		break
	else
		echo "Please enter a valid virtual host."
	fi
done

# Check Host
subheader "Checking Host..."
if [[ $HOST = www.*.* ]]; then
	HOST_DIR=$(echo $HOST | sed 's/....\(.*\)/\1/')
	HOST_WWW=1
else
	HOST_DIR=$HOST
	HOST_WWW=0
fi

# Check Directory
if [ ! -f /etc/nginx/hosts.d/$USERNAME-$HOST_DIR.conf ]; then
	# Print Warning
	warning "The virtual host configuration file does not exist (/etc/nginx/hosts.d/$USERNAME-$HOST_DIR.conf), run this module again and re-enter the information!"
	# Shift Variables
	shift
	# Continue Loop
	continue
fi

# Check Package
if check_package "php5-fpm"; then
	# PHP Question
	if question --default yes "Do you want to enable PHP for this virtual host? (Y/n)"; then
		subheader "Enabling PHP..."
		sed -i 's/\o011#include \/etc\/nginx\/php.d/\o011include \/etc\/nginx\/php.d/g' /etc/nginx/hosts.d/$USERNAME-$HOST_DIR.conf
	else
		subheader "Disabling PHP..."
		sed -i 's/\o011include \/etc\/nginx\/php.d/\o011#include \/etc\/nginx\/php.d/g' /etc/nginx/hosts.d/$USERNAME-$HOST_DIR.conf
	fi
else
	sed -i 's/include \/etc\/nginx\/php.d/#include \/etc\/nginx\/php.d/g' /etc/nginx/hosts.d/$USERNAME-$HOST_DIR.conf
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

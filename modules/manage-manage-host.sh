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
	if [ -d ~$USERNAME ]; then
		break
	else
		echo "Please enter a valid username."
	fi
done

# Check Folders
if [ ! -d ~$USERNAME/http ]; then
	# User HTTP Folder Question
	if question --default yes "Do you want to add a HTTP folder for this user (if you have already done this you don't need to do it again)? (Y/n)"; then
		subheader "Adding HTTP Folder..."
		mkdir -p ~$USERNAME/http/{common,hosts,logs,private}
		subheader "Changing HTTP Permissions..."
		chown -R $USERNAME:$USERNAME ~$USERNAME/http
		subheader "Adding User To HTTP Group..."
		useradd -G www-data $USERNAME
	fi
fi

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
	HOST_DIR=$(echo $HOST | sed 's/...\(.*\)/\1/')
	HOST_WWW=1
else
	HOST_DIR=$HOST
	HOST_WWW=0
fi

# Check Package
if check_package "php-fpm"; then
	# PHP Question
	if question --default yes "Do you want to enable PHP for this virtual host? (Y/n)"; then
		subheader "Enabling PHP..."
		sed -i 's/#include \/etc\/nginx\/php.d/include \/etc\/nginx\/php.d/g' /etc/nginx/hosts.d/$USERNAME-$HOST_DIR.conf
	else
		subheader "Disabling PHP..."
		sed -i 's/include \/etc\/nginx\/php.d/#include \/etc\/nginx\/php.d/g' /etc/nginx/hosts.d/$USERNAME-$HOST_DIR.conf
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

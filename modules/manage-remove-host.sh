#!/bin/bash
# Manage: Remove Virtual Host

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
	if [[ $HOST = *.* ]]; then
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

# Confirmation Question
if question --default yes "Are you sure you want to remove this virtual host? (Y/n)"; then
	subheader "Removing Files..."
	rm /home/$USERNAME/http/logs/$HOST_DIR.log
	rm /etc/nginx/hosts.d/$USERNAME-$HOST_DIR.conf
	if ! ls /etc/nginx/hosts.d/$USERNAME-*.conf > /dev/null 2>&1; then
		rm /etc/nginx/php.d/$USERNAME.conf
		rm /etc/php5/fpm/pool.d/$USERNAME.conf
	fi
else
	# Shift Variables
	shift
	# Continue Loop
	continue
fi

# Confirmation Question
if question --default yes "Do you want to delete the virtual host directory? (Y/n)"; then
	subheader "Removing Files..."
	rm -rf /home/$USERNAME/http/hosts/$HOST_DIR/
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

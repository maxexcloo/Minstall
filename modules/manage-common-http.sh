#!/bin/bash
# Manage: Common HTTP Functions

# Check Package
if ! check_package "nginx"; then
	# Print Warning
	warning "This module requires the nginx package to be installed, please install it and run this module again!"
	# Shift Variables
	shift
	# Continue Loop
	continue
fi

# Run Clean Common Module
source $MODULEPATH/clean-common.sh

#################
## Check Loops ##
#################

# Host Check Loop
manage-http-check-host-loop() {
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
}

# User Check Loop
manage-http-check-user-loop() {
	while true; do
		# Take User Input
		read -p "Please enter a user name: " USER
		# Check If User Directory Exists
		if [ -d /home/$USER ]; then
			break
		else
			echo "Please enter a valid username."
		fi
	done
}

#####################
## Check Functions ##
#####################

# Check Directory
manage-http-check-directory() {
	if [ ! -f /etc/nginx/hosts.d/$USER-$HOST_DIR.conf ]; then
		# Print Warning
		warning "The virtual host configuration file does not exist (/etc/nginx/hosts.d/$USER-$HOST_DIR.conf), run this module again and re-enter the information!"
		# Shift Variables
		shift
		# Continue Loop
		continue
	fi
}

# Check Host
manage-http-check-host() {
	subheader "Checking Host..."
	if [[ $HOST = www.*.* ]]; then
		HOST_DIR=$(echo $HOST | sed "s/....\(.*\)/\1/")
		HOST_WWW=1
	else
		HOST_DIR=$HOST
		HOST_WWW=0
	fi
}

#####################
## Setup Functions ##
#####################

# Create Directories
manage-http-create-directories() {
	subheader "Creating Host Directory"
	mkdir /home/$USER/http/hosts/$HOST_DIR
	chown -R $USER:$USER /home/$USER/http/hosts/$HOST_DIR
	find /home/$USER/http/hosts/$HOST_DIR -type d -exec chmod 770 {} \;
}

# Generate Configuration
manage-http-generate-configuration() {
	# Create Host Configuration
	subheader "Creating Host Configuration..."
	if [ $HOST_WWW = 1 ]; then
		cp $MODULEPATH/$MODULE/nginx/example-www.conf /etc/nginx/hosts.d/$USER-$HOST_DIR.conf
		echo "" >> /etc/nginx/hosts.d/$USER-$HOST_DIR.conf
		cat $MODULEPATH/$MODULE/nginx/example.conf >> /etc/nginx/hosts.d/$USER-$HOST_DIR.conf
	else
		cp $MODULEPATH/$MODULE/nginx/example.conf /etc/nginx/hosts.d/$USER-$HOST_DIR.conf
	fi

	# Update Host Configuration (WWW)
	if [[ $HOST_WWW = 1 ]]; then
		subheader "Updating Host Configuration (WWW)..."
		# Update WWW Host
		sed -i "s/server_name example.com/server_name "$HOST_DIR"/g" /etc/nginx/hosts.d/$USER-$HOST_DIR.conf
		# Update WWW Host Redirect
		sed -i "s/www.example.com\/$1/"$HOST"\/$1/g" /etc/nginx/hosts.d/$USER-$HOST_DIR.conf
	fi

	# Update Host Configuration
	subheader "Updating Host Configuration..."
	# Update Host
	sed -i "s/server_name www.example.com/server_name "$HOST"/g" /etc/nginx/hosts.d/$USER-$HOST_DIR.conf
	# Update Root
	sed -i "s/root example/root \/home\/"$USER"\/http\/hosts\/"$HOST_DIR"/g" /etc/nginx/hosts.d/$USER-$HOST_DIR.conf
	# Update Log File Path
	sed -i "s/error_log example/error_log \/home\/"$USER"\/http\/logs\/"$HOST_DIR".log/g" /etc/nginx/hosts.d/$USER-$HOST_DIR.conf
	# Update PHP
	sed -i "s/php.d\/example/php.d\/"$USER"/g" /etc/nginx/hosts.d/$USER-$HOST_DIR.conf

	# Create Host PHP Configuration
	subheader "Creating Host PHP Configuration..."
	cp $MODULEPATH/$MODULE/nginx/example-php.conf /etc/nginx/php.d/$USER.conf

	# Update Host PHP Configuration
	subheader "Updating Host PHP Configuration..."
	sed -i "s/example/"$USER"/g" /etc/nginx/php.d/$USER.conf

	# Create PHP Directories
	subheader "Creating PHP Directories..."
	mkdir -p /etc/php5/fpm/pool.d

	# Create PHP Configuration
	subheader "Creating PHP Configuration..."
	cp $MODULEPATH/$MODULE/php-fpm/example.conf /etc/php5/fpm/pool.d/$USER.conf

	# Update PHP Configuration
	subheader "Updating PHP Configuration..."
	# Update PHP Configuration Header
	sed -i "s/HEADER/\["$USER"\]/g" /etc/php5/fpm/pool.d/$USER.conf
	# Update PHP Configuration Listen
	sed -i "s/listen = example/listen = \/home\/"$USER"\/http\/private\/php.socket/g" /etc/php5/fpm/pool.d/$USER.conf
	# Update PHP Configuration User
	sed -i "s/user = example/user = "$USER"/g" /etc/php5/fpm/pool.d/$USER.conf
	# Update PHP Configuration Group
	sed -i "s/group = example/group = "$USER"/g" /etc/php5/fpm/pool.d/$USER.conf
}

######################
## Manage Functions ##
######################

# Enable Host As Default Host
manage-http-default-host() {
	subheader "Setting As Default..."
	echo "server {" > /etc/nginx/hosts.d/default.conf
	echo -e "\tlisten 80 default_server;" >> /etc/nginx/hosts.d/default.conf
	echo -e "\trewrite ^/(.*) http://$HOST/\$1 permanent;" >> /etc/nginx/hosts.d/default.conf
	echo "}" >> /etc/nginx/hosts.d/default.conf
}

# Enable PHP For Host
manage-http-enable-php() {
	if [ $1 = 1 ]; then
		subheader "Enabling PHP..."
		sed -i "s/\o011#include \/etc\/nginx\/php.d/\o011include \/etc\/nginx\/php.d/g" /etc/nginx/hosts.d/$USER-$HOST_DIR.conf
	else
		subheader "Disabling PHP..."
		sed -i "s/\o011include \/etc\/nginx\/php.d/\o011#include \/etc\/nginx\/php.d/g" /etc/nginx/hosts.d/$USER-$HOST_DIR.conf
	fi
}

#######################
## Removal Functions ##
#######################

# Remove Host
manage-http-remove-host() {
	subheader "Removing Files..."
	rm /home/$USER/http/logs/$HOST_DIR.log
	rm /etc/nginx/hosts.d/$USER-$HOST_DIR.conf
	if ! ls /etc/nginx/hosts.d/$USER-*.conf > /dev/null 2>&1; then
		rm /etc/nginx/php.d/$USER.conf
		rm /etc/php5/fpm/pool.d/$USER.conf
	fi
}

# Remove Host Files
manage-http-remove-host-files() {
	subheader "Removing Files..."
	rm -rf /home/$USER/http/hosts/$HOST_DIR/
}

#####################
## Final Functions ##
#####################

# Reload Daemons
manage-http-reload-daemons() {
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
}

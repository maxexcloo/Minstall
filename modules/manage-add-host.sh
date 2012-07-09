#!/bin/bash
# Manage: Add Virtual Host

# Common Functions
source $MODULEPATH/manage-common.sh

# Common HTTP Functions
source $MODULEPATH/manage-common-http.sh

# Attended Mode
if [ $UNATTENDED = 0 ]; then
	# User Check Loop
	manage-http-check-user-loop

	# Host Check Loop
	manage-http-check-host-loop

	# Check Host
	manage-http-check-host

	# Create Directories
	manage-http-create-directories

	# Generate Configuration
	manage-http-generate-configuration

	# Default Question
	if question --default yes "Do you want to set this virtual host as the default host? (Y/n)"; then
		manage-http-default-host
	fi

	# Check Package
	if check_package "php5-fpm"; then
		# PHP Question
		if question --default yes "Do you want to enable PHP for this virtual host? (Y/n)"; then
			manage-http-enable-php 1
		else
			manage-http-enable-php 0
		fi
	else
		manage-http-enable-php 0
	fi
# Unattended Mode
else
	# Define Arrays
	USERLIST=$(read_var_module user),
	HOSTLIST=$(read_var_module host),
	DEFAULTLIST=$(read_var_module default),
	HTTPLIST=$(read_var_module http),
	PHPLIST=$(read_var_module php),

	# Loop Through Users
	while echo $USERLIST | grep \, &> /dev/null; do
		# Define Current
		USER=${USERLIST%%\,*}
		HOST=${HOSTLIST%%\,*}
		DEFAULT=${DEFAULTLIST%%\,*}
		HTTP=${HTTPLIST%%\,*}
		PHP=${PHPLIST%%\,*}

		# Remove Current User From List
		USERLIST=${USERLIST#*\,}
		HOSTLIST=${HOSTLIST#*\,}
		DEFAULTLIST=${DEFAULTLIST#*\,}
		HTTPLIST=${HTTPLIST#*\,}
		PHPLIST=${PHPLIST#*\,}

		# Check If Array Empty
		manage-check-array

		# Check User
		manage-check-user

		# User HTTP Folder
		if [ $HTTP = 1 ]; then
			manage-folder
		fi

		# Check Host
		manage-http-check-host

		# Create Directories
		manage-http-create-directories

		# Generate Configuration
		manage-http-generate-configuration

		# Default Check
		if [ $DEFAULT = 1 ]; then
			manage-http-default-host
		fi

		# Check Package
		if check_package "php5-fpm"; then
			# PHP Check
			if [ $PHP = 1 ]; then
				manage-http-enable-php 1
			else
				manage-http-enable-php 0
			fi
		else
			manage-http-enable-php 0
		fi
	done
fi

# Reset Host WWW Variable
HOST_WWW=0

# Reload Daemons
manage-http-reload-daemons

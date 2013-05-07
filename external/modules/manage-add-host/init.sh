#!/bin/bash
# Manage: Add Virtual Host

# Manage Common Functions
manage-common

# Manage HTTP Common Functions
http-common

# Attended Mode
if [ $UNATTENDED = 0 ]; then
	# User Check Loop
	manage-http-check-user-loop

	# Host Check Loop
	manage-http-check-host-loop

	# Check Host
	manage-http-check-host

	# Check Host Existence
	manage-http-check-host-existence

	# Create Directories
	manage-http-create-directories

	# Generate Configuration
	manage-http-generate-configuration

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

	# SSL Question
	if question --default yes "Do you want to enable SSL for this virtual host? (Y/n)"; then
		manage-http-enable-ssl 1
	else
		manage-http-enable-ssl 0
	fi

	# Default Question
	if question --default no "Do you want to set this virtual host as the default host? (y/N)"; then
		manage-http-default-host
	fi
# Unattended Mode
else
	# Define Arrays
	USERLIST=$(read_variable_module user),
	HOSTLIST=$(read_variable_module host),
	DEFAULTLIST=$(read_variable_module default),
	PHPLIST=$(read_variable_module php),
	SSLLIST=$(read_variable_module ssl),

	# Loop Through Users
	while echo $USERLIST | grep -q \,; do
		# Define Current
		USER=${USERLIST%%\,*}
		HOST=${HOSTLIST%%\,*}
		DEFAULT=${DEFAULTLIST%%\,*}
		PHP=${PHPLIST%%\,*}
		SSL=${SSLLIST%%\,*}

		# Remove Current User From List
		USERLIST=${USERLIST#*\,}
		HOSTLIST=${HOSTLIST#*\,}
		DEFAULTLIST=${DEFAULTLIST#*\,}
		PHPLIST=${PHPLIST#*\,}
		SSLLIST=${SSLLIST#*\,}

		# Check If Array Empty
		manage-check-array

		# Check User
		manage-check-user

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

		# SSL Check
		if [ $SSL = 1 ]; then
			manage-http-enable-ssl 1
		else
			manage-http-enable-ssl 0
		fi
	done
fi

# Reset Host WWW Variable
HOST_WWW=0

# Reload Daemons
manage-http-reload-daemons

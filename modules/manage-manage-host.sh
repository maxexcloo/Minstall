#!/bin/bash
# Manage: Manage Virtual Host

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

	# Check Directory
	manage-http-check-directory

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
	if question --default yes "Do you want to set this virtual host as the default host? (Y/n)"; then
		manage-http-default-host
	fi
# Unattended Mode
else
	# Define Arrays
	USERLIST=$(read_var_module user),
	HOSTLIST=$(read_var_module host),
	DEFAULTLIST=$(read_var_module default),
	PHPLIST=$(read_var_module php),
	SSLLIST=$(read_var_module ssl),

	# Loop Through Users
	while echo $USERLIST | grep \, &> /dev/null; do
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

		# Check Directory
		manage-http-check-directory

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

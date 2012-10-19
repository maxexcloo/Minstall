#!/bin/bash
# Manage: Remove Virtual Host

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

	# Confirmation Question
	if question --default yes "Are you sure you want to remove this virtual host? (Y/n)"; then
		# Remove Host
		manage-http-remove-host
	else
		# Continue Loop
		continue
	fi

	# Confirmation Question
	if question --default yes "Do you want to delete the virtual host directory? (Y/n)"; then
		# Remove Host Files
		manage-http-remove-host-files
	fi
# Unattended Mode
else
	# Define Arrays
	USERLIST=$(read_var_module user),
	HOSTLIST=$(read_var_module host),
	RMLIST=$(read_var_module rm),

	# Loop Through Users
	while echo $USERLIST | grep \, &> /dev/null; do
		# Define Current
		USER=${USERLIST%%\,*}
		HOST=${HOSTLIST%%\,*}
		RM=${RMLIST%%\,*}

		# Remove Current User From List
		USERLIST=${USERLIST#*\,}
		HOSTLIST=${HOSTLIST#*\,}
		RMLIST=${RMLIST#*\,}

		# Check If Array Empty
		manage-check-array

		# Check User
		manage-check-user

		# Check Host
		manage-http-check-host

		# Check Directory
		manage-http-check-directory

		# Remove Host
		manage-http-remove-host

		# Remove Host Files
		if [ $RM = 1 ]; then
			manage-http-remove-host-files
		fi
	done
fi

# Reset Host WWW Variable
HOST_WWW=0

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

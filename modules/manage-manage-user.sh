#!/bin/bash
# Manage: Manage User

# Common Functions
source $MODULEPATH/manage-common.sh

# Attended Mode
if [ $UNATTENDED = 0 ]; then
	# User Check Loop
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

	# Reset User Permissions Question
	if question --default no "Do you want to change the password for this user? (y/N)"; then
		subheader "Setting Password..."
		passwd $USER
	fi

	# Check Package
	if check_package "nginx"; then
		# User HTTP Folder Question
		if question --default yes "Do you want to add a HTTP folder for this user? (Y/n)"; then
			manage-folder
		fi
	fi

	# Reset User Permissions Question
	if question --default yes "Do you want to change file permissions for this user to enable privacy? (Y/n)"; then
		manage-reset-permissions
	fi
# Unattended Mode
else
	# Define Arrays
	USERLIST=$(read_var_module user),
	PASSLIST=$(read_var_module pass),
	HTTPLIST=$(read_var_module http),
	PERMLIST=$(read_var_module perm),

	# Loop Through Users
	while echo $USERLIST | grep \, &> /dev/null; do
		# Define Current
		USER=${USERLIST%%\,*}
		PASS=${PASSLIST%%\,*}
		HTTP=${HTTPLIST%%\,*}
		PERM=${PERMLIST%%\,*}

		# Remove Current User From List
		USERLIST=${USERLIST#*\,}
		PASSLIST=${PASSLIST#*\,}
		HTTPLIST=${HTTPLIST#*\,}
		PERMLIST=${PERMLIST#*\,}

		# Check If Array Empty
		manage-check-array

		# Check User
		manage-check-user

		# Set Password
		if [ $PASS != 0 ]; then
			subheader "Setting Password..."
			echo "$USER:$PASS" | chpasswd
		fi

		# User HTTP Folder
		if [ $HTTP = 1 ]; then
			manage-folder
		fi

		# Reset User Permissions
		if [ $PERM = 1 ]; then
			manage-reset-permissions
		fi
	done

	# Unset Arrays
	unset USERLIST
	unset PASSLIST
	unset HTTPLIST
	unset PERMLIST
fi
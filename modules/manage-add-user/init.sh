#!/bin/bash
# Manage: Add User

# Manage Common Functions
module-manage-common

# Attended Mode
if [ $UNATTENDED = 0 ]; then
	# User Check Loop
	while true; do
		# Take User Input
		read -p "Please enter a user name: " USER
		# Add User
		subheader "Adding User..."
		useradd -m -s /bin/bash $USER
		# Check If Addition Successful
		if [ -d /home/$USER ]; then
			break
		else
			echo "User addition failed, please try again."
		fi
	done

	# Set Password
	subheader "Setting Password..."
	passwd $USER

	# Clean Cron Entry
	clean-cron

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
	while echo $USERLIST | grep -q \,; do
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

		# Add User
		subheader "Adding User ($USER)..."
		useradd -m -s /bin/bash $USER

		# Check User
		manage-check-user

		# Set Password
		subheader "Setting Password..."
		echo "$USER:$PASS" | chpasswd

		# Clean Cron Entry
		clean-cron

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

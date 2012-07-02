#!/bin/bash
# Manage: Add User

# Attended Mode
if [ $UNATTENDED = 0 ]; then
	# User Check Loop
	while true; do
		# Take User Input
		read -p "Please enter a user name: " USERNAME
		# Add User
		subheader "Adding User..."
		useradd -m -s /bin/bash $USERNAME
		# Check If Addition Successful
		if [ -d /home/$USERNAME ]; then
			break
		else
			echo "User addition failed, please try again."
		fi
	done

	# Set Password
	subheader "Setting Password..."
	passwd $USERNAME

	# Check Package
	if check_package "nginx"; then
		# User HTTP Folder Question
		if question --default yes "Do you want to add a HTTP folder for this user? (Y/n)"; then
			subheader "Adding HTTP Folder..."
			mkdir -p /home/$USERNAME/http/{common,hosts,logs,private}
			subheader "Changing HTTP Permissions..."
			chown -R $USERNAME:$USERNAME /home/$USERNAME/http
			find /home/$USERNAME/http -type d -exec chmod 770 {} \;
			subheader "Adding User To HTTP Group..."
			gpasswd -a www-data $USERNAME
		fi
	fi

	# Reset User Permissions Question
	if question --default yes "Do you want to change file permissions for this user to enable privacy? (Y/n)"; then
		subheader "Changing User File Permissions..."
		chmod -R o= /home/$USERNAME
		chown -R $USERNAME:$USERNAME /home/$USERNAME
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

		# Add User
		subheader "Adding User ($USER)..."
		useradd -m -s /bin/bash $USER

		# Check User
		if [ ! -d /home/$USER ]; then
			echo "Invalid user ($USER)."
			break
		fi

		# Set Password
		subheader "Setting Password..."
		echo $PASS | passwd $USER --stdin

		# User HTTP Folder
		if [ $HTTP = 1 ]; then
			subheader "Adding HTTP Folder..."
			mkdir -p /home/$USER/http/{common,hosts,logs,private}
			subheader "Changing HTTP Permissions..."
			chown -R $USER:$USER /home/$USER/http
			find /home/$USER/http -type d -exec chmod 770 {} \;
			subheader "Adding User To HTTP Group..."
			gpasswd -a www-data $USER
		fi

		# Reset User Permissions
		if [ $PERM = 1 ]; then
			subheader "Changing User File Permissions..."
			chmod -R o= /home/$USER
			chown -R $USER:$USER /home/$USER
		fi
	done

	# Unset Array
	unset USERLIST
fi

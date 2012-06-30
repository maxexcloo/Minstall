#!/bin/bash
# Manage: Add User

# Unattended Mode
if [ $UNATTENDED == 1 ]; then
	# Define Variables
	USER=$(read_var_module user)
	LOOPUSER=${USER},
	PASS=$(read_var_module pass)
	LOOPPASS=${USER},
	HTTP=$(read_var_module http)
	LOOPHTTP=${HTTP},
	PERM=$(read_var_module perm)
	LOOPPERM=${PERM},

	# Loop Through Users
	while echo $LOOPVAR | grep \, &> /dev/null; do
		# Define Current Variable
		CURUSER=${LOOPUSER%%\,*}
		CURPASS=${LOOPPASS%%\,*}
		CURHTTP=${LOOPHTTP%%\,*}
		CURPERM=${LOOPPERM%%\,*}

		# Remove Current Object From Variable List
		LOOPUSER=${LOOPUSER#*\,}
		LOOPPASS=${LOOPPASS#*\,}
		LOOPHTTP=${LOOPHTTP#*\,}
		LOOPPERM=${LOOPPERM#*\,}

		# Add User
		subheader "Adding User..."
		useradd -m -s /bin/bash $CURUSER

		# Set Password
		subheader "Setting Password..."
		echo -e "$CURPASS\n$CURPASS" | (passwd --stdin $CURUSER)

		# User HTTP Folder
		if [ $CURHTTP == 1 ]; then
			subheader "Adding HTTP Folder..."
			mkdir -p /home/$CURUSER/http/{common,hosts,logs,private}
			subheader "Changing HTTP Permissions..."
			chown -R $CURUSER:$CURUSER /home/$CURUSER/http
			find /home/$CURUSER/http -type d -exec chmod 770 {} \;
			subheader "Adding User To HTTP Group..."
			gpasswd -a www-data $CURUSER
		fi

		# Reset User Permissions
		if [ $CURPERM == 1 ]; then
			subheader "Changing User File Permissions..."
			chmod -R o= /home/$CURUSER
			chown -R $CURUSER:$CURUSER /home/$CURUSER
		fi
	done
# Attended Mode
else
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
		if question --default yes "Do you want to add a HTTP folder for this user (if you have already done this you don't need to do it again)? (Y/n)"; then
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
fi

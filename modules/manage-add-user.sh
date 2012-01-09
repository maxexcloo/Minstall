#!/bin/bash
# Manage: Add User

# User Check Loop
while true; do
	# Take User Input
	read -p "Please enter a user name: " USERNAME
	# Add User
	subheader "Adding User..."
	useradd -m -s /bin/bash $USERNAME
	# Check If Addition Successful
	if [ -d ~$USERNAME ]; then
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
		mkdir -p ~$USERNAME/http/{common,hosts,logs,private}
		chown -R $USERNAME:$USERNAME ~$USERNAME/http
		subheader "Adding User To HTTP Group..."
		useradd -G www-data $USERNAME
	fi
fi

# Reset User Permissions Question
if question --default yes "Do you want to change file permissions for this user to enable privacy? (Y/n)"; then
	subheader "Changing User File Permissions..."
	chmod -R o= ~$USERNAME
	chown -R $USERNAME:$USERNAME ~$USERNAME
fi

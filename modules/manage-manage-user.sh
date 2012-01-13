#!/bin/bash
# Manage: Manage User

# User Check Loop
while true; do
	# Take User Input
	read -p "Please enter a user name: " USERNAME
	# Check If User Directory Exists
	if [ -d /home/$USERNAME ]; then
		break
	else
		echo "Please enter a valid username."
	fi
done

# Check Package
if check_package "nginx"; then
	# User HTTP Folder Question
	if question --default yes "Do you want to add a HTTP folder for this user (if you have already done this you don't need to do it again)? (Y/n)"; then
		subheader "Adding HTTP Folder..."
		mkdir -p /home/$USERNAME/http/{common,hosts,logs,private}
		subheader "Changing HTTP Permissions..."
		chown -R $USERNAME:$USERNAME /home/$USERNAME/http
		subheader "Adding User To HTTP Group..."
		gpasswd -a $USERNAME www-data
	fi
fi

# Reset User Permissions Question
if question --default yes "Do you want to change file permissions for this user to enable privacy? (Y/n)"; then
	subheader "Changing User File Permissions..."
	chmod -R o= /home/$USERNAME
	chown -R $USERNAME:$USERNAME /home/$USERNAME
fi

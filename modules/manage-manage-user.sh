#!/bin/bash
# Manage: Manage User

# User Check Loop
while true; do
	# Take User Input
	read -p "Please enter a user name: " USERNAME
	if [ -d ~$USERNAME ]; then
		break
	else
		echo "Please enter a valid username."
	fi
done

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

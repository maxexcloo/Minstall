#!/bin/bash
# Manage: Common Functions

# Run Clean Common Module
source $MODULEPATH/clean-common.sh

#####################
## Check Functions ##
#####################

# Check If Array Empty
manage-check-array() {
	if [ $USER = 0 ]; then
		# Print Message
		error "No users in user array. Aborting."
		# Exit Loop
		break
	fi
}

# Check User
manage-check-user() {
	if [ ! -d /home/$USER ]; then
		# Print Message
		echo "Invalid user ($USER)."
		# Continue In Array
		continue
	fi
}

#####################
## Setup Functions ##
#####################

# Clean Cron Entry
clean-cron() {
	subheader "Cleaning User Cron Entry..."
	echo "" > /tmp/cron
	crontab -u $USER /tmp/cron
}

# HTTP Folder Setup
manage-folder() {
	subheader "Adding HTTP Folder..."
	mkdir -p /home/$USER/http/{common,hosts,logs,private}
	subheader "Changing HTTP Permissions..."
	chown -R $USER:$USER /home/$USER/http
	find /home/$USER/http -type d -exec chmod 770 {} \;
	subheader "Adding User To HTTP Group..."
	gpasswd -a www-data $USER
}

# Reset Permissions
manage-reset-permissions() {
	subheader "Changing User File Permissions..."
	chmod -R o= /home/$USER
	chown -R $USER:$USER /home/$USER
}

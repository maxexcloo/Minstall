#!/bin/bash
# Basic phpMyAdmin Installer

###############
## Variables ##
###############

# User (Owner Of Virtual Host)
USER="main"

# Virtual Host
HOST="host.example.com"

# Directory Under Virtual Host In Which Script Will Be Installed, Leave Empty For Installation Into Virtual Host Root
DIRECTORY="wordpress"

# Script URL
URL="http://www.wordpress.org/latest.tar.gz"

############
## Script ##
############

# Change Directory
cd /home/$USER/http/hosts/$HOST

# Check If Directory Variable Empty
if [[ $DIRECTORY != "" ]]; then
	# Make Script Directory
	mkdir $DIRECTORY

	# Change Directory
	cd $DIRECTORY
fi

# Download Script
wget -O wordpress.tar.gz "$URL"

# Extract Script
tar xfvz wordpress.tar.gz

# Move Script
mv wordpress/* .

# Clean Useless Files
rm -rf license.txt readme.html

# Update Owner
chown -R $USER:$USER .

# Update Permissions
chmod -R o= .

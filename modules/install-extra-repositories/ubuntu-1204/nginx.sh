#!/bin/bash
# Install Nginx Repository

# Ask If Repository Should Be Installed
if question --default yes "Do you want to install the Nginx repository? (Y/n)" || [ $UNATTENDED = 1 ]; then
	subheader "Installing Nginx Repository..."

	# Add Repository Key
	repo_key_server "keyserver.ubuntu.com" "C300EE8C"

	# Add Repository
	repo_add "nginx" "deb http://ppa.launchpad.net/nginx/stable/ubuntu precise main"
fi

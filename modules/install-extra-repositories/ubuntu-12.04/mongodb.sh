#!/bin/bash
# Install MongoDB Repository

# Ask If Repository Should Be Installed
if question --default yes "Do you want to install the MongoDB repository? (Y/n)" || [ $UNATTENDED = 1 ]; then
	subheader "Installing MongoDB Repository..."

	# Add Repository Key
	repo_key_server "keyserver.ubuntu.com" "7F0CEB10"

	# Add Repository
	repo_add "mongodb" "deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen"
fi

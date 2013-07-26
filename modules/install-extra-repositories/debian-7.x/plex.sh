#!/bin/bash
# Install Plex Repository

# Ask If Repository Should Be Installed
if question --default yes "Do you want to install the Plex repository? (Y/n)" || [ $UNATTENDED = 1 ]; then
	subheader "Installing Plex Repository..."

	# Add Repository Key
	repo_key "http://shell.ninthgate.se/packages/shell-ninthgate-se-keyring.key"

	# Add Repository
	repo_add "plex" "deb http://shell.ninthgate.se/packages/debian wheezy main"
fi

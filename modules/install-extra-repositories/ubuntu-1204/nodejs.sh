#!/bin/bash
# Install Node.js Repository

# Ask If Repository Should Be Installed
if question --default yes "Do you want to install the Node repository? (Y/n)" || [ $UNATTENDED = 1 ]; then
	subheader "Installing Node.js Repository..."

	# Add Repository Key
	repo_key "https://deb.nodesource.com/gpgkey/nodesource.gpg.key"

	# Add Repository
	repo_add "nodejs" "deb https://deb.nodesource.com/node precise main"
fi

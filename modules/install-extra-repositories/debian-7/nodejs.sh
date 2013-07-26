#!/bin/bash
# Install Node.js Repository

# Ask If Repository Should Be Installed
if question --default yes "Do you want to install the Node repository? (Y/n)" || [ $UNATTENDED = 1 ]; then
	subheader "Installing Node.js Repository..."

	# Add Repository Key
	repo_key_server "keyserver.ubuntu.com" "C7917B12"

	# Add Repository
	repo_add "nodejs" "deb http://ppa.launchpad.net/chris-lea/node.js/ubuntu/ precise main"
fi

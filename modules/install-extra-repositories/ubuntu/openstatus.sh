#!/bin/bash
# Install OpenStatus Repository

# Ask If Repository Should Be Installed
if question --default yes "Do you want to install the OpenStatus repository? (Y/n)" || [ $UNATTENDED = 1 ]; then
	subheader "Installing The OpenStatus Repository..."
	# Add Repository Key
	repo_key "http://deb.nickmoeck.com/debian/packages.gpg.key"
	# Add Repository
	repo_add "openstatus" "deb http://deb.nickmoeck.com/debian/ stable main"
fi

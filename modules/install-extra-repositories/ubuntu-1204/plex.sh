#!/bin/bash
# Install Plex Repository

# Ask If Repository Should Be Installed
if question --default yes "Do you want to install the Plex repository? (Y/n)" || [ $UNATTENDED = 1 ]; then
	subheader "Installing Plex Repository..."

	# Add Repository Key
	repo_key "http://www.plexapp.com/plex_pub_key.pub"

	# Add Repository
	repo_add "plex" "deb http://www.plexapp.com/repo lucid main"
fi

#!/bin/bash
# Install Debian Multimedia Repository

# Ask If Repository Should Be Installed
if question --default yes "Do you want to install the Debian Multimedia repository? (Y/n)"; then
	subheader "Installing The Debian Multimedia Repository..."
	# Add Repository Key
	repo_key "http://www.debian-multimedia.org/pool/main/d/debian-multimedia-keyring/debian-multimedia-keyring_2010.12.26_all.deb"
	# Add Repository
	repo_add "debian-multimedia" "deb http://www.debian-multimedia.org squeeze main non-free"
fi

#!/bin/bash
# Install Debian Multimedia Repository

# Ask If Repository Should Be Installed
if question --default yes "Do you want to install the Debian Multimedia repository? (Y/n)" || [ $UNATTENDED = 1 ]; then
	subheader "Installing Debian Multimedia Repository..."

	# Add Repository
	repo_add "debian-multimedia" "deb http://www.deb-multimedia.org/ squeeze main non-free"

	# Update Package Lists
	package_update

	# Install Repository Key
	apt-get -qy --allow-unauthenticated install deb-multimedia-keyring

	# Add Package To Package List
	echo "deb-multimedia-keyring install" >> $MODULEPATH/clean-packages/$DISTRIBUTION-$VERSION/custom
fi

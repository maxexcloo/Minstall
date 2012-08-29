#!/bin/bash
# Install Medibuntu Repository

# Ask If Repository Should Be Installed
if question --default yes "Do you want to install the Medibuntu repository? (Y/n)" || [ $UNATTENDED = 1 ]; then
	subheader "Installing The Medibuntu Repository..."
	# Add Repository
	repo_add "medibuntu" "deb http://packages.medibuntu.org/ precise free non-free"
	# Update Package Lists
	package_update
	# Install Repository Key
	apt-get -q -y --allow-unauthenticated install medibuntu-keyring
	# Add Package To Package List
	echo "medibuntu-keyring install" >> $MODULEPATH/clean-packages/$DISTRIBUTION/custom
fi

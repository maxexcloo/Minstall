#!/bin/bash
# Install Debian Multimedia Repository

# Ask If Repository Should Be Installed
if question --default yes "Do you want to install the Debian Multimedia repository? (Y/n)" || [ $UNATTENDED = 1 ]; then
	subheader "Installing The Debian Multimedia Repository..."
	# Download Repository Key
	wget -O $MODULEPATH/$MODULE/temp.deb "http://www.debian-multimedia.org/pool/main/d/debian-multimedia-keyring/debian-multimedia-keyring_2010.12.26_all.deb"
	# Install Repository Key
	dpkg -i $MODULEPATH/$MODULE/temp.deb
	# Remove Temporary Package File
	rm $MODULEPATH/$MODULE/temp.deb
	# Add Package To Package List
	echo "debian-multimedia-keyring                       install" >> $MODULEPATH/clean-packages/$DISTRIBUTION/base
	# Add Repository
	repo_add "debian-multimedia" "deb http://www.debian-multimedia.org squeeze main non-free"
fi

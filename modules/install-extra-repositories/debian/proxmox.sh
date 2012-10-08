#!/bin/bash
# Install Proxmox Repository

# Ask If Repository Should Be Installed
if question --default yes "Do you want to install the Proxmox repository? (Y/n)" || [ $UNATTENDED = 1 ]; then
	# Check Architecture
	if [ $(uname -m) = "x86_64" ]; then
		subheader "Installing Proxmox Repository..."
		# Add Repository Key
		repo_key "http://download.proxmox.com/debian/key.asc"
		# Add Repository
		repo_add "proxmox" "deb http://download.proxmox.com/debian/ squeeze pve"
	else
		# Print Error
		warning "Not supported on x86, server must be x86_64."
	fi
fi

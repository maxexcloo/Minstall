#!/bin/bash
# Install Proxmox Repository

# Ask If Repository Should Be Installed
if question --default yes "Do you want to install the Proxmox repository? (Y/n)" || [ $UNATTENDED = 1 ]; then
	subheader "Installing The Proxmox Repository..."
	# Add Repository Key
	repo_key "http://download.proxmox.com/debian/key.asc"
	# Add Repository
	repo_add "proxmox" "deb http://download.proxmox.com/debian/ squeeze pve"
fi

#!/bin/bash
# Install Nginx Repository

# Ask If Repository Should Be Installed
if question --default yes "Do you want to install the Nginx repository? (Y/n)" || [ $UNATTENDED = 1 ]; then
	subheader "Installing Nginx Repository..."

	# Add Repository Key
	repo_key "http://nginx.org/keys/nginx_signing.key"

	# Add Repository
	repo_add "nginx" "deb http://nginx.org/packages/debian/ wheezy nginx"
fi
#!/bin/bash
# Install DotDeb Repository

# Ask If Repository Should Be Installed
if question --default yes "Do you want to install the DotDeb repository? (Y/n)" || [ $UNATTENDED = 1 ]; then
	subheader "Installing The DotDeb Repository..."
	# Add Repository Key
	repo_key "http://www.dotdeb.org/dotdeb.gpg"
	# Add Repository
	repo_add "dotdeb" "deb http://packages.dotdeb.org/ squeeze all"
fi

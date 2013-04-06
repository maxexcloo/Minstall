#!/bin/bash
# Install WebUpd8 Java Repository

# Ask If Repository Should Be Installed
if question --default yes "Do you want to install the WebUpd8 Java repository? (Y/n)" || [ $UNATTENDED = 1 ]; then
	subheader "Installing WebUpd8 Java Repository..."
	
	# Add Repository Key
	repo_key_server "keyserver.ubuntu.com" "EEA14886"
	
	# Add Repository
	repo_add "webupd8-java" "deb http://ppa.launchpad.net/webupd8team/java/ubuntu/ precise main"
fi

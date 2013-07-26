#!/bin/bash
# Install MariaDB Repository

# Ask If Repository Should Be Installed
if question --default yes "Do you want to install the MariaDB repository? (Y/n)" || [ $UNATTENDED = 1 ]; then
	subheader "Installing MariaDB Repository..."

	# Add Repository Key
	repo_key_server "keyserver.ubuntu.com" "0xcbcb082a1bb943db"

	# Add Repository
	repo_add "mariadb" "deb http://ftp.osuosl.org/pub/mariadb/repo/5.5/debian/ wheezy main"
fi

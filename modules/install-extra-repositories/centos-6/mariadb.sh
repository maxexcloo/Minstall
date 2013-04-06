#!/bin/bash
# Install MariaDB Repository

# Ask If Repository Should Be Installed
if question --default yes "Do you want to install the MariaDB repository? (Y/n)" || [ $UNATTENDED = 1 ]; then
	subheader "Installing MariaDB Repository..."

	# Check Architecture
	if [ $ARCHITECTURE = "x32" ]; then
		# Add Repository
		repo_add "mariadb" "http://yum.mariadb.org/5.5/centos6-x86/" "http://yum.mariadb.org/RPM-GPG-KEY-MariaDB"
	elif [ $ARCHITECTURE = "x64" ]; then
		# Add Repository
		repo_add "mariadb" "http://yum.mariadb.org/5.5/centos6-amd64/" "http://yum.mariadb.org/RPM-GPG-KEY-MariaDB"
	fi
fi

#!/bin/bash
# Functions For Cleaning System Packages/Files In Ubuntu

# Clean Daemons
function clean_daemons() {
	# Loop Through Daemons (Upstart Based)
	for file in /etc/init/*.conf; do
		# Stop Daemon
		daemon_manage $file stop
	done

	# Loop Through Daemons (Init Based)
	for daemon in /etc/init.d/*; do
		# Stop Daemon
		$daemon stop
	done
}

# Clean Files
function clean_files() {
	# Remove Files Not Removed By APT
	rm -rf $(grep "not empty so not removed" temp.log | sed "s/[^']*'//;s/'[^']*$//")
}

# Clean Packages
function clean_packages() {
	# Clear DPKG Package Selections
	dpkg --clear-selections

	# Set Package Selections
	dpkg --set-selections < temp.packages.list

	# Get Selections & Set To Purge
	dpkg --get-selections | sed -e "s/deinstall/purge/" > temp.packages

	# Set Package Selections
	dpkg --set-selections < temp.packages

	# Update DPKG
	DEBIAN_FRONTEND=noninteractive apt-get -qy dselect-upgrade 2>&1 | tee -a temp.log

	# Clean Package List
	package_clean_list
}

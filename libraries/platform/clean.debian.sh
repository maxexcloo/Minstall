#!/bin/bash
# Functions For Cleaning System Packages/Files In Debian

# Clean System Packages
function clean_packages() {
	# Clear DPKG Package Selections
	dpkg --clear-selections

	# Set Package Selections
	dpkg --set-selections < temp.packages.list

	# Get Selections & Set To Purge
	dpkg --get-selections | sed -e "s/deinstall/purge/" > temp.packages.system

	# Set Package Selections
	dpkg --set-selections < temp.packages.system

	# Update DPKG
	DEBIAN_FRONTEND=noninteractive apt-get -qy dselect-upgrade 2>&1 | tee -a temp.packages.logs

	# Clean Package List
	package_clean_list
}

# Clean Unused Files
function clean_files() {
	# Remove Files Not Removed By APT
	rm -rf $(grep "not empty so not removed" temp.packages.logs | sed "s/[^']*'//;s/'[^']*$//")
}

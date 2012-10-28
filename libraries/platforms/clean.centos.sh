#!/bin/bash
# Functions For Cleaning System Packages/Files In CentOS

# Clean System Packages
function clean_packages() {
	# Upgrade Packages
	package_upgrade

	# Install Packages
	package_install $(cat temp.packages.list)

	# Create Local List
	rpm -qa --queryformat "%{NAME}\n" > temp.packages.system

	# Merge Lists > Complete List
	cat temp.packages.list temp.packages.system > temp.packages.all

	# Sort Complete List
	sort -fo temp.packages.all temp.packages.all

	# Find Unique Entries In Complete List
	uniq -iu temp.packages.all temp.packages.unique

	# Remove Packages
	package_remove $(cat temp.packages.unique)
}

# Clean Unused Files
function clean_files() {
	# Unsupported
}

#!/bin/bash
# Functions For Cleaning System Packages/Files In CentOS

# Clean System Packages
function clean_packages() {
	# Loop Through Package List
	for package in $(cat temp.packages.list); do
		# Install Package
		package_install $package
	done

	# Create Local List
	rpm -qa --queryformat "%{NAME}\n" > temp.packages.system

	# Merge Lists > Complete List
	cat temp.packages.list temp.packages.system > temp.packages.all

	# Sort Complete List
	sort -fo temp.packages.all temp.packages.all

	# Find Unique Entries In Complete List
	uniq -iu temp.packages.all temp.packages.unique

	# Loop Through Unique List
	for package in $(cat temp.packages.unique); do
		# Install Package
		package_remove $package
	done
}

# Clean Unused Files
function clean_files() {
# # 	# Unsupported
}

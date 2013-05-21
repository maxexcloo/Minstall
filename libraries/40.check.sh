#!/bin/bash
# Functions For Checking Packages & Repositories

# Combined Package Check Function
check_package_message() {
	# Distribution Test
	if [ $1 == "" ] || [ $1 == $DISTRIBUTION ] || [ $1 == $DISTRIBUTION-$VERSION ]; then
		# Check Package
		if ! check_package $2; then
			# Print Warning
			warning "This module requires the $2 package to be installed, please install it and try again!"

			# Suggested Module Text Test
			if [ $3 != "" ]; then
				# Print Suggested Module Information
				warning "The $2 package can be installed using the $3 module."
			fi

			# Continue Loop
			continue
		fi
	fi
}

# Combined Repository Check Function
check_repository_message() {
	# Distribution Test
	if [ $1 == "" ] || [ $1 == $DISTRIBUTION ] || [ $1 == $DISTRIBUTION-$VERSION ]; then
		# Check Package
		if ! check_repository $2; then
			# Print Warning
			warning "This module requires the $3 repository to be installed, please install it and try again!"

			# Print Suggested Module Information
			warning "The $3 repository can be installed using the install-extra-repositories module."

			# Continue Loop
			continue
		fi
	fi
}

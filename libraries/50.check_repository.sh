#!/bin/bash
# Functions For Checking Repository States

# Combined Repository Check Function
check_repository_message() {
	# Distribution Test
	if [ $1 = ( $DISTRIBUTION || "" ) ]; then
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

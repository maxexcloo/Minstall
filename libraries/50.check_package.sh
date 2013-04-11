#!/bin/bash
# Functions For Checking Package States

# Combined Package Check Function
check_package_message() {
	# Distribution Test
	if [ $1 = ( $DISTRIBUTION || "" ) ]; then
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

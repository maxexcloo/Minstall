#!/bin/bash
# Common Functions For Module Category: HTTP Install

# Module Functions
function module-install-http-common() {
	# CentOS Specific Tests
	if [ $DISTRIBUTION = "centos" ]; then
		# Check EPEL
		if ! check_repository "epel"; then
			# Print Warning
			warning "This module requires the EPEL repository to be installed, please install it and try again!"

			# Continue Loop
			continue
		fi

		# Check Remi
		if ! check_repository "remi"; then
			# Print Warning
			warning "This module requires the Remi repository to be installed, please install it and try again!"

			# Continue Loop
			continue
		fi
	fi

	# Debian Specific Tests
	if [ $DISTRIBUTION = "debian" ]; then
		# Check DotDeb
		if ! check_repository "dotdeb"; then
			# Print Warning
			warning "This module requires the DotDeb repository to be installed, please install it and try again!"

			# Continue Loop
			continue
		fi
	fi

	# Clean Common Function
	module-clean-common
}

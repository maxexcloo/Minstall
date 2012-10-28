#!/bin/bash
# Common Functions For Module Category: HTTP Install

# Module Functions
function module-http-install-common() {
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

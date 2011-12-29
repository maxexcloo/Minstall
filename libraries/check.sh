#!/bin/bash
# Function To Detect If Files Exist

# Check If File Exists & Continue Loop If Not Installed
function check() {
	# Check If File Exists
	if [ ! -e $2 ]; then
		# Print Warning
		warning "This module requires the $1 package to be installed, please install it and run this module again!"
		# Continue Loop
		continue
	fi
}

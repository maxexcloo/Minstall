#!/bin/bash
# Functions For Displaying Information About Modules

# Print Module Description
function describe() {
	# Print Description
	echo $(sed -n '2p' $1 | cut -c3-)
}

# Print All Module Information
function list() {
	# Find Base Name
	base=$(basename $1)

	# Find File Name
	filename=${base%.*}

	# Print Module Name
	echo -e -n "\e[1;32m$filename:\e[0m "

	# Print Description
	echo $(describe $1)
}

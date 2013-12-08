#!/bin/bash
# Module Information

# Print Module Description
describe() {
	# Print Description
	echo $(sed -n "2p" $1 | cut -c3-)
}

# Print All Module Information
list() {
	# Find Directory Name
	base=$(dirname $1)

	# Find File Name
	module=$(basename $base)

	# Print Module Name
	echo -en "\e[1;32m$module:\e[0m "

	# Print Description
	echo $(describe $1)
}

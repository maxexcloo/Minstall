#!/bin/bash
# Functions For Displaying Information About Modules

# Describe Modules From Comment Information
function description() {
	# Print Description
	echo $(sed -n '2p' $1 | cut -c3-)
}

# List All Modules
function listing() {
	# Find Base Name
	base=$(basename $1)

	# Find File Name
	filename=${base%.*}

	# Print Module Name
	echo -n $filename

	# Print Separator
	echo -n " - "

	# Print Description
	echo $(description $1)
}

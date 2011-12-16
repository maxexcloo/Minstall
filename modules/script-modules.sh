#!/bin/bash
# Prints module list and module information.

# Print Header
header "Module Name - Description"

# Loop Through Modules
for file in modules/*.sh; do
	# Find Base Name
	base=$(basename $file)

	# Find File Name
	filename=${base%.*}

	# Print Module Name
	echo -n $filename

	# Print Separator
	echo -n " - "

	# Print Description
	echo $(sed -n '2p' $file | cut -c3-)
done

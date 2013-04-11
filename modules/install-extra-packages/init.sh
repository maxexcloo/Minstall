#!/bin/bash
# Install (Extra): Packages

# Package List Update Question
package_update_question

# Install Packages
subheader "Installing Extra Packages..."

# Define Packages
PACKAGELIST=$(read_var_module_var packages_$DISTRIBUTION),

# Loop Through Packages
while echo $PACKAGELIST | grep -q \,; do
	# Define Current Package
	FILE=${PACKAGELIST%%\,*}

	# Remove Current Package From List
	PACKAGELIST=${PACKAGELIST#*\,}

	# Install Currently Selected Package
	package_install $FILE
done

# Unset Array
unset PACKAGELIST

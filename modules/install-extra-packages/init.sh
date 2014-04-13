#!/bin/bash
# Install (Extra): Packages

# Package List Update Question
package_update_question

# Install Packages
subheader "Installing Extra Packages..."

# Define Packages
PACKAGELIST=$(read_variable_module_variable packages),

# Loop Through Packages
while echo $PACKAGELIST | grep -q \,; do
	# Define Current Package
	PACKAGE=${PACKAGELIST%%\,*}

	# Remove Current Package From List
	PACKAGELIST=${PACKAGELIST#*\,}

	# Install Currently Selected Package
	package_install $PACKAGE
done

# Unset Array
unset PACKAGELIST

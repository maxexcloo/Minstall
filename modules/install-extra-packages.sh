#!/bin/bash
# Install: Extra Packages

# Package List Update Question
package_update_question

# Install Packages
subheader "Installing Extra Packages..."

# Define Packages
PACKAGELIST=$(read_var_module_var packages),

# Loop Through Packages
while echo $PACKAGELIST | grep \, &> /dev/null; do
	# Define Current Package
	FILE=${PACKAGELIST%%\,*}

	# Remove Current Package From List
	PACKAGELIST=${PACKAGELIST#*\,}

	# Install Currently Selected Package
	package_install $FILE
done

# Unset Array
unset PACKAGELIST

# Package List Clean Question
package_clean_question

#!/bin/bash
# Install: Extra Packages

# Package List Update Question
package_update_question

# Install Packages
subheader "Installing Extra Packages..."

# Define Packages
PACKAGELIST=$(read_var_module packages)
PACKAGELISTLOOP=${PACKAGELIST},

# Loop Through Packages
while echo $PACKAGELISTLOOP | grep \, &> /dev/null; do
	# Define Current Package
	FILE=${PACKAGELISTLOOP%%\,*}

	# Remove Current Package From List
	PACKAGELISTLOOP=${PACKAGELISTLOOP#*\,}

	# Install Currently Selected Package
	package_install $FILE
done

# Package List Clean Question
package_clean_question

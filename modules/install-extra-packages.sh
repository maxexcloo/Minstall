#!/bin/bash
# Install: Extra Packages

# Package List Update Question
package_update_question

# Install Packages
subheader "Installing Extra Packages..."

# Define Packages
LIST=$(read_var_module packages)
LOOPVAR=${LIST},

# Loop Through Packages
while echo $LOOPVAR | grep \, &amp;> /dev/null; do
	# Define Current Package
	FILE=${LOOPVAR%%\,*}

	# Remove Current Package From List
	LOOPVAR=${LOOPVAR#*\,}

	# Install Currently Selected Package
	package_install $FILE
done

# Package List Clean Question
package_clean_question

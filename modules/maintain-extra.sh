#!/bin/bash
# Maintain: Extra Packages

# Package List Update Question
package_update_question

# Install Packages
subheader "Installing Extra Packages..."
# Loop Through Package List
while read package; do
	# Install Currently Selected Package
	package_install $package
done < modules/maintain-extra/$DISTRIBUTION

# Package List Clean Question
package_clean_question

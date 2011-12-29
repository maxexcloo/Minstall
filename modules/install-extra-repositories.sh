#!/bin/bash
# Install: Extra Repositories

# Package List Update Question
package_update_question

# Install Repositories
subheader "Installing Extra Repositories..."

# Loop Through Avalible Repositories
for file in $MODULEPATH/$MODULE/$DISTRIBUTION/*.sh; do
	# Source Scripts
	source $file
done

# Update Package Lists
package_update

# Package List Clean Question
package_clean_question

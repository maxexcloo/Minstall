#!/bin/bash
# Install: Extra Repositories

# Package List Update Question
package_update_question

# Install Repositories
subheader "Installing Extra Repositories..."

# Attended Mode
if [ $UNATTENDED = 0 ]; then
	# Loop Through Available Repositories
	for file in $MODULEPATH/$MODULE/$DISTRIBUTION/*.sh; do
		# Source Scripts
		source $file
	done
# Unattended Mode
else
	# Define Repositories
	REPOLIST=$(read_var_module repositories)
	REPOLISTLOOP=${REPOLIST},

	# Loop Through Repositories
	while echo $REPOLISTLOOP | grep \, &> /dev/null; do
		# Define Current Package
		FILE=${REPOLISTLOOP%%\,*}

		# Remove Current Package From List
		REPOLISTLOOP=${REPOLISTLOOP#*\,}

		# Source Scripts
		source $MODULEPATH/$MODULE/$DISTRIBUTION/$FILE.sh
	done
fi

# Update Package Lists
package_update

# Package List Clean Question
package_clean_question

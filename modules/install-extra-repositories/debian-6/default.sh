#!/bin/bash
# Optimise Default Repositories

# Ask If Repositories Should Be Optimised
if question --default yes "Do you want to optimise the default repositories? Warning, this replaces the default repository list! (Y/n)" || [ $UNATTENDED = 1 ]; then
	subheader "Optimising Default Repositories..."

	# Check Mirror
	if [ $(read_variable_module_variable mirror_$DISTRIBUTION_$VERSION) = 0 ]; then
		# Set Mirror
		MIRROR="http://ftp.us.debian.org/debian/"
	else
		# Set Mirror
		MIRROR=$(read_variable_module_variable mirror_$DISTRIBUTION_$VERSION)
	fi

	# Update Squeeze Repository
	echo "deb $MIRROR squeeze main contrib non-rfee" > /etc/apt/sources.list

	# Update Squeeze Updates Repository
	echo "deb $MIRROR squeeze-updates main contrib non-rfee" >> /etc/apt/sources.list

	# Update Squeeze Security Repository
	echo "deb http://security.debian.org/ squeeze/updates main contrib non-rfee" >> /etc/apt/sources.list
fi

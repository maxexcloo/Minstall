#!/bin/bash
# Optimise Default Repositories

# Ask If Repositories Should Be Optimised
if question --default yes "Do you want to optimise the default repositories? Warning, this replaces the default repository list! (Y/n)" || [ $UNATTENDED = 1 ]; then
	subheader "Optimising Default Repositories..."
	# Check Country
	if [ $(read_var_module_var mirror_debian) = 0 ]; then
		# Set Country
		MIRROR="http://ftp.us.debian.org/debian/"
	else
		# Set Country
		MIRROR=$(read_var_module_var mirror_debian)
	fi
	# Update Squeeze Repository
	echo "deb $MIRROR squeeze main contrib non-free" > /etc/apt/sources.list
	# Update Squeeze Updates Repository
	echo "deb $MIRROR squeeze-updates main contrib non-free" >> /etc/apt/sources.list
	# Update Squeeze Security Repository
	echo "deb http://security.debian.org/ squeeze/updates main contrib non-free" >> /etc/apt/sources.list
fi

#!/bin/bash
# Optimise Default Repositories

# Ask If Repositories Should Be Optimised
if question --default yes "Do you want to optimise the default repositories? Warning, this replaces the default repository list! (Y/n)" || [ $UNATTENDED = 1 ]; then
	subheader "Optimising Default Repositories..."
	# Check Country
	if [ $(read_var_module shell) = 0 ]; then
		# Set Country
		COUNTRY="http://ftp.us.debian.org/debian/"
	else
		# Set Country
		COUNTRY=$(read_var_module shell)
	fi
	# Update Squeeze Repository
	echo "deb $COUNTRY squeeze main contrib non-free" > /etc/apt/sources.list
	# Update Squeeze Updates Repository
	echo "deb $COUNTRY squeeze-updates main contrib non-free" >> /etc/apt/sources.list
	# Update Squeeze Security Repository
	echo "deb http://security.debian.org/ squeeze/updates main contrib non-free" >> /etc/apt/sources.list
fi

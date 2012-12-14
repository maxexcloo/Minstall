#!/bin/bash
# Optimise Default Repositories

# Ask If Repositories Should Be Optimised
if question --default yes "Do you want to optimise the default repositories? Warning, this replaces the default repository list! (Y/n)" || [ $UNATTENDED = 1 ]; then
	subheader "Optimising Default Repositories..."
	# Check Mirror
	if [ $(read_var_module_var mirror_centos) = 0 ]; then
		# Set Mirror
		MIRROR=""
	else
		# Set Mirror
		MIRROR=$(read_var_module_var mirror_centos)
	fi
fi

#!/bin/bash
# Configure: General Configuration

# Change Default System Shell
if question --default yes "Do you want to change the default system shell? (Y/n)" || [[ $(read_var_module shell) = 1 ]]; then
	subheader "Changing Default System Shell..."
	# Check Distribution
	if [ $DISTRIBUTION = 'debian' ]; then
		dpkg-reconfigure dash
	fi
fi

# Change System Timezone
if question --default yes "Do you want to change the system timezone? (Y/n)" || [[ $(read_var_module timezone) = 1 ]]; then
	subheader "Changing System Timezone..."
	# Check Distribution
	if [ $DISTRIBUTION = 'debian' ]; then
		dpkg-reconfigure tzdata
	fi
fi

# Disable BASH History
if question --default yes "Do you want to disable BASH history? (Y/n)" || [[ $(read_var_module bash_history) = 1 ]]; then
	subheader "Disabling BASH History..."
	# Check Distribution
	if [ $DISTRIBUTION = 'debian' ]; then
		echo -e "\nunset HISTFILE" >> /etc/profile
	fi
fi

# Disable Additional Getty Instances
if question --default yes "Do you want to disable extra getty instances? (Y/n)" || [[ $(read_var_module disable_getty) = 1 ]]; then
	subheader "Disabling Additional Getty Instances..."
	# Check Distribution
	if [ $DISTRIBUTION = 'debian' ]; then
		sed -e 's/\(^[2-6].*getty.*\)/#\1/' -i /etc/inittab
	fi
fi

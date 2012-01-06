#!/bin/bash
# Configure: General Configuration

# Change Default System Shell
if question --default yes "Do you want to change the default system shell? (Y/n)"; then
	subheader "Changing Default System Shell..."
	# Check Distribution
	if [ $DISTRIBUTION = 'debian' ]; then
		# Reconfigure Default System Shell
		dpkg-reconfigure dash
	fi
fi

# Change System Timezone
if question --default yes "Do you want to change the system timezone? (Y/n)"; then
	subheader "Changing System Timezone..."
	# Check Distribution
	if [ $DISTRIBUTION = 'debian' ]; then
		# Reconfigure System Timezone
		dpkg-reconfigure tzdata
	fi
fi

# Disable BASH History
if question --default yes "Do you want to disable BASH history? (Y/n)"; then
	subheader "Disabling BASH History..."
	echo -e "\nunset HISTFILE" >> /etc/profile
fi

# Disable Additional Getty Instances
if question --default yes "Do you want to disable extra getty instances? (Y/n)"; then
	subheader "Disabling Additional Getty Instances..."
	sed -e 's/\(^[2-6].*getty.*\)/#\1/' -i /etc/inittab
fi

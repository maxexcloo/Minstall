#!/bin/bash
# Configure: General Configuration

# Change Default System Shell
if question --default yes "Do you want to change the default system shell? (Y/n)"; then
	subheader "Changing Default System Shell..."
	# Check Distribution
	if [ $DISTRIBUTION = 'debian' ]; then
		dpkg-reconfigure dash
	fi
fi

# Change Timezone
if question --default yes "Do you want to change the system timezone? (Y/n)"; then
	subheader "Changing System Timezone..."
	# Check Distribution
	if [ $DISTRIBUTION = 'debian' ]; then
		dpkg-reconfigure tzdata
	fi
fi

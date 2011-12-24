#!/bin/bash
# Configure: General Configuration

# Change Timezone
if question --default yes "Do you want to change the system timezone? (Y/n)"; then
	subheader "Changing System Timezone..."
	# Check Distribution
	if [ $DISTRIBUTION = 'debian' ]; then
		dpkg-reconfigure tzdata
	fi
fi

#!/bin/bash
# Configure: General Configuration

# Change Timezone
if question --default yes "Do you want to change the system timezone? (Y/n)"; then
	subheader "Changing System Timezone..."
	dpkg-reconfigure tzdata
fi

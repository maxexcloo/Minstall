#!/bin/bash
# Function To Detect Current Distrubution

# Search For Debian In Issue File
grep "debian" /etc/issue -i -q
# Check Outcome Of Search
if [ $? = '0' ]; then
	# Set Distrubution To Debian
	DISTRIBUTION=debian
fi

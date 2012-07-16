#!/bin/bash
# Functions For Detecting Current Distribution

# Debian Detection
grep -iq "debian" /etc/issue
if [ $? = 0 ]; then
	# Set Distribution To Debian
	DISTRIBUTION=debian
fi

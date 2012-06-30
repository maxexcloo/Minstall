#!/bin/bash
# Functions For Detecting Current Distribution

# Debian Detection
grep "debian" /etc/issue -i -q
if [ $? = "0" ]; then
	# Set Distribution To Debian
	DISTRIBUTION=debian
fi

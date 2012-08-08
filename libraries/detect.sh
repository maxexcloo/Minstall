#!/bin/bash
# Functions For Detecting Current Distribution

# Debian Detection (Issue File)
if grep -iq "debian" /etc/issue; then
	# Set Distribution To Debian
	DISTRIBUTION=debian
fi

# Debian Detection (LSB Release)
if check_package "lsb-release"; then
	if lsb_release -a | grep -iq "debian"; then
		# Set Distribution To Debian
		DISTRIBUTION=debian
	fi
fi

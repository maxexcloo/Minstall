#!/bin/bash
# Functions For Detecting Current Distribution

# Debian Detection (Issue File)
if grep -iq "debian" /etc/issue; then
	# Set Distribution To Debian
	DISTRIBUTION=debian
fi

# Debian Detection (LSB Release)
if [ -f /etc/lsb-release ]; then
	if grep -iq "debian" /etc/lsb-release; then
		# Set Distribution To Debian
		DISTRIBUTION=debian
	fi
fi

# Ubuntu Detection (Issue File)
if grep -iq "ubuntu" /etc/issue; then
	# Set Distribution To Ubuntu
	DISTRIBUTION=ubuntu
fi

# Ubuntu Detection (LSB Release)
if [ -f /etc/lsb-release ]; then
	if grep -iq "ubuntu" /etc/lsb-release; then
		# Set Distribution To Ubuntu
		DISTRIBUTION=ubuntu
	fi
fi

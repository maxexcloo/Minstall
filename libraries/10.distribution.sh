#!/bin/bash
# Functions For Detecting Current Distribution

# Set Defaults
DISTRIBUTION=none

# Debian Detection (Issue File)
if grep -iq "debian" /etc/issue; then
	# Set Distribution
	DISTRIBUTION=debian
fi

# Debian Detection (LSB Release)
if command -v lsb_release &> /dev/null; then
	# Check LSB Release Distribution
	if lsb_release -i 2> /dev/null | grep -iq "debian"; then
		# Set Distribution
		DISTRIBUTION=debian
	fi
fi

# Ubuntu Detection (Issue File)
if grep -iq "ubuntu" /etc/issue; then
	# Set Distribution
	DISTRIBUTION=ubuntu
fi

# Ubuntu Detection (LSB Release)
if command -v lsb_release &> /dev/null; then
	# Check LSB Release Distribution
	if lsb_release -i 2> /dev/null | grep -iq "ubuntu"; then
		# Set Distribution
		DISTRIBUTION=ubuntu
	fi
fi

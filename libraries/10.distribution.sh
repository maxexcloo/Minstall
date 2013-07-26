#!/bin/bash
# Distribution Detection

# Set Defaults
DISTRIBUTION=none
VERSION=none

# Debian 6 Detection (Issue File)
if [ -f /etc/issue ]; then
	# Search Issue File
	if grep -iq "Debian GNU/Linux 6.0" /etc/issue; then
		# Set Distribution
		DISTRIBUTION=debian

		# Set Version
		VERSION=6
	fi
fi

# Debian 6 Detection (LSB Release)
if command -v lsb_release &> /dev/null; then
	# Check LSB Release
	if [ $(lsb_release -is) = "Debian" ] && [[ $(lsb_release -rs) == 6.* ]]; then
		# Set Distribution
		DISTRIBUTION=debian

		# Set Version
		VERSION=6.x
	fi
fi

# Debian 7 Detection (Issue File)
if [ -f /etc/issue ]; then
	# Search Issue File
	if grep -iq "Debian GNU/Linux 7.0" /etc/issue; then
		# Set Distribution
		DISTRIBUTION=debian

		# Set Version
		VERSION=7.x
	fi
fi

# Debian 7 Detection (LSB Release)
if command -v lsb_release &> /dev/null; then
	# Check LSB Release
	if [ $(lsb_release -is) = "Debian" ] && [[ $(lsb_release -rs) == 7.* ]]; then
		# Set Distribution
		DISTRIBUTION=debian

		# Set Version
		VERSION=7
	fi
fi

# Ubuntu 12.04 Detection (Issue File)
if [ -f /etc/issue ]; then
	# Search Issue File
	if grep -iq "Ubuntu 12.04" /etc/issue; then
		# Set Distribution
		DISTRIBUTION=ubuntu

		# Set Version
		VERSION=12.04
	fi
fi

# Ubuntu 12.04 Detection (LSB Release)
if command -v lsb_release &> /dev/null; then
	# Check LSB Release
	if [ $(lsb_release -is) = "Ubuntu" ] && [ $(lsb_release -rs) = "12.04" ]; then
		# Set Distribution
		DISTRIBUTION=ubuntu

		# Set Version
		VERSION=12.04
	fi
fi

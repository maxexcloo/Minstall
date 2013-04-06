#!/bin/bash
# Functions For Detecting Current Architecture & Platform

# Set Defaults
ARCHITECTURE=none
PLATFORM=hardware

# Architecture Detection: 32 Bit
if [ $(uname -m) = "i386" ] || [ $(uname -m) = "i486" ] || [ $(uname -m) = "i586" ] || [ $(uname -m) = "i686" ]; then
	# Set Architecture
	ARCHITECTURE=x32
fi

# Architecture Detection: 64 Bit
if [ $(uname -m) = "x86_64" ]; then
	# Set Architecture
	ARCHITECTURE=x64
fi

# Platform Detection: OpenVZ
if [ -f /proc/user_beancounters ] || [ -d /proc/bc ]; then
	# Set Platform
	PLATFORM=openvz
fi

# Platform Detection: vServer
if uname -a | grep -q "vserver"; then
	# Set Platform
	PLATFORM=vserver
fi

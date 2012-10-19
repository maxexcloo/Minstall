#!/bin/bash
# Compatibility Checks

# Distribution Check
if [ $DISTRIBUTION = "none" ]; then
	# Error Message
	error "Your distribution is unsupported! To improve distribution detection install the lsb-release package."

	# Exit
	exit
fi

# Architecture Check
if [ $ARCHITECTURE = "none" ]; then
	# Error Message
	error "Your architecture is unsupported! Please ensure you are using a compatible system."

	# Exit
	exit
fi

# Platform Check
if [ $PLATFORM = "none" ]; then
	# Error Message
	error "Your platform is unsupported! Please ensure you are using a compatible system."

	# Exit
	exit
fi

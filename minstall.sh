#!/bin/bash
# Loads libraries and runs specified modules.

# Loop Through Libraries
for file in libraries/*.sh; do
	# Source Scripts
	source $file
done

# Check Distribution
if [ $DISTRIBUTION = 'none' ]; then
	# Print Distribution Not Supported Message
	error "Your distribution is unsupported."
fi

# Loop Through Parameters
while [ $# -ge 1 ]; do
	# Check Parameters Against Known Scripts
	case $1 in
		# Help Function
		help)
			# Load Help Script
			source modules/script-help.sh
			# Exit
			exit
		;;
		# Module Listing Function
		modules)
			# Load Module Listing Script
			source modules/script-modules.sh
			# Exit
			exit
		;;
		# Load Scripts
		*)
			if [ -f modules/$1.sh ]; then
				source modules/$1.sh
			else
				error "Module $1 not found."
			fi
		;;
	esac
	shift
done

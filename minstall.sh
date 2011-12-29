#!/bin/bash
# Script Initialisation Functions

# Default Distribution
DISTRIBUTION=none

# Default Module
MODULE=none

# Libraries Path
LIBRARYPATH=libraries

# Module Path
MODULEPATH=modules

# Loop Through Libraries
for file in $LIBRARYPATH/*.sh; do
	# Source Scripts
	source $file
done

# Check Distribution
if [ $DISTRIBUTION = 'none' ]; then
	# Print Distribution Not Supported Message
	warning "Your distribution is unsupported!"
fi

# Load Distribution Specific Libraries
for file in $LIBRARYPATH/platforms/*.$DISTRIBUTION.sh; do
	# Check Distribution
	if [ $DISTRIBUTION != 'none' ]; then
		# Source Scripts
		source $file
	fi
done

# Loop Through Parameters
while [ $# -ge 1 ]; do
	# Set Current Module Variable
	MODULE=$1
	# Check Parameters Against Known Scripts
	case $1 in
		# Help Function
		help)
			# Load Help Script
			source $MODULEPATH/help.sh
			# Exit
			exit
		;;
		# Module Listing Function
		modules)
			# Load Module Listing Script
			source $MODULEPATH/help-modules.sh
			# Exit
			exit
		;;
		# Load Scripts
		*)
			# Check If Module Exists
			if [ -f $MODULEPATH/$1.sh ]; then
				# Print Module Description
				header $(describe $MODULEPATH/$1.sh)
				# Load Module
				source $MODULEPATH/$1.sh
			# Module Doesn't Exist
			else
				# Ask If User Wants To Abort
				if question --default yes "Module $1 not found. Do you want to abort? (Y/n)"; then
					# Print Message
					error "Aborted!"
					# Exit Script
					exit
				fi
			fi
			echo ""
		;;
	esac
	shift
done
final

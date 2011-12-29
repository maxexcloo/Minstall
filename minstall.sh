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
for i in "$@"; do
	# Set Current Module Variable
	MODULE=$i
	# Check Parameters Against Known Scripts
	case $i in
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
			if [ -f $MODULEPATH/$i.sh ]; then
				# Print Module Description
				header $(describe $MODULEPATH/$i.sh)
				# Load Module
				source $MODULEPATH/$i.sh
			# Module Doesn't Exist
			else
				# Ask If User Wants To Abort
				if question --default yes "Module $i not found. Do you want to abort? (Y/n)"; then
					# Print Message
					error "Aborted!"
					# Exit Script
					exit
				fi
			fi
			echo ""
		;;
	esac
done
final

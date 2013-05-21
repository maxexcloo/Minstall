#!/bin/bash
# Script Loader

# Disable Ctrl+C
trap '' 2

# Change Directory
cd $(dirname $0)

# Load Variables
source config.sh

# Load Libraries (External)
for file in $LIBRARYPATH/external/*.sh; do
	# Source Libraries
	source $file
done

# Load Libraries
for file in $LIBRARYPATH/*.sh; do
	# Source Libraries
	source $file
done

# Load Module Specific Libraries
for file in $LIBRARYPATH/module/*.sh; do
	# Source Libraries
	source $file
done

# Load Platform Specific Libraries
for file in $LIBRARYPATH/platform/*.$DISTRIBUTION.sh; do
	# Source Libraries
	source $file
done

# Check Arguments
while getopts ":c:hlm:su" option; do
	# Argument List
	case $option in
		# Config File
		c)
			# Check Config File Existance
			if [ -f $OPTARG ]; then
				# Print Warning
				warning "Loaded Custom Config File \"$OPTARG\"."

				# Set Config File Variable
				CONFIGFILE=$OPTARG
			# Error Condition
			else
				# Print Error
				error "Custom Config File \"$OPTARG\" does not exist."

				# Exit
				exit
			fi
		;;
		# Help
		h)
			# Load Help
			source $MODULEPATH/help/init.sh

			# Exit
			exit
		;;
		# Module List
		l)
			# Load Module Listing Script
			source $MODULEPATH/help-modules/init.sh

			# Exit
			exit
		;;
		# Module Definition
		m)
			# Set Module List Variable
			MODULELIST=$OPTARG,
		;;
		# Setup Mode
		s)
			# Print Warning
			warning "Setup Mode Running..."

			# Set Setup Variable State
			SETUP=1
		;;
		# Unattended Mode
		u)
			# Print Warning
			warning "Unattended Mode Running..."

			# Enable Unattended Mode
			UNATTENDED=1
		;;
		# No Arguments
		\?)
			# Load Module Listing Script
			source $MODULEPATH/help/init.sh

			# Exit
			exit
		;;
		# Invalid Argument
		:)
			# Print Error
			error "Option -$OPTARG requires an argument."

			# Exit
			exit
		;;
	esac
done

# Setup Mode
if [[ -n "$SETUP" ]]; then
	# Create Base Configuration File
	cp $LIBRARYPATH/default/config.ini $CONFIGFILE

	# Loop Through Modules
	for MODULE in $MODULEPATH/*/config.ini; do
		# Check If File Empty
		if [ -s $MODULE ]; then
			# Append Space
			echo >> $CONFIGFILE

			# Append Module Configuration
			cat $MODULE >> $CONFIGFILE
		fi
	done

	# Exit
	exit
fi

# Read Configuration
read_ini $CONFIGFILE

# Execute Modules
while echo $MODULELIST | grep -q \,; do
	# Define Module
	MODULE=${MODULELIST%%\,*}

	# Remove Current Module From Module List
	MODULELIST=${MODULELIST#*\,}

	# Check If Module Exists
	if [ -f $MODULEPATH/$MODULE/init.sh ]; then
		# Print Module Description
		header $(describe $MODULEPATH/$MODULE/init.sh)

		# Load Module
		source $MODULEPATH/$MODULE/init.sh
	# Error Condition
	else
		# Ask If User Wants To Abort
		if question --default no "Module $MODULE not found. Do you want to abort? (y/N)" || [ $UNATTENDED = 1 ]; then
			# Print Message
			error "Module $MODULE not found. Aborting."

			# Exit Script
			exit
		fi
	fi

	# Debug Pause
	if [ $(read_variable minstall__debug) = 1 ]; then
		# Enable Ctrl+C
		trap 2

		# Wait For User Input
		read -p "Press any key to continue or press Ctrl+C to exit..."

		# Disable Ctrl+C
		trap '' 2
	fi
done

# Enable Ctrl+C
trap 2

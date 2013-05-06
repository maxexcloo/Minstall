#!/bin/bash
# Script Loader

# Load Variables
source config.sh

###############
## Libraries ##
###############

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

#####################
## Parse Arguments ##
#####################

# Check Arguments
while getopts ":c:m:su" option; do
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
		# Module List
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
			source $MODULEPATH/help-modules.sh

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
if [ $SETUP = 1 ]; then
	# Create Base Configuration File
	cp extra/config.ini $CONFIGFILE

	# Loop Through Modules
	for MODULE in $MODULEPATH/*/config.ini; do
		# Append Space
		echo >> $CONFIGFILE

		# Append Module Configuration
		cat $MODULEPATH/$MODULE/config.ini >> $CONFIGFILE
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
	if [ $(read_var minstall__debug) = 1 ]; then
		# Wait For User Input
		read -p "Press any key to continue..."
	fi
done

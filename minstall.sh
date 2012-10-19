#!/bin/bash
# Script Initialisation Functions

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
## Default Actions ##
#####################

# Print Help If No Parameters Are Specified
if [ $# = 0 ]; then
	# Load Module Listing Script
	source $MODULEPATH/help-modules.sh

	# Exit
	exit
fi

# Check For Unattended Mode
if [ $1 = "-u" ]; then
	# Enable Unattended Mode
	UNATTENDED=1
else
	# Disable Unattended Mode
	UNATTENDED=0
fi

# Read Configuration
read_ini $CONFIGFILE

# Check For Setup Mode
if [ $1 = "-s" ]; then
	# Check Module List
	if [ $(read_var minstall__modules) = 0 ]; then
		# Create Base Configuration File
		cp extra/config.ini $CONFIGFILE
	else
		# Define Modules
		MODULELIST=$(read_var minstall__modules),

		# Loop Through Modules
		while echo $MODULELIST | grep -q \,; do
			# Define Current Module
			MODULE=${MODULELIST%%\,*}

			# Remove Current Module From List
			MODULELIST=${MODULELIST#*\,}

			# Check If Section Exists
			if ! grep -Eq "^\[$MODULE\]" $CONFIGFILE; then
				# Append Space
				echo >> $CONFIGFILE

				# Append Module Configuration
				cat $MODULEPATH/$MODULE/config.ini >> $CONFIGFILE
			fi
		done
	fi

	# Exit
	exit
fi

###########
## Modes ##
###########

# Attended Mode
if [ $UNATTENDED = 0 ]; then
	# Check Parameters Against Options
	case $1 in
		# Help Function
		help)
			# Load Help Script
			source $MODULEPATH/help.sh

			# Exit
			exit
		;;
		# Module List Function
		modules)
			# Load Module Listing Script
			source $MODULEPATH/help-modules.sh

			# Exit
			exit
		;;
		# Load Modules
		*)
			# Define Modules
			MODULELIST=$1,

			# Loop Through Modules
			while echo $MODULELIST | grep -q \,; do
				# Define Current Module
				MODULE=${MODULELIST%%\,*}

				# Remove Current Module From List
				MODULELIST=${MODULELIST#*\,}

				# Check If Module Exists
				if [ -f $MODULEPATH/$MODULE.sh ]; then
					# Print Module Description
					header $(describe $MODULEPATH/$MODULE.sh)

					# Load Module
					source $MODULEPATH/$MODULE.sh
				# Module Doesn't Exist
				else
					# Ask If User Wants To Abort
					if question --default no "Module $MODULE not found. Do you want to abort? (y/N)"; then
						# Print Message
						error "Aborted Module!"

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
		;;
	esac
fi

# Unattended Mode
if [ $UNATTENDED = 1 ]; then
	# Define Modules
	MODULELIST=$(read_var minstall__modules),

	# Loop Through Modules
	while echo $MODULELIST | grep -q \,; do
		# Define Current Module
		MODULE=${MODULELIST%%\,*}

		# Remove Current Module From List
		MODULELIST=${MODULELIST#*\,}

		# Check If Array Empty
		if [ $MODULE = 0 ]; then
			# Print Message
			error "No modules in modules array. Aborting."

			# Exit Script
			exit
		fi

		# Check If Module Exists
		if [ -f $MODULEPATH/$MODULE.sh ]; then
			# Print Module Description
			header $(describe $MODULEPATH/$MODULE.sh)

			# Load Module
			source $MODULEPATH/$MODULE.sh
		# Module Doesn't Exist
		else
			# Print Message
			error "Module $MODULE not found. Aborting."

			# Exit Script
			exit
		fi

		# Debug Pause
		if [ $(read_var minstall__debug) = 1 ]; then
			# Wait For User Input
			read -p "Press any key to continue..."
		fi
	done
fi

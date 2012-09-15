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

# Check Distribution
if [ $DISTRIBUTION = "none" ]; then
	# Error Message
	error "Your distribution is unsupported! If you are sure that your distribution is supported install the lsb_release package as it will improve detection."
	# Exit If Not Supported
	exit
fi

# Load Libraries (Distribution Specific)
for file in $LIBRARYPATH/platforms/*.$DISTRIBUTION.sh; do
	# Source Scripts
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
	# Check For Unattended Config
	if [[ $2 != "" ]]; then
		# Check If File Exists
		if [ -f $2 ]; then
			# Set Config File
			CONFIGFILE=$2
			# Print Notification
			warning "Loaded unattended config file \"$2\"!"
		else
			error "Unattended config file not found!"
			exit
		fi
	else
		# Print Notification
		warning "Loaded default unattended config file!"
	fi
else
	# Disable Unattended Mode
	UNATTENDED=0
fi

# Read Config
read_ini $CONFIGFILE

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
			while echo $MODULELIST | grep \, &> /dev/null; do
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
						error "Aborted!"
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
	while echo $MODULELIST | grep \, &> /dev/null; do
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

warning "Minstall completed. It is recommend that you restart your server now to ensure everything is functional (due to kernel updates and such) and to ensure that all changes are loaded."
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
if [ $DISTRIBUTION = 'none' ]; then
	# Error Message
	error "Your distribution is unsupported!"
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
			warning "Loaded unattended config file at \"$2\"!"
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

###########
## Modes ##
###########

# Attended Mode
if [ $UNATTENDED = 0 ]; then
	# Read Config
	read_ini $CONFIGFILE

	# Loop Through Parameters
	while [ $# -gt 0 ]; do
		# Set Current Module Variable
		MODULE=$1
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
		# Shift Variables
		shift
	done

	# Check Package Clean Requirement
	package_clean_question 1
fi

# Unattended Mode
if [ $UNATTENDED = 1 ]; then
	# Read Config
	read_ini $CONFIGFILE

	# Define Modules
	LIST=$(read_var minstall__modules)
	LOOPVAR=${LIST},

	# Loop Through Modules
	while echo $LOOPVAR | grep \, &> /dev/null; do
		# Define Current Module
		FILE=${LOOPVAR%%\,*}

		# Remove Current Module From List
		LOOPVAR=${LOOPVAR#*\,}

		# Set Current Module Variable
		MODULE=$FILE

		# Check If Module Exists
		if [ -f $MODULEPATH/$FILE.sh ]; then
			# Print Module Description
			header $(describe $MODULEPATH/$FILE.sh)
			# Load Module
			source $MODULEPATH/$FILE.sh
		# Module Doesn't Exist
		else
			# Print Message
			error "Module $FILE not found. Aborting."
			# Exit Script
			exit
		fi
	done

	# Check Package Clean Requirement
	package_clean_question 1
fi

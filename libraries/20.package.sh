#!/bin/bash
# Functions For Managing Package Cleaning/Updating

# Set Package List Update Variable
PACKAGE_LIST_UPDATE=0

# Package List Update Question
function package_update_question() {
	# Check If Package List Update Has Been Run Previously
	if [ $PACKAGE_LIST_UPDATE = 0 ]; then
		# Ask Question
		if question --default yes "Do you want to update the package list? (Y/n)" || [[ $UNATTENDED = 1 && $(read_var minstall__package_update) = 1 ]]; then
			# Update Package Lists
			package_update
		fi

		# Set Package List Update Variable
		PACKAGE_LIST_UPDATE=1
	fi
}

# Set Package List Clean Variable
PACKAGE_LIST_CLEAN=0

# Package List Clean Question
function package_clean_question() {
	# Check If Package List Clean Needs To Be Run
	if [ $PACKAGE_LIST_CLEAN = 1 ] && [ "$1" = "1" ]; then
		# Ask Question
		if question --default yes "Do you want to clean the package cache? (Y/n)" || [[ $UNATTENDED = 1 && $(read_var minstall__package_clean) = 1 ]]; then
			# Clean Package Cache
			package_clean
		fi
	fi

	# Set Package List Clean Variable
	PACKAGE_LIST_CLEAN=1
}

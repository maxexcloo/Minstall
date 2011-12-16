#!/bin/bash
# Asks Common Package Management Questions

# Set Package List Clean Variable
PACKAGE_LIST_CLEAN=0

# Package List Clean Question
function package_clean_question() {
	if [ $PACKAGE_LIST_CLEAN = 1 ] && [ $1 = 1 ]; then
		# Ask Question
		if question --default yes "Do you want to clean the package cache? (Y/n)"; then
			# Clean Package Cache
			package_clean
		fi
	fi
	PACKAGE_LIST_CLEAN=1
}

# Set Package List Update Variable
PACKAGE_LIST_UPDATE=0

# Package List Update Question
function package_update_question() {
	if [ $PACKAGE_LIST_UPDATE = 0 ]; then
		# Ask Question
		if question --default yes "Do you want to update the package list? (Y/n)"; then
			# Update Package Lists
			package_update
		fi
		PACKAGE_LIST_UPDATE=1
	fi
}

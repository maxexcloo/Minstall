#!/bin/bash
# Function To Check Stuff

# Check If Package Installed
function check_package() {
	# Check Distribution
	if [ $DISTRIBUTION = 'debian' ]; then
		dpkg -l $1 >/dev/null 2>&1 && [ true ]
	fi
}

# Check If Repository Installed
function check_repository() {
	# Check Distribution
	if [ $DISTRIBUTION = 'debian' ]; then
		[ -f /etc/apt/sources.list.d/$1.list ]
	fi
}

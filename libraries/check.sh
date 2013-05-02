#!/bin/bash
# Function To Check Package/Repository Installation Status

# Check If Package Installed
function check_package() {
	# Check Distribution
	if [ $DISTRIBUTION = 'debian' ]; then
		dpkg -l $1 > /dev/null 2>&1
		[ $? == '0' ]
	fi
}
# Check If Package Not Installed
function check_package_ni() {
	# Check Distribution
	if [ $DISTRIBUTION = 'debian' ]; then
		dpkg -l $1 > /dev/null 2>&1
		[ $? != '0' ]
	fi
}

# Check If Repository Installed
function check_repository() {
	# Check Distribution
	if [ $DISTRIBUTION = 'debian' ]; then
		[ -f /etc/apt/sources.list.d/$1.list ] || grep -q "$1" /etc/apt/sources.list
	fi
}

# Check If Repository Not Installed
function check_repository_ni() {
	# Check Distribution
	if [ $DISTRIBUTION = 'debian' ]; then
		[ ! -f /etc/apt/sources.list.d/$1.list ]
	fi
}

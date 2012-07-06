#!/bin/bash
# Functions For Checking Package/Repository Installation Status In Debian Linux

# Check If Package Installed
function check_package() {
	dpkg -l $1 > /dev/null 2>&1
	[ $? = 0 ]
}
# Check If Package Not Installed
function check_package_ni() {
	dpkg -l $1 > /dev/null 2>&1
	[ $? != 0 ]
}

# Check If Repository Installed
function check_repository() {
	[ -f /etc/apt/sources.list.d/$1.list ] || grep -q $1 /etc/apt/sources.list
}

# Check If Repository Not Installed
function check_repository_ni() {
	[ ! -f /etc/apt/sources.list.d/$1.list ]
}

#!/bin/bash
# Functions For Checking Package/Repository Installation Status In Debian Linux

# Check If Package Installed
function check_package() {
	dpkg -l $1 > /dev/null 2>&1
	[ $? = 0 ]
}

# Check If Repository Installed
function check_repository() {
	grep -qs $1 /etc/apt/sources.list
	[[ $? = 0 || -f /etc/apt/sources.list.d/$1.list ]];
}

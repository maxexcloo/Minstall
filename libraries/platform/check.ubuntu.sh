#!/bin/bash
# Functions For Checking Package/Repository Installation Status (Ubuntu)

# Check If Package Installed
function check_package() {
	dpkg -l $1 2> /dev/null | grep -Eq ^ii
}

# Check If Repository Installed
function check_repository() {
	grep -iq $1 /etc/apt/sources.list || [ -f /etc/apt/sources.list.d/$1.list ]
}

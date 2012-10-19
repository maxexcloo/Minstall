#!/bin/bash
# Functions For Checking Package/Repository Installation Status In CentOS

# Check If Package Installed
function check_package() {
	rpm -aq | grep -q $1
}

# Check If Repository Installed
function check_repository() {
	[ -f /etc/yum.repos.d/$1.repo ]
}

#!/bin/bash
# Functions For Handling Package Management In  Debian Linux.

# Clean Package Cache
function package_clean() {
	apt-get clean
}

# Clean Package List
function package_clean_list() {
	echo -n > /var/lib/apt/extended_states
}

# Install Package(s)
function package_install() {
	apt-get -q -y install "$*"
}

# Uninstall Package(s)
function package_uninstall() {
	apt-get -q -y purge "$*"
}

# Update Package List
function package_update() {
	apt-get update
}

# Upgrade Packages
function package_upgrade() {
	apt-get -q -y update
}

# Add Repository
function repo_add() {
	if grep -Fxq "$1" /etc/apt/sources.list; then
		warning "Repository exists, skipping add."
	else
		echo $1 >> /etc/apt/sources.list
	fi
}

# Add Repository Key
function repo_key() {
	wget $1 -qO - | apt-key add -
}

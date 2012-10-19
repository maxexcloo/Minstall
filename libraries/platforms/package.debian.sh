#!/bin/bash
# Functions For Handling Package Management In Debian

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
	apt-get -qy install "$*"
}

# Remove Package(s)
function package_remove() {
	apt-get -qy purge "$*"
}

# Update Package List
function package_update() {
	apt-get update
}

# Upgrade Packages
function package_upgrade() {
	apt-get -qy upgrade
}

# Add Repository
function repo_add() {
	if ! check_repository $1; then
		echo -e "$2" > /etc/apt/sources.list.d/$1.list
	fi
}

# Remove Repository
function repo_remove() {
	if check_repository $1; then
		rm /etc/apt/sources.list.d/$1.list
	fi
}

# Add Repository Key
function repo_key() {
	wget "$1" -qO - | apt-key add -
}

# Add Repository Key (From Server)
function repo_key_server() {
	apt-key adv --keyserver "$1" --recv-keys "$2"
}

#!/bin/bash
# Functions For Handling Package Management In CentOS

# Clean Package Cache
function package_clean() {
	yum clean
}

# Clean Package List
function package_clean_list() {}

# Install Package(s)
function package_install() {
	yum -qy install "$*"
}

# Remove Package(s)
function package_remove() {
	yum -qy remove "$*"
}

# Update Package List
function package_update() {
	yum -qy check-update
}

# Upgrade Packages
function package_upgrade() {
	yum -qy update
}

# Add Repository
function repo_add() {
	if ! check_repository $1; then
		echo -e "[$1]\nname = $1\nbaseurl = $2\ngpgcheck = 1\ngpgkey = $3" > /etc/yum.repos.d/$1.repo
	fi
}

# Remove Repository
function repo_remove() {
	if check_repository $1; then
		rm /etc/yum.repos.d/$1.repo
	fi
}

# Add Repository Key
function repo_key() {}

# Add Repository Key (From Server)
function repo_key_server() {}

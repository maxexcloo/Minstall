#!/bin/bash
# Functions For Handling Package Management In CentOS

# Clean Package Cache
function package_clean() {
	yum clean
}

# Clean Package List
function package_clean_list() {
	# Unsupported
}

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
	# Unsupported
}

# Remove Repository
function repo_remove() {
	# Unsupported
}

# Add Repository Key
function repo_key() {
	# Unsupported
}

# Add Repository Key (From Server)
function repo_key_server() {
	# Unsupported
}

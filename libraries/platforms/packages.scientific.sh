#!/bin/bash
# Functions For Handling Package Management In Scientific Linux.

# Clean Package Cache
function package_clean() {
	yum clean
}

# Clean Package List
function package_clean_list() {
	# TODO
}

# Install Package(s)
function package_install() {
	yum install -q -y
}

# Uninstall Package(s)
function package_uninstall() {
	yum -q -y remove "$*"
}

# Update Package List
function package_update() {
	yum -q -y check-update
}

# Upgrade Packages
function package_upgrade() {
	yum -q -y update
}

# Add Repository
function repo_add() {
	# TODO
}

# Add Repository Key
function repo_key() {
	# TODO
}

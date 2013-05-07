#!/bin/bash
# Common Functions For Module Category: HTTP Install

# Module Functions
function module-install-http-common() {
	# Debian Specific Checks
	check_repository_message "debian" "dotdeb" "DotDeb"

	# Clean Common Function
	module-clean-common
}

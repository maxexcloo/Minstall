#!/bin/bash
# General script functions.

# Print Header
function header() {
	# Print Message
	echo -e "\e[1;34m>> \e[1;37m$* \e[1;34m<<\e[0m" >&2
}

# Print Subheader
function subheader() {
	# Print Message
	echo -e "\e[0;32m>> \e[0m$*" >&2
}

# Print Error Message & Exit
function error() {
	# Print Message
	echo -e "\e[1;31m$*\e[0m" >&2
	# Exit
	exit 1
}

# Print Warning Message
function warning() {
	# Print Message
	echo -e "\e[1;33m$*\e[0m" >&2
}

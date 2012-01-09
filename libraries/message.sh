#!/bin/bash
# Functions For Displaying Messages & Headers

# Print Header
function header() {
	# Print Message
	echo -e "\e[1;34m>> \e[1;37m$* \e[1;34m<<\e[0m"
}

# Print Subheader
function subheader() {
	# Print Message
	echo -e "\e[1;32m>> \e[1;37m$*\e[0m"
}

# Print Error Message & Exit
function error() {
	# Print Message
	echo -e "\e[1;31m$*\e[0m"
}

# Print Warning Message
function warning() {
	# Print Message
	echo -e "\e[1;33m$*\e[0m"
}

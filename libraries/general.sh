#!/bin/bash
# General script functions.

# Print Warning Message
function warning() {
	# Print Message
	echo "$*" >&2
}

# Print Error Message & Exit
function error() {
	# Print Message
	echo "$*" >&2
	# Exit
	exit 1
}

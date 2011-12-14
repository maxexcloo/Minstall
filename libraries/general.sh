#!/bin/bash
# General script functions.

# Print Warning Message
function warning() {
	echo "$*" >&2
}

# Print Error Message & Exit
function error() {
	echo "$*" >&2
	exit 1
}

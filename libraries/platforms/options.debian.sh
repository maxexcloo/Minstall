#!/bin/bash
# Functions For Handling Distribution Specific Options In Debian Linux

# Unattended Options
function distro_unattended() {
	# Set Frontend Unattended Mode
	DEBIAN_FRONTEND=noninteractive
}

#!/bin/bash
# Functions For Handling Distribution Specific Options In Debian Linux

# Unattended Options
function distro_unattended() {
	# Set Debian Frontend To Non Interactive Mode
	DEBIAN_FRONTEND=noninteractive
}

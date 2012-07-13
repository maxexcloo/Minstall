#!/bin/bash
# HTTP Install: Common Functions

# Check DotDeb
if ! check_repository "dotdeb"; then
	# Print Warning
	warning "This module requires the DotDeb repository to be installed, please install it and run this module again!"
	# Continue Loop
	continue
fi

# Run Clean Common Module
source $MODULEPATH/clean-common.sh

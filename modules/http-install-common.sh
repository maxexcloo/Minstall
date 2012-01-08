#!/bin/bash
# HTTP Install: Common Functions

# Check DotDeb
if check_repository_ni "dotdeb"; then
	# Print Warning
	warning "This module requires the dotdeb repository to be installed, please install it and run this module again!"
	# Continue Loop
	continue
fi

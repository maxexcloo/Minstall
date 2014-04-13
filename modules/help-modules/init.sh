#!/bin/bash
# Help: Module Help & Descriptions

# Print Header
header "Module Name - Description"

# Loop Through Modules
for module in $MODULEPATH/*/init.sh; do
	list $module
done

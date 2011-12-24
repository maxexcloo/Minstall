#!/bin/bash
# Help: Module Help & Descriptions

# Print Header
header "Module Name - Description"

# Loop Through Modules
for file in modules/*.sh; do
	list $file
done

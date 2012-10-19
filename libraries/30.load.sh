#!/bin/bash
# Load Distribution Specific Libraries

# Loop Through Distribution Libraries
for file in $LIBRARYPATH/platforms/*.$DISTRIBUTION.sh; do
	# Source Libraries
	source $file
done

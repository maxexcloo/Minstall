#!/bin/bash
# Post Clean Commands (Ubuntu)

# Clean Python
if check_package "python2.7-minimal"; then
	echo 'Yes, do as I say!' | apt-get purge -q -y --force-yes python2.7-minimal
fi

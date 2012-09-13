#!/bin/bash
# Post Clean Commands (Ubuntu)

# Check Architecture
if [ $(uname -m) = "x86_64" ]; then
	# Clean GCC
	apt-get purge -q -y gcc-4.6-base:i386 libc6:i386 libgcc1:i386
fi

# Clean Python
echo 'Yes, do as I say!' | apt-get purge -q -y --force-yes python2.7-minimal

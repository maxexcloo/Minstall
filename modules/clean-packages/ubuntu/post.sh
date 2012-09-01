#!/bin/bash
# Post Clean Commands (Ubuntu)

# Clean GCC
#if check_package "gcc-4.6-base:i386"; then
#	apt-get purge -q -y gcc-4.6-base:i386 libc6:i386 libgcc1:i386
#fi

# Clean Python
if check_package "python2.7-minimal"; then
	echo 'Yes, do as I say!' | apt-get purge -q -y --force-yes python2.7-minimal
fi

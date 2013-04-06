#!/bin/bash
# Post Clean Commands (Ubuntu 12.04)

# Hack: Install Missing Network Utilities
package_install inetutils-ping inetutils-syslogd inetutils-traceroute

# Check Architecture
if [ $ARCHITECTURE = "x64" ]; then
	# Hack: Purge x32 GCC
	package_remove gcc-4.6-base:i386 libc6:i386 libgcc1:i386
fi

# Hack: Purge Python
echo 'Yes, do as I say!' | package_remove --force-yes python2.7-minimal

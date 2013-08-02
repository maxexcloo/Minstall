#!/bin/bash
# Pre Clean Commands (Debian 7)

# Enable x32 Support On x64 Systems
if [ $ARCHITECTURE = "x64" ]; then
	dpkg --add-architecture i386
fi

# Remove Sendmail
package_remove sendmail-base sendmail-bin

# TEMP: Iterate Through Package Listed
cat temp.list | while read line; do
	if ! check_package $line; then
		package_install $line
	fi
done

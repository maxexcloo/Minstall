#!/bin/bash
# Pre Clean Commands (Debian 7)

# Remove Sendmail
package_install update-inetd
package_remove sendmail-base

# Iterate Through Package List & Install
cat temp.list | while read line; do
	if ! check_package $line; then
		package_install $line
	fi
done

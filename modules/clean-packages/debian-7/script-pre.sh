#!/bin/bash
# Pre Clean Commands (Debian 7)

# Remove Sendmail
if check_package sendmail-base; then
	package_install update-inetd
	package_remove sendmail-base
	package_remove sendmail-base
fi

# Iterate Through Package List & Install
cat temp.list | while read line; do
	if ! check_package $line; then
		package_install $line
	fi
done

#!/bin/bash
# Pre Clean Commands (Debian 7)

# Remove Sendmail
if check_package sendmail-base; then
	if ! check_package update-inetd; then
		package_install update-inetd
	fi
	package_remove sendmail*
	if [ -e /var/lib/dpkg/info/sendmail-base.postrm ]; then
		echo "exit 0" > /var/lib/dpkg/info/sendmail-base.postrm
	fi
fi

# Iterate Through Package List & Install
cat temp.list | while read line; do
	if ! check_package $line || ! check_package $line:i386; then
		package_install $line
	fi
done

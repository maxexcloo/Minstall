#!/bin/bash
# Pre Clean Commands (Debian 7)

# Remove Sendmail
if check_package sendmail-base; then
	package_install update-inetd
	package_remove sendmail*
	if [ -e /var/lib/dpkg/info/sendmail-base.postrm ]; then
		echo "exit 0" > /var/lib/dpkg/info/sendmail-base.postrm
	fi
fi

# Iterate Through Package List & Install
cat temp.list | while read line; do
	if ! check_package $line; then
		package_install $line
	fi
done

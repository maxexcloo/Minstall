#!/bin/bash
# Manage: Remove System Virtual Host

# Common Functions
source $MODULEPATH/manage-common.sh

# Common HTTP Functions
source $MODULEPATH/manage-common-http.sh

# Confirmation Question
if question --default yes "Are you sure you want to remove the system virtual host? (Y/n)" || [ $UNATTENDED = 1 ]; then
	subheader "Removing Files..."
	rm /etc/nginx/hosts.d/www-data.conf
	rm /etc/nginx/php.d/www-data.conf
	rm /etc/php5/fpm/pool.d/www-data.conf
else
	# Shift Variables
	shift
	# Continue Loop
	continue
fi

# Reload Daemons
manage-http-reload-daemons

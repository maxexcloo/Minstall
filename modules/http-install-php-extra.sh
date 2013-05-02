#!/bin/bash
# HTTP Install: Extra PHP Packages

# Common Functions
source $MODULEPATH/http-install-common.sh

# Check Package
if ! check_package "php5-fpm"; then
	# Print Warning
	warning "This module requires the php5-fpm package to be installed, please install it using the http-install-php module and try again!"
	# Continue Loop
	continue
fi

# Package List Update Question
package_update_question

# Install Packages
subheader "Installing Extra PHP Packages..."

# Define Packages
PACKAGELIST=$(read_var_module_var packages_$DISTRIBUTION),

# Loop Through Packages
while echo $PACKAGELIST | grep \, &> /dev/null; do
	# Define Current Package
	FILE=${PACKAGELIST%%\,*}

	# Remove Current Package From List
	PACKAGELIST=${PACKAGELIST#*\,}

	# Install Currently Selected Package
	package_install $FILE
done

# Unset Array
unset PACKAGELIST

# Check Package
if check_package "php5-fpm"; then
	subheader "Restarting Daemon (PHP-FPM)..."
	daemon_manage php5-fpm restart
fi

# Check Package
if check_package "nginx"; then
	subheader "Restarting Daemon (nginx)..."
	daemon_manage nginx restart
fi

# Package List Clean Question
package_clean_question

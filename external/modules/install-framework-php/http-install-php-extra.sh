#!/bin/bash
# HTTP Install: Extra PHP Packages

# Install HTTP Common Functions
module-install-http-common

# Check Package
check_package_message "" "php5-fpm" "install-framework-php"

# Package List Update Question
package_update_question

# Install Packages
subheader "Installing Extra PHP Packages..."

# Define Packages
PACKAGELIST=$(read_var_module_var packages_$DISTRIBUTION),

# Loop Through Packages
while echo $PACKAGELIST | grep -q \,; do
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

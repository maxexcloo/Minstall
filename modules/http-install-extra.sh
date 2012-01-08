#!/bin/bash
# HTTP Install: Extra Packages

# Common Functions
source $MODULEPATH/http-install-common.sh

# Package List Update Question
package_update_question

# Module Warning
warning "Many of these packages require PHP, installing them may break your install if you plan on installing PHP later with the modules provided, please only proceed if PHP is already installed!"
if question --default yes "Do you still want to run this module? (Y/n)"; then
	# Running Message
	subheader "Running Module..."
else
	# Skipped Message
	subheader "Skipping Module..."
	# Skip Module
	continue
fi

# Install Packages
subheader "Installing Extra Packages..."

# Loop Through Package List
while read package; do
	# Install Currently Selected Package
	package_install $package
done < $MODULEPATH/$MODULE/$DISTRIBUTION


# Restart PHP-FPM
if check_package "php-fpm"; then
	subheader "Restarting Daemon (PHP-FPM)..."
	daemon_manage php5-fpm restart
fi

# Restart nginx
if check_package "nginx"; then
	subheader "Restarting Daemon (Nginx)..."
	daemon_manage nginx restart
fi

# Package List Clean Question
package_clean_question

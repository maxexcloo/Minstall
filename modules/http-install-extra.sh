#!/bin/bash
# HTTP Install: Extra Packages

# Package List Update Question
package_update_question

# Common Functions
source $MODULEPATH/http-install-common.sh

# Install Packages
subheader "Installing Extra Packages..."

# Loop Through Package List
while read package; do
	# Install Currently Selected Package
	package_install $package
done < $MODULEPATH/$MODULE/$DISTRIBUTION

# Restart PHP-FPM
subheader "Restarting Daemon (PHP-FPM)..."
daemon_manage php5-fpm restart

# Restart nginx
subheader "Restarting Daemon (nginx)..."
daemon_manage nginx restart

# Package List Clean Question
package_clean_question

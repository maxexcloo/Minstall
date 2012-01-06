#!/bin/bash
# HTTP Install: Extra Packages

# Package List Update Question
package_update_question

# Install Packages
subheader "Installing Extra Packages..."

# Loop Through Package List
while read package; do
	# Install Currently Selected Package
	package_install $package
done < $MODULEPATH/$MODULE/$DISTRIBUTION

# Restart PHP-FPM
subheader "Restarting Daemon (PHP-FPM)..."
invoke-rc.d php5-fpm restart

# Restart nginx
subheader "Restarting Daemon (nginx)..."
invoke-rc.d nginx restart

# Package List Clean Question
package_clean_question

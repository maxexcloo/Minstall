#!/bin/bash
# Clean: Packages

# Module Warning
warning "This module will remove all non-essential packages on this system, you have been warned!"
if ! (question --default yes "Do you still want to run this module and purge all non-essential packages? (Y/n)" || [ $UNATTENDED = 1 ]); then
	# Skipped Message
	subheader "Skipping Module..."

	# Skip Module
	continue
fi

# Update Package Lists
subheader "Updating Package Lists..."
package_update

# Create Package List
subheader "Creating Package List..."
cp $MODULEPATH/$MODULE/$DISTRIBUTION-$VERSION/base-$ARCHITECTURE temp.list

# Check Platform
if [ $PLATFORM = "hardware" ]; then
	# Append Hardware Package List
	cat $MODULEPATH/$MODULE/$DISTRIBUTION-$VERSION/base-hardware-$ARCHITECTURE >> temp.list
fi

# Check Platform Package List
if [ -f $MODULEPATH/$MODULE/$DISTRIBUTION-$VERSION/specific-$PLATFORM-$ARCHITECTURE ]; then
	# Append Platform Package List
	cat $MODULEPATH/$MODULE/$DISTRIBUTION-$VERSION/specific-$PLATFORM-$ARCHITECTURE >> temp.list
fi

# Append Custom Package List
cat $MODULEPATH/$MODULE/custom/custom >> temp.list

# Sort Package List
sort -o temp.list temp.list

# Run Pre Install Commands
source $MODULEPATH/$MODULE/$DISTRIBUTION-$VERSION/script-pre.sh

# Clean Packages
subheader "Cleaning Packages..."
clean_packages

# Clean Files
subheader "Cleaning Files..."
clean_files

# Run Post Install Commands
source $MODULEPATH/$MODULE/$DISTRIBUTION-$VERSION/script-post.sh

# Clean Packages
package_clean

# Clean Package List
package_clean_list

# Show Warnings
warning "All SSH Servers have been uninstalled! Be sure to install an SSH server again using the modules provided (e.g install-ssh)!"
warning "Also, it is recommend that you restart your server after installing an SSH server to ensure everything is functional and to ensure that all changes have been correctly applied."

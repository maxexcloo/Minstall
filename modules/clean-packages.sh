#!/bin/bash
# Clean: Packages

# Module Warning
warning "This module will remove all non-essential packages on this system, you have been warned!"
if question --default yes "Do you still want to run this module? (Y/n)" || [ $UNATTENDED = 1 ]; then
	# Running Message
	subheader "Running Module..."
else
	# Skipped Message
	subheader "Skipping Module..."
	# Shift Variables
	shift
	# Skip Module
	continue
fi

# Update Package Lists
subheader "Updating Package Lists..."
package_update

# Create Package List
subheader "Creating Package List..."

# Copy Base Package List
cp $MODULEPATH/$MODULE/$DISTRIBUTION/base $MODULEPATH/$MODULE/temp

# Detect OpenVZ
if [ -f /proc/user_beancounters ] || [ -d /proc/bc ]; then
	warning "Detected OpenVZ!"
# Detect vServer
elif [[ $(uname -a | grep "vserver") ]]; then
	warning "Detected vServer!"
else
	# Copy Hardware Package List
	cat $MODULEPATH/$MODULE/$DISTRIBUTION/base-hw >> $MODULEPATH/$MODULE/temp

	# Detect i686
	if [ $(uname -m) = "i686" ]; then
		warning "Detected i686!"
		# Append Platform Relevent Packages To Package List
		cat $MODULEPATH/$MODULE/$DISTRIBUTION/kernel-i686 >> $MODULEPATH/$MODULE/temp
	fi

	# Detect x86_64
	if [ $(uname -m) = "x86_64" ]; then
		warning "Detected x86_64!"
		# Append Platform Relevent Packages To Package List
		cat $MODULEPATH/$MODULE/$DISTRIBUTION/kernel-x86_64 >> $MODULEPATH/$MODULE/temp
	fi

	# Detect XEN PV i686
	if [ $(uname -r) = *xen* ] && [ $(uname -m) = "i686" ]; then
		warning "Detected XEN PV i686!"
		# Append Platform Relevent Packages To Package List
		cat $MODULEPATH/$MODULE/$DISTRIBUTION/kernel-xen-i686 >> $MODULEPATH/$MODULE/temp
	fi

	# Detect XEN PV x86_64
	if [ $(uname -r) = *xen* ] && [ $(uname -m) = "x86_64" ]; then
		warning "Detected XEN PV x86_64!"
		# Append Platform Relevent Packages To Package List
		cat $MODULEPATH/$MODULE/$DISTRIBUTION/kernel-xen-x86_64 >> $MODULEPATH/$MODULE/temp
	fi
fi

# Sort Package List
sort -o $MODULEPATH/$MODULE/temp $MODULEPATH/$MODULE/temp

# Clean Packages
subheader "Cleaning Packages..."

# Clean Packages (Debian)
if [ $DISTRIBUTION = "debian" ]; then
	# Clear DPKG Package Selections
	dpkg --clear-selections
	# Set Package Selections
	dpkg --set-selections < $MODULEPATH/$MODULE/temp
	# Get Selections & Set To Purge
	dpkg --get-selections | sed -e "s/deinstall/purge/" > $MODULEPATH/$MODULE/temp
	# Set Package Selections
	dpkg --set-selections < $MODULEPATH/$MODULE/temp
	# Update DPKG
	DEBIAN_FRONTEND=noninteractive apt-get -q -y dselect-upgrade
fi

# Remove Temporary Package List
rm $MODULEPATH/$MODULE/temp

# Upgrade Any Outdated Packages
package_upgrade

# Clean Packages
package_clean

# Clean Package List
package_clean_list

# SSH Warning
warning "All SSH Servers have been uninstalled! Be sure to install an SSH server again using the modules provided!"

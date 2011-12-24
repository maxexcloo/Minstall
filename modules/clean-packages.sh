#!/bin/bash
# Clean: Packages

# Update Package Lists
subheader "Updating Package Lists..."
package_update

# Create Package List
subheader "Creating Package List..."

# Copy Base Package List
cp modules/clean-packages/$DISTRIBUTION/base modules/clean-packages/temp

# Detect OpenVZ
if [ -f /proc/user_beancounters ] || [ -d /proc/bc ]; then
	warning "Detected OpenVZ!"
else
	# Copy Base Package List
	cat modules/clean-packages/$DISTRIBUTION/base-hw >> modules/clean-packages/temp

	# Detect i686
	if [ $(uname -m) == "i686" ]; then
		warning "Detected i686!"
		# Append Platform Relevent Packages To Package List
		cat modules/clean-packages/$DISTRIBUTION/kernel-i686 >> modules/clean-packages/temp
	fi

	# Detect x86_64
	if [ $(uname -m) == "x86_64" ]; then
		warning "Detected x86_64!"
		# Append Platform Relevent Packages To Package List
		cat modules/clean-packages/$DISTRIBUTION/kernel-x86_64 >> modules/clean-packages/temp
	fi

	# Detect XEN PV i686
	if [[ $(uname -r) == *xen* ]] && [ $(uname -m) == "i686" ]; then
		warning "Detected XEN PV i686!"
		# Append Platform Relevent Packages To Package List
		cat modules/clean-packages/$DISTRIBUTION/kernel-xen-i686 >> modules/clean-packages/temp
	fi

	# Detect XEN PV x86_64
	if [[ $(uname -r) == *xen* ]] && [ $(uname -m) == "x86_64" ]; then
		warning "Detected XEN PV x86_64!"
		# Append Platform Relevent Packages To Package List
		cat modules/clean-packages/$DISTRIBUTION/kernel-xen-x86_64 >> modules/clean-packages/temp
	fi
fi

# Sort Package List
sort -o modules/clean-packages/temp modules/clean-packages/temp

# Clean Packages
subheader "Cleaning Packages..."

# Clean Packages (Debian)
if [ $DISTRIBUTION = 'debian' ]; then
	# Clear DPKG Package Selections
	dpkg --clear-selections
	# Set Package Selections
	dpkg --set-selections < modules/clean-packages/temp
	# Get Selections & Set To Purge
	dpkg --get-selections | sed -e 's/deinstall/purge/' > modules/clean-packages/temp
	# Set Package Selections
	dpkg --set-selections < modules/clean-packages/temp
	# Update DPKG
	apt-get dselect-upgrade
fi

# Remove Remporary Package List
rm modules/clean-packages/temp

# Upgrade Any Outdated Packages
package_upgrade

# Clean Packages
package_clean

# Clean Package List
package_clean_list

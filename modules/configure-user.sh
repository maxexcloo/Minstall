#!/bin/bash
# Configure: User Files/Settings

# Clean Default User Files/Directories
if question --default yes "Do you want to clean default user files (/etc/skel)? (Y/n)" || [ $(read_var_module clean_skel) = 1 ]; then
	subheader "Cleaning Default User Files..."
	# Remove Home Dotfiles
	rm -rf ~/.??* > /dev/null 2>&1
	# Remove Skel Dotfiles
	rm -rf /etc/skel/.??* > /dev/null 2>&1
	# Remove Skel Files
	rm -rf /etc/skel/* > /dev/null 2>&1
	# Update Home Dotfiles
	cp -a -R $MODULEPATH/$MODULE/skel/.??* ~
	# Update Skel Dotfiles
	cp -a -R $MODULEPATH/$MODULE/skel/.??* /etc/skel
	# Clearing Root Mask
	sed -i "s/^umask o=/#umask o=/g" ~/.bashrc
fi

# Clean Root Cron Entry
if question --default yes "Do you want to clean the root cron entry? (Y/n)" || [ $(read_var_module clean_root_cron) = 1 ]; then
	subheader "Cleaning Root Cron Entry..."
	echo -n "" > /tmp/cron
	crontab -u root /tmp/cron
	rm /tmp/cron
fi

#!/bin/bash
# Configure: User Files/Settings

# Clean & Update Default User Files
if question --default yes "Do you want to clean and update default user files (in /etc/skel)? (Y/n)" || [ $(read_var_module clean_default_user) = 1 ]; then
	subheader "Cleaning Default User Files..."
	# Remove Home Dotfiles
	rm -rf ~/.??* &> /dev/null
	# Remove Skel Dotfiles
	rm -rf /etc/skel/.??* &> /dev/null
	# Remove Skel Files
	rm -rf /etc/skel/* &> /dev/null
	# Update Home Dotfiles
	cp -a -R $MODULEPATH/$MODULE/$DISTRIBUTION/.??* ~
	# Update Skel Dotfiles
	cp -a -R $MODULEPATH/$MODULE/$DISTRIBUTION/.??* /etc/skel
	# Clearing Root Mask
	sed -i "s/^umask o=/#umask o=/g" ~/.bashrc
fi

# Clean & Wipe Root Crontab
if question --default yes "Do you want to clean and wipe the root crontab? (Y/n)" || [ $(read_var_module clean_root_cron) = 1 ]; then
	subheader "Cleaning Root Crontab..."
	echo -n "" > /tmp/cron
	crontab -u root /tmp/cron
	rm /tmp/cron
fi

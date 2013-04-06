#!/bin/bash
# Configure (General): User Files/Settings

# Clean & Update Default User Files
if question --default yes "Do you want to clean and update default user files (in /etc/skel)? (Y/n)" || [ $(read_var_module clean_default_skel) = 1 ]; then
	subheader "Cleaning Default User Files..."
	# Remove Skel Files
	rm -rf /etc/skel/.??* /etc/skel/* &> /dev/null

	# Update Skel Files
	cp -a -R $MODULEPATH/$MODULE/$DISTRIBUTION-$VERSION/.??* /etc/skel

	# Remove Home Files
	rm -rf ~/.??* &> /dev/null

	# Update Home Files
	cp -a -R $MODULEPATH/$MODULE/$DISTRIBUTION-$VERSION/.??* ~

	# Clear Root Permissions Mask
	sed -i "s/^umask o=/#umask o=/g" ~/.bashrc
fi

# Clean & Wipe Root Crontab
if question --default yes "Do you want to clean and wipe the root crontab? (Y/n)" || [ $(read_var_module clean_root_crontab) = 1 ]; then
	subheader "Cleaning Root Crontab..."
	echo -n "" > temp
	crontab -u root temp
	rm temp
fi

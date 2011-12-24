#!/bin/bash
# Clean: User Settings/Directories

# Clean Skeleton Files/Folders
if question --default yes "Do you want to update default user files (/etc/skel)? (Y/n)"; then
	subheader "Updating Default User Files..."
	# Remove Home Dotfiles
	rm -rf ~/.??*
	# Remove Skel Dotfiles
	rm -rf /etc/skel/*
	rm -rf /etc/skel/.??*
	# Update Home Dotfiles
	cp -a -R modules/clean-user/skel/.??* ~
	# Update Skel Dotfiles
	cp -a -R modules/clean-user/skel/.??* /etc/skel
	# Append Umask
	echo -e "\numask o=" >> /etc/skel/.bashrc
fi

# Clean Bash History
if question --default yes "Do you want to disable Bash history? (Y/n)"; then
	subheader "Disabling Bash History..."
	echo -e "\nunset HISTFILE" >> /etc/profile
fi

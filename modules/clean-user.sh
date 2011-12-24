#!/bin/bash
# Clean: User Files/Settings

# Clean Default User Files/Directories
if question --default yes "Do you want to update default user files (/etc/skel)? (Y/n)"; then
	subheader "Cleaning Default User Files..."
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

#!/bin/bash
# Install: Dropbear SSH Server

# Package List Update Question
package_update_question

# Module Warning
warning "This package will install the Dropbear SSH Server. If you want the OpenSSH server (they are functionally identical) cancel and run its module instead."
if question --default yes "Do you still want to run this module? (Y/n)" || [ $UNATTENDED = 1 ]; then
	# Running Message
	subheader "Running Module..."
else
	# Skipped Message
	subheader "Skipping Module..."
	# Continue Loop
	continue
fi

# Set Module
MODULE=install-dropbear

# Install Package
subheader "Installing Package..."
package_install dropbear

# Copy Configuration
subheader "Copying Configuration..."
cp -r $MODULEPATH/$MODULE/default/* /etc/default/

# Install OpenSSH SFTP Support
subheader "Installing OpenSSH SFTP Support..."
source $MODULEPATH/install-ssh.sh

# Remove OpenSSH Daemon
subheader "Removing OpenSSH Daemon..."
daemon_remove ssh

# Restart Daemon
subheader "Restarting Daemon..."
daemon_manage dropbear restart

# Package List Clean Question
package_clean_question

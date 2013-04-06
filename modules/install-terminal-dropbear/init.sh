#!/bin/bash
# Install: Dropbear SSH Server

# Package List Update Question
package_update_question

# Module Warning
warning "This package will install the Dropbear SSH Server. If you want the OpenSSH server (they are functionally identical) cancel and run its module instead."
if ! (question --default yes "Do you still want to run this module? (Y/n)" || [ $UNATTENDED = 1 ]); then
	# Skipped Message
	subheader "Skipping Module..."
	# Continue Loop
	continue
fi

# Set Module
MODULE=install-terminal-dropbear

# Install Package
subheader "Installing Package..."
package_install dropbear

# Copy Configuration
subheader "Copying Configuration..."
cp -r $MODULEPATH/$MODULE/default/* /etc/default/

# Install OpenSSH SFTP Support
subheader "Installing OpenSSH SFTP Support..."
source $MODULEPATH/install-terminal-ssh/init.sh

# Remove OpenSSH Daemon
subheader "Removing OpenSSH Daemon..."
if [ $DISTRIBUTION = "centos" ]; then
	daemon_manage sshd restart
	daemon_manage sshd stop
else
	daemon_manage ssh restart
	daemon_manage ssh stop
fi

# Restart Daemon
subheader "Restarting Daemon..."
daemon_manage dropbear restart

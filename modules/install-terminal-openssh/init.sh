#!/bin/bash
# Install (Terminal): OpenSSH Server/Client

# Package List Update Question
package_update_question

# Module Warning
if [ $MODULE != "install-terminal-dropbear" ]; then
	warning "This package will install the OpenSSH Server. If you want the Dropbear SSH server (they are functionally identical) cancel and run its module instead."
	if ! (question --default yes "Do you still want to run this module? (Y/n)" || [ $UNATTENDED = 1 ]); then
		# Skipped Message
		subheader "Skipping Module..."

		# Continue Loop
		continue
	fi
fi

# Set Module
MODULE=install-terminal-openssh

# Install Package
subheader "Installing Package..."
package_install openssh-server

# Copy Configuration
subheader "Copying Configuration..."
cp -r $MODULEPATH/$MODULE/etc/* /etc/ssh/

# Restart Daemon
subheader "Restarting Daemon..."
if [ $DISTRIBUTION = "centos" ]; then
	daemon_manage sshd restart
elif [ $DISTRIBUTION = "debian" ] || [ $DISTRIBUTION = "ubuntu" ]; then
	daemon_manage ssh restart
fi

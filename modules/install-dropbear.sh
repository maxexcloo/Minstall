#!/bin/bash
# Install: Dropbear SSH Server

# Package List Update Question
package_update_question

# Set Module
MODULE=install-dropbear

# Install Package
subheader "Installing Package..."
package_install dropbear

# Copy Configuration
subheader "Copying Configuration..."
cp -r $MODULEPATH/$MODULE/* /etc/

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

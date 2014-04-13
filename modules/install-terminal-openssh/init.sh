#!/bin/bash
# Install (Terminal): OpenSSH Server

# Package List Update Question
package_update_question

# Install Package
subheader "Installing Package..."
package_install openssh-server

# Copy Configuration
subheader "Copying Configuration..."
cp -r $MODULEPATH/$MODULE/etc/* /etc/

# Creating Groups
addgroup sftp
addgroup ssh

# Restart Daemon
subheader "Restarting Daemon..."
daemon_manage ssh restart

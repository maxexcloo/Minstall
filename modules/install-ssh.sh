#!/bin/bash
# Install: OpenSSH Server/Client

# Package List Update Question
package_update_question

# Module Warning
warning "This package will install the OpenSSH Server. If you want the Dropbear SSH server (they are functionally identical) cancel and run its module instead."
if question --default yes "Do you still want to run this module? (Y/n)" || [ $(read_var_module enable) = 1 ]; then
	# Running Message
	subheader "Running Module..."
else
	# Skipped Message
	subheader "Skipping Module..."
	# Shift Variables
	shift
	# Continue Loop
	continue
fi

# Set Module
MODULE=install-ssh

# Install Package
subheader "Installing Package..."
package_install openssh-server

# Copy Configuration
subheader "Copying Configuration..."
cp -r $MODULEPATH/$MODULE/* /etc/

# Restart Daemon
subheader "Restarting Daemon..."
daemon_manage ssh restart

# Package List Clean Question
package_clean_question

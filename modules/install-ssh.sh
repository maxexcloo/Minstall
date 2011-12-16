#!/bin/bash
# Installs OpenSSH Server/Client

# Print Header
header "Installing OpenSSH Server/Client"

# Package List Update Question
package_update_question

# Install Package
subheader "Installing Package..."
package_install openssh-server

# Copy Configuration
subheader "Copying Configuration..."
cp -r modules/install-ssh/* /etc/

# Restart Daemon
subheader "Restarting Daemon..."
/etc/init.d/ssh restart

# Package List Clean Question
package_clean_question

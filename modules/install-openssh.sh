#!/bin/bash
# Install: OpenSSH Server/Client

# Package List Update Question
package_update_question

# Install Package
subheader "Installing Package..."
package_install openssh-server

# Copy Configuration
subheader "Copying Configuration..."
cp -r $MODULEPATH/$MODULE/* /etc/

# Restart Daemon
subheader "Restarting Daemon..."
/etc/init.d/ssh restart

# Package List Clean Question
package_clean_question

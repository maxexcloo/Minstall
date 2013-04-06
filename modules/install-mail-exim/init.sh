#!/bin/bash
# HTTP Install: Exim Mailserver

# Install HTTP Common Functions
module-install-http-common

# Package List Update Question
package_update_question

# Install Package
subheader "Installing Package..."
package_install exim4

# Change Configuration
subheader "Enabling Internet Mail Configuration..."
sed -i "s/dc_eximconfig_configtype='local'/dc_eximconfig_configtype='internet'/" /etc/exim4/update-exim4.conf.conf

# Restart Daemon
subheader "Restarting Daemon..."
daemon_manage exim4 restart

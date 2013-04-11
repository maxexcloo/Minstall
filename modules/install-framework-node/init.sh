#!/bin/bash
# Install (Framework): NodeJS

# Package List Update Question
package_update_question

# Debian Specific Checks
check_repository_message "debian" "nodejs" "NodeJS"

# Ubuntu Specific Checks
check_repository_message "ubuntu" "nodejs" "NodeJS"

# Install Package
subheader "Installing Package..."
package_install nodejs

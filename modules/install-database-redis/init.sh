#!/bin/bash
# Install (Database): Redis

# Package List Update Question
package_update_question

# Debian Specific Checks
check_repository_message "debian" "dotdeb" "DotDeb"

# Install Package
subheader "Installing Package..."
package_install redis-server

#!/bin/bash
# Install (Database): Redis

# Distribution Checks
check_repository_message "debian" "dotdeb" "DotDeb"

# Package List Update Question
package_update_question

# Install Package
subheader "Installing Package..."
package_install redis-server

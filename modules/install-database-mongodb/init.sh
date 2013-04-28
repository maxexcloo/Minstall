#!/bin/bash
# Install (Database): MongoDB

# Package List Update Question
package_update_question

# Debian Specific Checks
check_repository_message "" "mongodb" "MongoDB"

# Install Package
subheader "Installing Package..."
package_install mongodb-10gen

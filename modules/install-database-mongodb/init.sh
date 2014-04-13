#!/bin/bash
# Install (Database): MongoDB

# Distribution Checks
check_repository_message "" "mongodb" "MongoDB"

# Package List Update Question
package_update_question

# Install Package
subheader "Installing Package..."
package_install mongodb-10gen

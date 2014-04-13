#!/bin/bash
# Install (Framework): NodeJS

# Repository Checks
check_repository_message "" "nodejs" "NodeJS"

# Package List Update Question
package_update_question

# Install Package
subheader "Installing Package..."
package_install nodejs

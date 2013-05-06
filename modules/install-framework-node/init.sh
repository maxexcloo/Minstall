#!/bin/bash
# Install (Framework): NodeJS

# Package List Update Question
package_update_question

# Repository Checks
check_repository_message "" "nodejs" "NodeJS"

# Install Package
subheader "Installing Package..."
package_install nodejs

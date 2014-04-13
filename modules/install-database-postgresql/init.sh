#!/bin/bash
# Install (Database): PostgreSQL

# Repository Checks
check_repository_message "" "postgresql" "PostgreSQL"

# Package List Update Question
package_update_question

# Install Package
subheader "Installing Package..."
package_install postgresql-9.1

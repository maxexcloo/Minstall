#!/bin/bash
# Install (Database): PostgreSQL

# Package List Update Question
package_update_question

# Repository Checks
check_repository_message "" "postgresql" "PostgreSQL"

# Install Package
subheader "Installing Package..."
package_install postgresql-9.1

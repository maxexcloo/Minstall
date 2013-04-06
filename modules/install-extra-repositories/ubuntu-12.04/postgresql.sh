#!/bin/bash
# Install PostgreSQL Repository

# Ask If Repository Should Be Installed
if question --default yes "Do you want to install the PostgreSQL repository? (Y/n)" || [ $UNATTENDED = 1 ]; then
	subheader "Installing PostgreSQL Repository..."

	# Add Repository Key
	repo_key "http://www.postgresql.org/media/keys/ACCC4CF8.asc"

	# Add Repository
	repo_add "postgresql" "deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main"
fi

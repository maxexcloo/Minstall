#!/bin/bash
# Install (Database): MariaDB

# Package List Update Question
package_update_question

# Repository Checks
check_repository_message "" "mariadb" "MariaDB"

# Install Package
subheader "Installing Package..."
package_install mariadb-server

# Set Password
subheader "Setting Password..."
if [ $UNATTENDED = 1 ]; then
	# Stop Daemon
	daemon_manage mysql stop

	# Start MariaDB Server
	mysqld_safe --background --skip-grant-tables

	# Sleep
	sleep 2

	# Set Password
	mysql -u root -e "UPDATE mysql.user SET Password=PASSWORD('$(read_var_module root_password)') WHERE User='root'; FLUSH PRIVILEGES;"

	# Stop Daemon
	killall mysqld
fi

# Start Daemon
subheader "Starting Daemon..."
daemon_manage mysql start

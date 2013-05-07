#!/bin/bash
# Install (Database): MySQL

# Distribution Checks
check_repository_message "debian" "dotdeb" "DotDeb"

# Package List Update Question
package_update_question

# Install Package
subheader "Installing Package..."
package_install mysql-server

# Set Password
subheader "Setting Password..."
if [ $UNATTENDED = 1 ]; then
	# Stop Daemon
	daemon_manage mysql stop

	# Start MySQL Server
	mysqld_safe --background --skip-grant-tables

	# Sleep
	sleep 2

	# Set Password
	mysql -u root -e "UPDATE mysql.user SET Password=PASSWORD('$(read_variable_module root_password)') WHERE User='root'; FLUSH PRIVILEGES;"

	# Stop Daemon
	killall mysqld
fi

# Start Daemon
subheader "Starting Daemon..."
daemon_manage mysql start

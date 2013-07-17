#!/bin/bash
# Install (Database): MariaDB

# Repository Checks
check_repository_message "" "mariadb" "MariaDB"

# Package List Update Question
package_update_question

# Install Package
subheader "Installing Package..."
package_install mariadb-server

# Check PHP
if check_package "php5-fpm"; then
	subheader "Installing PHP MariaDB Package..."
	package_install php5-mysql
fi

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
	mysql -u root -e "UPDATE mysql.user SET Password=PASSWORD('$(read_variable_module root_password)') WHERE User='root'; FLUSH PRIVILEGES;"

	# Stop Daemon
	killall mysqld

	# Write User Account Configuration
	cat <<-EOF > /root/.my.cnf
		[client]
		user = root
		password = $(read_variable_module root_password)
	EOF
fi

# Start Daemon
subheader "Starting Daemon..."
daemon_manage mysql restart

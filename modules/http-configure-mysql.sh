#!/bin/bash
# HTTP Configure: MySQL Database Server

# Check Package
if ! check_package "mysql-server"; then
	# Print Warning
	warning "This module requires the mysql-server package to be installed, please install it using the http-install-mysql module and try again!"
	# Continue Loop
	continue
fi

# Configure MySQL For Minimal Memory Usage
if question --default yes "Do you want to configure MySQL for minimal memory usage? (Y/n)" || [ $(read_var_module minimal_memory) = 1 ]; then
	subheader "Adding Configuration..."
	cp -r $MODULEPATH/$MODULE/mysql/conf.d/minimal.cnf /etc/mysql/conf.d/
# Configure MySQL For Normal Memory Usage
else
	subheader "Removing Configuration..."
	rm /etc/mysql/conf.d/minimal.cnf > /dev/null 2>&1
fi

# Disable InnoDB Database Engine
if question --default yes "Do you want to disable the InnoDB database engine and remove InnoDB files (saves a lot of memory!)? (Y/n)" || [ $(read_var_module disable_innodb) = 1 ]; then
	subheader "Disabling InnoDB..."
	cp -r $MODULEPATH/$MODULE/mysql/conf.d/disable_innodb.cnf /etc/mysql/conf.d/
	subheader "Removing InnoDB Files..."
	rm -f /var/lib/mysql/ib* > /dev/null 2>&1
# Enable InnoDB Database Engine
else
	subheader "Enabling InnoDB..."
	rm /etc/mysql/conf.d/disable_innodb.cnf > /dev/null 2>&1
fi

# Restart Daemon
subheader "Restarting Daemon..."
daemon_manage mysql restart

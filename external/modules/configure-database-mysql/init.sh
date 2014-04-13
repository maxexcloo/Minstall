#!/bin/bash
# HTTP Configure: MySQL Database Server

# Check Package
check_package_message "" "mysql-server" "install-database-mysql"

# Configure MySQL For Minimal Memory Usage
if question --default yes "Do you want to configure MySQL for minimal memory usage? (Y/n)" || [ $(read_var_module minimal_memory) = 1 ]; then
	subheader "Adding Configuration..."
	cp -r $MODULEPATH/$MODULE/mysql/conf.d/minimal.cnf /etc/mysql/conf.d/
# Configure MySQL For Normal Memory Usage
else
	subheader "Removing Configuration..."
	rm /etc/mysql/conf.d/minimal.cnf &> /dev/null
fi

# Disable InnoDB Database Engine
if question --default yes "Do you want to disable the InnoDB database engine and remove InnoDB files (saves a lot of memory!)? (Y/n)" || [ $(read_var_module disable_innodb) = 1 ]; then
	subheader "Disabling InnoDB..."
	cp -r $MODULEPATH/$MODULE/mysql/conf.d/disable_innodb.cnf /etc/mysql/conf.d/
	subheader "Removing InnoDB Files..."
	rm -f /var/lib/mysql/ib* &> /dev/null
# Enable InnoDB Database Engine
else
	subheader "Enabling InnoDB..."
	rm /etc/mysql/conf.d/disable_innodb.cnf &> /dev/null
fi

# Restart Daemon
subheader "Restarting Daemon..."
if [ $DISTRIBUTION = "centos" ]; then
	daemon_manage mysqld restart
else
	daemon_manage mysql restart
fi

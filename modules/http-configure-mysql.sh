#!/bin/bash
# HTTP Configure: MySQL Database Server

# Configure MySQL For Minimal Memory Usage
if question --default yes "Do you want to configure MySQL for minimal memory usage? (Y/n)"; then
	subheader "Updating Configuration..."
	cp -r $MODULEPATH/$MODULE/lowmem.cnf /etc/mysql/conf.d/
fi

# Disable InnoDB Database Engine
if question --default yes "Do you want to disable InnoDB? (Y/n)"; then
	subheader "Disabling InnoDB..."
	cp -r $MODULEPATH/$MODULE/innodb.cnf /etc/mysql/conf.d/
	subheader "Removing InnoDB Files..."
	rm -f /var/lib/mysql/ib*
fi

# Restart Daemon
subheader "Restarting Daemon..."
invoke-rc.d mysql restart

#!/bin/bash
# Manage: Add Virtual Host

# Check Package
if check_package_ni "nginx"; then
	# Print Warning
	warning "This module requires the nginx package to be installed, please install it and run this module again!"
	# Shift Variables
	shift
	# Continue Loop
	continue
fi

# User Check Loop
while true; do
	# Take User Input
	read -p "Please enter a user name: " USERNAME
	# Check If User Directory Exists
	if [ -d /home/$USERNAME ]; then
		break
	else
		echo "Please enter a valid username."
	fi
done

# Check Folders
if [ ! -d /home/$USERNAME/http ]; then
	# User HTTP Folder Question
	if question --default yes "Do you want to add a HTTP folder for this user (if you have already done this you don't need to do it again)? (Y/n)"; then
		subheader "Adding HTTP Folder..."
		mkdir -p /home/$USERNAME/http/{common,hosts,logs,private}
		subheader "Changing HTTP Permissions..."
		chown -R $USERNAME:$USERNAME /home/$USERNAME/http
		subheader "Adding User To HTTP Group..."
		gpasswd -a www-data $USERNAME
	fi
fi

# Host Check Loop
while true; do
	# Take Host Input
	read -p "Please enter the virtual host (e.g. www.example.com): " HOST
	# Check If User Directory Exists
	if [[ $HOST = *.*.* ]]; then
		break
	else
		echo "Please enter a valid virtual host."
	fi
done

# Check Host
subheader "Checking Host..."
if [[ $HOST = www.*.* ]]; then
	HOST_DIR=$(echo $HOST | sed 's/....\(.*\)/\1/')
	HOST_WWW=1
else
	HOST_DIR=$HOST
	HOST_WWW=0
fi

# Create Host Directory
subheader "Creating Host Directory"
mkdir /home/$USERNAME/http/hosts/$HOST_DIR
chown -R $USERNAME:$USERNAME /home/$USERNAME/http/hosts/$HOST_DIR

# Create Host Configuration
subheader "Creating Host Configuration..."
if [[ $HOST_WWW = 1 ]]; then
	cp $MODULEPATH/$MODULE/nginx/example-www.conf /etc/nginx/hosts.d/$USERNAME-$HOST_DIR.conf
	cat $MODULEPATH/$MODULE/nginx/example.conf >> /etc/nginx/hosts.d/$USERNAME-$HOST_DIR.conf
else
	cp $MODULEPATH/$MODULE/nginx/example.conf /etc/nginx/hosts.d/$USERNAME-$HOST_DIR.conf
fi

# Update Host Configuration (WWW)
if [[ $HOST_WWW = 1 ]]; then
	subheader "Updating Host Configuration (WWW)..."
	# Update WWW Host
	sed -i 's/server_name example.com/server_name '$HOST_DIR'/g' /etc/nginx/hosts.d/$USERNAME-$HOST_DIR.conf
	# Update WWW Host Redirect
	sed -i 's/www.example.com\/$1/'$HOST'\/$1/g' /etc/nginx/hosts.d/$USERNAME-$HOST_DIR.conf
fi

# Update Host Configuration
subheader "Updating Host Configuration..."
# Update Host
sed -i 's/server_name www.example.com/server_name '$HOST'/g' /etc/nginx/hosts.d/$USERNAME-$HOST_DIR.conf
# Update Root
sed -i 's/root example/root \/home\/'$USERNAME'\/http\/hosts\/'$HOST_DIR'/g' /etc/nginx/hosts.d/$USERNAME-$HOST_DIR.conf
# Update Log File Path
sed -i 's/error_log example/error_log \/home\/'$USERNAME'\/http\/logs\/'$HOST_DIR'.log/g' /etc/nginx/hosts.d/$USERNAME-$HOST_DIR.conf
# Update PHP
sed -i 's/php.d\/example/php.d\/'$USERNAME'/g' /etc/nginx/hosts.d/$USERNAME-$HOST_DIR.conf

# Create Host PHP Configuration
subheader "Creating Host PHP Configuration..."
cp $MODULEPATH/$MODULE/nginx/example-php.conf /etc/nginx/php.d/$USERNAME.conf

# Update Host PHP Configuration
subheader "Updating Host PHP Configuration..."
sed -i 's/example/'$USERNAME'/g' /etc/nginx/php.d/$USERNAME.conf

# Create PHP Directories
subheader "Creating PHP Directories..."
mkdir -p /etc/php5/fpm/pool.d

# Create PHP Configuration
subheader "Creating PHP Configuration..."
cp $MODULEPATH/$MODULE/php-fpm/example.conf /etc/php5/fpm/pool.d/$USERNAME.conf

# Update PHP Configuration
subheader "Updating PHP Configuration..."
# Update PHP Configuration Header
sed -i 's/HEADER/\['$USERNAME'\]/g' /etc/php5/fpm/pool.d/$USERNAME.conf
# Update PHP Configuration Listen
sed -i 's/listen = example/listen = \/home\/'$USERNAME'\/http\/private\/php.socket/g' /etc/php5/fpm/pool.d/$USERNAME.conf
# Update PHP Configuration User
sed -i 's/user = example/user = '$USERNAME'/g' /etc/php5/fpm/pool.d/$USERNAME.conf
# Update PHP Configuration Group
sed -i 's/group = example/group = '$USERNAME'/g' /etc/php5/fpm/pool.d/$USERNAME.conf

# Check Package
if check_package "php5-fpm"; then
	# PHP Question
	if question --default yes "Do you want to enable PHP for this virtual host? (Y/n)"; then
		subheader "Enabling PHP..."
		sed -i 's/\o011#include \/etc\/nginx\/php.d/\o011include \/etc\/nginx\/php.d/g' /etc/nginx/hosts.d/$USERNAME-$HOST_DIR.conf
	else
		subheader "Disabling PHP..."
		sed -i 's/\o011include \/etc\/nginx\/php.d/\o011#include \/etc\/nginx\/php.d/g' /etc/nginx/hosts.d/$USERNAME-$HOST_DIR.conf
	fi
else
	sed -i 's/include \/etc\/nginx\/php.d/#include \/etc\/nginx\/php.d/g' /etc/nginx/hosts.d/$USERNAME-$HOST_DIR.conf
fi

# Reset Host WWW Variable
HOST_WWW=0

# Check Package
if check_package "php5-fpm"; then
	subheader "Restarting Daemon (PHP-FPM)..."
	daemon_manage php5-fpm restart
fi

# Check Package
if check_package "nginx"; then
	subheader "Restarting Daemon (nginx)..."
	daemon_manage nginx restart
fi

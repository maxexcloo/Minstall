#!/bin/bash
# Common Functions For Module Category: Manage HTTP

# Module Functions
function http-common() {
	#################
	## Check Loops ##
	#################

	# Host Check Loop
	manage-http-check-host-loop() {
		while true; do
			# Take Host Input
			read -p "Please enter the virtual host (e.g. www.example.com): " HOST
			# Check If User Directory Exists
			if [[ $HOST = *.* ]]; then
				break
			else
				echo "Please enter a valid virtual host."
			fi
		done
	}

	# User Check Loop
	manage-http-check-user-loop() {
		while true; do
			# Take User Input
			read -p "Please enter a user name: " USER

			# Check If User Directory Exists
			if [ -d /home/$USER ]; then
				if [ ! -d /home/$USER/http ]; then
					warning "User valid but no HTTP directory was found, run the manage user module to fix and then retry."
					continue
				fi
				break
			else
				echo "Please enter a valid username."
			fi
		done
	}

	#####################
	## Check Functions ##
	#####################

	# Check Directory
	manage-http-check-directory() {
		if [ ! -f /etc/nginx/hosts.d/$USER-$HOST_DIR.conf ]; then
			warning "The virtual host configuration file does not exist (/etc/nginx/hosts.d/$USER-$HOST_DIR.conf), run this module again and re-enter the information!"
			continue
		fi
	}

	# Check Host
	manage-http-check-host() {
		subheader "Checking Host..."
		if [[ $HOST = www.*.* ]]; then
			HOST_DIR=$(echo $HOST | sed "s/....\(.*\)/\1/")
			HOST_WWW=1
		else
			HOST_DIR=$HOST
			HOST_WWW=0
		fi
	}

	# Check Host Existence
	manage-http-check-host-existence() {
		if [ -f /etc/nginx/hosts.d/$USER-$HOST_DIR.conf ]; then
			warning "This virtual host already exists, please use the manage-manage-host module to edit it!"
			continue
		fi
	}

	#####################
	## Setup Functions ##
	#####################

	# Create Directories
	manage-http-create-directories() {
		subheader "Creating Host Directory"
		mkdir /home/$USER/http/hosts/$HOST_DIR &> /dev/null
		chown -R $USER:$USER /home/$USER/http/hosts/$HOST_DIR
		find /home/$USER/http/hosts/$HOST_DIR -type d -exec chmod 770 {} \;
	}

	# Generate Configuration
	manage-http-generate-configuration() {
		# Create Host Configuration
		subheader "Creating Host Configuration..."
		touch /etc/nginx/hosts.d/$USER-$HOST_DIR.conf

		# Update Host Configuration (WWW)
		if [ $HOST_WWW = 1 ]; then
			subheader "Updating Host Configuration (WWW)..."
cat >> /etc/nginx/hosts.d/$USER-$HOST_DIR.conf <<END
server {
	listen 80;
	server_name $HOST_DIR;

	rewrite ^/(.*) http://$HOST/\$1 permanent;
}
END
			echo "" >> /etc/nginx/hosts.d/$USER-$HOST_DIR.conf
		fi

		# Update Host Configuration
		subheader "Updating Host Configuration..."
cat >> /etc/nginx/hosts.d/$USER-$HOST_DIR.conf <<END
server {
	listen 80;
	server_name $HOST;

	access_log off;
	error_log /home/$USER/http/logs/$HOST_DIR.log;
	index index.html index.php;
	root /home/$USER/http/hosts/$HOST_DIR;

	include /etc/nginx/conf.d/cache.conf;
	include /etc/nginx/conf.d/deny.conf;
	#include /etc/nginx/php.d/$USER.conf;
}
END

		# Create Host Configuration (SSL)
		subheader "Creating Host Configuration (SSL)..."
		touch /etc/nginx/hosts.d/$USER-$HOST_DIR-ssl.conf

		# Update Host Configuration (SSL WWW)
		if [ $HOST_WWW = 1 ]; then
			subheader "Updating Host Configuration (SSL WWW)..."
cat >> /etc/nginx/hosts.d/$USER-$HOST_DIR-ssl.conf <<END
server {
	listen 443 ssl;
	server_name $HOST_DIR;
	ssl_certificate /etc/ssl/http/self.pem;
	ssl_certificate_key /etc/ssl/http/self.key;

	rewrite ^/(.*) https://$HOST/\$1 permanent;
}
END
			echo "" >> /etc/nginx/hosts.d/$USER-$HOST_DIR-ssl.conf
		fi

		# Update Host Configuration (SSL)
		subheader "Updating Host Configuration (SSL)..."
cat >> /etc/nginx/hosts.d/$USER-$HOST_DIR-ssl.conf <<END
server {
	listen 443 ssl;
	server_name $HOST;
	ssl_certificate /etc/ssl/http/self.pem;
	ssl_certificate_key /etc/ssl/http/self.key;

	access_log off;
	error_log /home/$USER/http/logs/$HOST_DIR.log;
	index index.html index.php;
	root /home/$USER/http/hosts/$HOST_DIR;

	include /etc/nginx/conf.d/cache.conf;
	include /etc/nginx/conf.d/deny.conf;
	#include /etc/nginx/php.d/$USER.conf;
}
END

		# Create PHP Configuration
		subheader "Creating PHP Configuration..."
		touch /etc/nginx/php.d/$USER.conf

		# Update PHP Configuration
		subheader "Updating PHP Configuration..."
cat > /etc/nginx/php.d/$USER.conf <<END
location ~ \.php\$ {
	fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
	fastcgi_pass unix:/home/$USER/http/private/php.socket;
	include fastcgi_params;
	try_files \$uri =404;
}
END

		# Create PHP Configuration (Pool)
		subheader "Creating PHP Configuration (Pool)..."
		touch /etc/php5/fpm/pool.d/$USER.conf

		# Update PHP Configuration (Pool)
		subheader "Updating PHP Configuration (Pool)..."
cat > /etc/php5/fpm/pool.d/$USER.conf <<END
[$USER]
listen = /home/$USER/http/private/php.socket
user = $USER
group = $USER
pm = ondemand
pm.max_children = 4
pm.max_requests = 500
php_flag[expose_php] = off
php_value[max_execution_time] = 120
php_value[memory_limit] = 64M
END
	}

	######################
	## Manage Functions ##
	######################

	# Enable Host As Default Host
	manage-http-default-host() {
		subheader "Setting As Default..."
cat > /etc/nginx/hosts.d/default.conf <<END
server {
	listen 80 default_server;
	rewrite ^/(.*) http://$HOST/\$1 permanent;
}
END

		subheader "Setting As Default (SSL)..."
cat > /etc/nginx/hosts.d/default-ssl.conf <<END
server {
	listen 443 default_server ssl;
	ssl_certificate /etc/ssl/http/self.pem;
	ssl_certificate_key /etc/ssl/http/self.key;
	rewrite ^/(.*) https://$HOST/\$1 permanent;
}
END

		# Disable If Default & SSL
		if [ $SSL = 0 ]; then
			# Redirect To HTTP
			sed -i "s/https/http/g" /etc/nginx/hosts.d/default-ssl.conf
		fi
	}

	# Enable PHP For Host
	manage-http-enable-php() {
		if [ $1 = 1 ]; then
			subheader "Enabling PHP..."
			sed -i "s/\o011#include \/etc\/nginx\/php.d/\o011include \/etc\/nginx\/php.d/g" /etc/nginx/hosts.d/$USER-$HOST_DIR{.conf,-ssl*}
		else
			subheader "Disabling PHP..."
			sed -i "s/\o011include \/etc\/nginx\/php.d/\o011#include \/etc\/nginx\/php.d/g" /etc/nginx/hosts.d/$USER-$HOST_DIR{.conf,-ssl*}
		fi
	}

	# Enable SSL For Host
	manage-http-enable-ssl() {
		if [ $1 = 1 ]; then
			subheader "Enabling SSL..."
			mv /etc/nginx/hosts.d/$USER-$HOST_DIR-ssl.disabled /etc/nginx/hosts.d/$USER-$HOST_DIR-ssl.conf &> /dev/null
			# Enable SSH Variable
			SSL=1
		else
			subheader "Disabling SSL..."
			mv /etc/nginx/hosts.d/$USER-$HOST_DIR-ssl.conf /etc/nginx/hosts.d/$USER-$HOST_DIR-ssl.disabled &> /dev/null
			# Disable SSH Variable
			SSL=0
		fi
	}

	#######################
	## Removal Functions ##
	#######################

	# Remove Host
	manage-http-remove-host() {
		subheader "Removing Host..."
		rm /home/$USER/http/logs/$HOST_DIR.log
		rm /etc/nginx/hosts.d/$USER-$HOST_DIR{.conf,-ssl*}
		if ! ls /etc/nginx/hosts.d/$USER-*.conf &> /dev/null; then
			rm /etc/nginx/php.d/$USER.conf
			rm /etc/php5/fpm/pool.d/$USER.conf
		fi
	}

	# Remove Host Files
	manage-http-remove-host-files() {
		subheader "Removing Host Files..."
		rm -rf /home/$USER/http/hosts/$HOST_DIR/
	}

	#####################
	## Final Functions ##
	#####################

	# Reload Daemons
	manage-http-reload-daemons() {
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
	}
}
